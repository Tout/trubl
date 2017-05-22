module Trubl
  class Version
    MAJOR = 1  unless defined? Trubl::Version::MAJOR
    MINOR = 9  unless defined? Trubl::Version::MINOR
    PATCH = 4 unless defined? Trubl::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
