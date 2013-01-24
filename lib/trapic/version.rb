module Trapic
  class Version
    MAJOR = 1 unless defined? Trapic::Version::MAJOR
    MINOR = 0 unless defined? Trapic::Version::MINOR
    PATCH = 1 unless defined? Trapic::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
