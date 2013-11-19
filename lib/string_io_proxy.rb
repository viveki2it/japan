# -*- encoding : utf-8 -*-
class StringIOProxy < StringIO
  attr_accessor :content_type
  attr_accessor :original_filename
end

Paperclip.io_adapters.register Paperclip::StringioAdapter do |target|
  StringIOProxy === target
end
