module ReTout
  class Version
    MAJOR = 1 unless defined? ReTout::Version::MAJOR
    MINOR = 0 unless defined? ReTout::Version::MINOR
    PATCH = 0 unless defined? ReTout::Version::PATCH

    class << self

      def to_s
        [MAJOR, MINOR, PATCH].compact.join('.')
      end

    end

  end
end
