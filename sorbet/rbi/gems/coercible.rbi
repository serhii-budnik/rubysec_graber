# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/coercible/all/coercible.rbi
#
# coercible-1.0.0
module Coercible
  def self.rbx?; end
end
module Coercible::Options
  def accept_options(*new_options); end
  def accepted_options; end
  def add_accepted_options(new_options); end
  def define_option_method(option); end
  def inherited(descendant); end
  def options; end
  def self.extended(descendant); end
  def set_options(new_options); end
end
class Coercible::Options::Undefined
end
module Coercible::TypeLookup
  def determine_type(class_or_name); end
  def determine_type_and_cache(class_or_name); end
  def determine_type_from_descendant(descendant); end
  def determine_type_from_primitive(primitive); end
  def determine_type_from_string(string); end
  def primitive; end
  def self.extended(model); end
end
class Coercible::Configuration
  def self.build(keys, &block); end
end
class Coercible::Coercer
  def [](klass); end
  def coercers; end
  def config; end
  def config_for(coercer); end
  def initialize(config, coercers = nil); end
  def initialize_coercer(klass); end
  def self.config_keys; end
  def self.configurable_coercers(&block); end
  def self.new(&block); end
end
module Coercible::Coercer::Configurable
  def config(&block); end
  def config_name; end
  def configuration_class; end
  def self.extended(coercer); end
end
class Coercible::Coercer::Object
  def coerce_with_method(value, method, ref_method); end
  def coerced?(value); end
  def coercers; end
  def initialize(coercers = nil); end
  def inspect; end
  def method_missing(method, *args); end
  def raise_unsupported_coercion(value, method); end
  def self.primitive(value = nil); end
  def to_array(value); end
  def to_hash(value); end
  def to_integer(value); end
  def to_string(value); end
  extend Coercible::TypeLookup
  extend DescendantsTracker
end
class Coercible::Coercer::Numeric < Coercible::Coercer::Object
  def to_decimal(value); end
  def to_float(value); end
  def to_integer(value); end
  def to_string(value); end
end
class Coercible::Coercer::Float < Coercible::Coercer::Numeric
  def to_datetime(value); end
  def to_float(value); end
end
class Coercible::Coercer::Integer < Coercible::Coercer::Numeric
  def boolean_map; end
  def datetime_format; end
  def datetime_proc; end
  def initialize(coercer = nil, config = nil); end
  def self.config; end
  def self.config_keys(value = nil); end
  def to_boolean(value); end
  def to_datetime(value); end
  def to_integer(value); end
  def to_string(value); end
  extend Coercible::Coercer::Configurable
end
class Coercible::Coercer::Decimal < Coercible::Coercer::Numeric
  def to_decimal(value); end
  def to_string(value); end
end
class Coercible::Coercer::String < Coercible::Coercer::Object
  def boolean_map; end
  def constant_lookup(mod, name); end
  def initialize(coercer = nil, config = nil); end
  def parse_value(parser, value, method); end
  def self.config; end
  def self.config_keys(value = nil); end
  def to_boolean(value); end
  def to_constant(value); end
  def to_date(value); end
  def to_datetime(value); end
  def to_decimal(value); end
  def to_float(value); end
  def to_integer(value); end
  def to_numeric(value, method); end
  def to_symbol(value); end
  def to_time(value); end
  extend Coercible::Coercer::Configurable
end
class Coercible::Coercer::Symbol < Coercible::Coercer::Object
  def to_string(value); end
end
module Coercible::Coercer::TimeCoercions
  def coerce_with_method(value, method); end
  def to_date(value); end
  def to_datetime(value); end
  def to_string(value); end
  def to_time(value); end
end
class Coercible::Coercer::Date < Coercible::Coercer::Object
  def to_date(value); end
  include Coercible::Coercer::TimeCoercions
end
class Coercible::Coercer::DateTime < Coercible::Coercer::Object
  def to_datetime(value); end
  include Coercible::Coercer::TimeCoercions
end
class Coercible::Coercer::Time < Coercible::Coercer::Object
  def to_integer(value); end
  def to_time(value); end
  include Coercible::Coercer::TimeCoercions
end
class Coercible::Coercer::FalseClass < Coercible::Coercer::Object
  def to_string(value); end
end
class Coercible::Coercer::TrueClass < Coercible::Coercer::Object
  def to_string(value); end
end
class Coercible::Coercer::Array < Coercible::Coercer::Object
  def to_set(value); end
end
class Coercible::Coercer::Hash < Coercible::Coercer::Object
  def extract(value); end
  def to_date(value); end
  def to_datetime(value); end
  def to_time(value); end
end
class Coercible::UnsupportedCoercion < StandardError
end
