module Trubl
  class Version
    MAJOR = 2  unless defined? Trubl::Version::MAJOR
    MINOR = 0  unless defined? Trubl::Version::MINOR
    PATCH = 1  unless defined? Trubl::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end
    end
  end
end
