module Trubl
  class Version
    MAJOR = 1  unless defined? Trubl::Version::MAJOR
    MINOR = 6  unless defined? Trubl::Version::MINOR
    PATCH = 0 unless defined? Trubl::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
