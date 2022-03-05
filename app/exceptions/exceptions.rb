module Exceptions
  class MissingSearchParam < StandardError; end
  class InvalidZipcode < StandardError; end
  class NotAuthorized < StandardError; end
end