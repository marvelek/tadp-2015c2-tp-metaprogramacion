require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/aspects'


describe 'Visibility' do

  let(:dummy_instance){
    dummy_instance = Dummy_class2.new
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
     block = (Aspects.on Dummy_class2 do where name(/bar/),is_private end)
     expect(block).to eq([:bar])
     end
    end

end