# This file is autogenerated. Do not edit it by hand. Regenerate it with:
#   srb rbi gems

# typed: strong
#
# If you would like to make changes to this file, great! Please create the gem's shim here:
#
#   https://github.com/sorbet/sorbet-typed/new/master?filename=lib/dry-monads/all/dry-monads.rbi
#
# dry-monads-1.3.1
module Dry
end
module Dry::Monads
  def self.Result(error, **options); end
  def self.all_loaded?; end
  def self.constructors; end
  def self.known_monads; end
  def self.load_monad(name); end
  def self.register_mixin(name, mod); end
  def self.registry; end
  def self.registry=(registry); end
  extend Dry::Monads::Result::Mixin::Constructors
end
module Dry::Monads::Curry
  def self.call(value); end
end
class Dry::Monads::UnwrapError < StandardError
  def initialize(ctx); end
end
class Dry::Monads::InvalidFailureTypeError < StandardError
  def initialize(failure); end
end
class Dry::Monads::ConstructorNotAppliedError < NoMethodError
  def initialize(method_name, constructor_name); end
end
module Dry::Monads::RightBiased
end
module Dry::Monads::RightBiased::Right
  def ===(other); end
  def and(mb); end
  def apply(val = nil); end
  def bind(*args, **kwargs); end
  def curry; end
  def deconstruct; end
  def destructure(*args, **kwargs); end
  def discard; end
  def flatten; end
  def fmap(*arg0); end
  def or(*arg0); end
  def or_fmap(*arg0); end
  def self.included(m); end
  def tee(*args, &block); end
  def value!; end
  def value_or(_val = nil); end
  include Dry::Core::Constants
end
module Dry::Monads::RightBiased::Left
  def and(_); end
  def apply(*arg0); end
  def bind(*arg0); end
  def deconstruct; end
  def discard; end
  def flatten; end
  def fmap(*arg0); end
  def or(*arg0); end
  def or_fmap(*arg0); end
  def self.trace_caller; end
  def tee(*arg0); end
  def value!; end
  def value_or(val = nil); end
end
module Dry::Monads::Transformer
  def fmap2(*args); end
  def fmap3(*args); end
end
module Dry::Monads::ConversionStubs
  def self.[](*method_names); end
end
module Dry::Monads::ConversionStubs::Methods
  def self.to_maybe; end
  def self.to_result; end
  def self.to_validated; end
  def to_maybe; end
  def to_result; end
  def to_validated; end
end
class Dry::Monads::Result
  def failure; end
  def monad; end
  def self.pure(value = nil, &block); end
  def success; end
  def to_monad; end
  def to_result; end
  include Anonymous_Module_19
  include Dry::Monads::Transformer
end
module Anonymous_Module_19
  def to_maybe(*arg0); end
  def to_validated(*arg0); end
end
class Dry::Monads::Result::Success < Dry::Monads::Result
  def either(f, _); end
  def failure?; end
  def flip; end
  def fmap(*args, &block); end
  def initialize(value); end
  def inspect; end
  def result(_, f); end
  def self.[](*value); end
  def self.call(*arg0); end
  def self.to_proc; end
  def success; end
  def success?; end
  def to_s; end
  include Anonymous_Dry_Equalizer_20
  include Dry::Equalizer::Methods
  include Dry::Monads::RightBiased::Right
end
module Anonymous_Dry_Equalizer_20
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
class Dry::Monads::Result::Failure < Dry::Monads::Result
  def ===(other); end
  def either(_, g); end
  def failure; end
  def failure?; end
  def flip; end
  def initialize(value, trace = nil); end
  def inspect; end
  def or(*args); end
  def or_fmap(*args, &block); end
  def result(f, _); end
  def self.[](*value); end
  def self.call(*arg0); end
  def self.to_proc; end
  def success?; end
  def to_s; end
  def trace; end
  def value_or(val = nil); end
  include Anonymous_Dry_Equalizer_21
  include Dry::Equalizer::Methods
  include Dry::Monads::RightBiased::Left
end
module Anonymous_Dry_Equalizer_21
  def cmp?(comparator, other); end
  def hash; end
  def inspect; end
end
module Dry::Monads::Result::Mixin
  include Dry::Monads::Result::Mixin::Constructors
end
module Dry::Monads::Result::Mixin::Constructors
  def Failure(value = nil, &block); end
  def Success(value = nil, &block); end
end
class Dry::Monads::Maybe
end
class Dry::Monads::Maybe::Some < Dry::Monads::Maybe
  def to_result(fail = nil, &block); end
end
class Dry::Monads::Maybe::None < Dry::Monads::Maybe
  def to_result(fail = nil, &block); end
end
class Dry::Monads::Task
  def to_result; end
end
class Dry::Monads::Try
end
class Dry::Monads::Try::Value < Dry::Monads::Try
  def to_result; end
end
class Dry::Monads::Try::Error < Dry::Monads::Try
  def to_result; end
end
class Dry::Monads::Validated
end
class Dry::Monads::Validated::Valid < Dry::Monads::Validated
  def to_result; end
end
class Dry::Monads::Validated::Invalid < Dry::Monads::Validated
  def to_result; end
end
