module Pageflow
  class AudioFile < ActiveRecord::Base
    include HostedFile
    include EncodedFileStateMachine

    belongs_to :confirmed_by, :class_name => 'User'

    after_initialize do
      self.state ||= 'not_uploaded_to_s3'
    end

    def attachment_s3_url
      "s3://#{File.join(attachment_on_s3.bucket_name, attachment_on_s3.path)}"
    end

    def m4a
      ZencoderAttachment.new(self, "audio.m4a")
    end

    def mp3
      ZencoderAttachment.new(self, "audio.mp3")
    end

    def ogg
      ZencoderAttachment.new(self, "audio.ogg")
    end

    def output_definition
      ZencoderAudioOutputDefinition.new(self)
    end

    def meta_data_attributes=(attributes)
      self.attributes = attributes.symbolize_keys.slice(:format, :duration_in_ms)
    end
  end
end
