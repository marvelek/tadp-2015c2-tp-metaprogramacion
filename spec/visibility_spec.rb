require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/aspects'


describe 'Visibility' do

  let(:dummy_instance){
    dummy_instance = Dummy_class2.new
    dummy_instance.extend(Visibility)
  }

  let(:dummy_private_method){
    dummy_instance.method(:bar)
  }

  let(:dummy_public_method){
    dummy_instance.method(:dat_method)
  }

  let(:dummy_singleton_class){
    dummy_singleton_class.singleton_class
  }

  context 'when is asked if private method is private it should be true' do
    let(:privatize){
      Aspects.is_private
    }

    it 'it should contain the bar method in the private ones' do
     block = dummy_instance.is_private
     expect(block.call dummy_private_method).to be_truthy
     end
    end

end