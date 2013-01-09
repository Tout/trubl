module Tout
  class Version
    MAJOR = 0 unless defined? Tout::Version::MAJOR
    MINOR = 1 unless defined? Tout::Version::MINOR
    PATCH = 0 unless defined? Tout::Version::PATCH
    PRE = nil unless defined? Tout::Version::PRE

    class << self

      # @return [String]
      def to_s
        [MAJOR, MINOR, PATCH, PRE].compact.join('.')
      end

    end

  end
end
