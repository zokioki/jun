module Inflector
  def self.included(base)
    base.extend ClassMethods
  end

  PLURAL = {
            '(quiz)$'                     => '\1zes',
            '^(ox)$'                      => '\1en',
            '([m|l])ouse$'                => '\1ice',
            '(matr|vert|ind)ix|ex$'       => '\1ices',
            '(x|ch|ss|sh)$'               => '\1es',
            '([^aeiouy]|qu)y$'            => '\1ies',
            '(hive)$'                     => '\1s',
            '(?:([^f])fe|([lr])f)$'       => '\1\2ves',
            '(shea|lea|loa|thie)f$'       => '\1ves',
            'sis$'                        => 'ses',
            '([ti])um$'                   => '\1a',
            '(tomat|potat|ech|her|vet)o$' => '\1oes',
            '(bu)s$'                      => '\1ses',
            '(alias)$'                    => '\1es',
            '(octop)us$'                  => '\1i',
            '(ax|test)is$'                => '\1es',
            '(us)$'                       => '\1es',
            '([^s]+)$'                    => '\1s'
           }

  SINGULAR = {
              '(quiz)zes$'             => '\1',
              '(matr)ices$'            => '\1ix',
              '(vert|ind)ices$'        => '\1ex',
              '^(ox)en$'               => '\1',
              '(alias)es$'             => '\1',
              '(octop|vir)i$'          => '\1us',
              '(cris|ax|test)es$'      => '\1is',
              '(shoe)s$'               => '\1',
              '(o)es$'                 => '\1',
              '(bus)es$'               => '\1',
              '([m|l])ice$'            => '\1ouse',
              '(x|ch|ss|sh)es$'        => '\1',
              '(m)ovies$'              => '\1ovie',
              '(s)eries$'              => '\1eries',
              '([^aeiouy]|qu)ies$'     => '\1y',
              '([lr])ves$'             => '\1f',
              '(tive)s$'               => '\1',
              '(hive)s$'               => '\1',
              '(li|wi|kni)ves$'        => '\1fe',
              '(shea|loa|lea|thie)ves$'=> '\1f',
              '(^analy)ses$'           => '\1sis',
              '((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$' => '\1\2sis',
              '([ti])a$'               => '\1um',
              '(n)ews$'                => '\1ews',
              '(h|bl)ouses$'           => '\1ouse',
              '(corpse)s$'             => '\1',
              '(us)es$'                => '\1',
              's$'                     => ''
             }

  UNCHANGEABLE = [
                  'sheep',
                  'fish',
                  'deer',
                  'moose',
                  'series',
                  'species',
                  'money',
                  'rice',
                  'information',
                  'equipment'
                 ]

  # Returns the plural form of the string.
  #
  #   "task".pluralize    #=> "tasks"
  #   "octopus".pluralize #=> "octopi"
  #   "fish".singularize  #=> "fish"
  def pluralize
    return self if UNCHANGEABLE.include? self

    pattern, replacement = ""
    PLURAL.each do |k, v|
      if self.match(k)
        pattern = Regexp.new(k)
        replacement = v
        break
      end
    end
    self.sub(pattern, replacement)
  end

  # Returns the singular form of the string.
  #
  #   "tasks".singularize  #=> "task"
  #   "octopi".singularize #=> "octopus"
  #   "fish".singularize   #=> "fish"
  def singularize
    return self if UNCHANGEABLE.include? self

    pattern, replacement = ""
    SINGULAR.each do |k, v|
      if self.match(k)
        pattern = Regexp.new(k)
        replacement = v
        break
      end
    end
    self.sub(pattern, replacement)
  end

  # Converts a string to under_score format.
  #
  #   "HelloThere".underscore #=> "hello_there"
  #   "Foo::BarBaz".underscore #=> "foo/bar_baz"
  def underscore
    gsub(/::/, '/').
    gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
    gsub(/([a-z\d])([A-Z])/,'\1_\2').
    tr("-", "_").
    downcase
  end

  # Converts a string to CamelCase format.
  #
  #   "hello_there".camelize #=> "HelloThere"
  #   "foo/bar_baz".camelize #=> "Foo::BarBaz"
  def camelize
    sub(/^[a-z\d]*/) { |match| match.capitalize }.
    gsub(/(?:_|(\/))([a-z\d]*)/) { "#{$1}#{$2.capitalize}" }.
    gsub("/", "::")
  end

  module ClassMethods
  end
end

class String
  include Inflector
end
