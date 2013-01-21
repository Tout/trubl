module Tout
  class Version
    MAJOR = 1 unless defined? Tout::Version::MAJOR
    MINOR = 0 unless defined? Tout::Version::MINOR
    PATCH = 0 unless defined? Tout::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
