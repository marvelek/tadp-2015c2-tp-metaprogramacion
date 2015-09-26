require 'rspec'
require_relative '../src/conditions/neg'
require_relative '../src/domain_mock'
require_relative '../src/conditions/visibility'
require_relative '../src/conditions/name'

describe 'My behaviour' do

  include Name

  let(:dummy_instance) {
    dummy_instance = Dummy_class22.new
    dummy_instance.extend(Name)
    dummy_instance.extend(Neg)
    dummy_instance.extend(Visibility)
  }

  let(:dummy_private_method) {
    dummy_instance.method(:bar)
  }

  let(:dummy_public_method) {
    dummy_instance.method(:dat_method)
  }

  let(:dummy_singleton_class) {
    dummy_singleton_class.singleton_class
  }

  context 'when is asked if private method is private it should be true' do
    it 'should not call the private method as neg is telling the instance not to do it' do
      block = dummy_instance.neg(name(/dat/))
      expect(block.call dummy_public_method).to be_falsey
    end
  end
end