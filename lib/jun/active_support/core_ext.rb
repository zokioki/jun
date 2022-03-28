# frozen_string_literal: true

Dir[File.expand_path("core_ext/**/*.rb", __dir__)].sort.each do |filepath|
  require_relative filepath
end
