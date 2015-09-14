require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/conditions/regexp_parameters'

describe 'regexp_parameters' do

  context 'When has_parameters is used with 1 argument on a crazy_method with regexp crazy' do

    let(:instance) {
      instance = TestClass.new
    }

    let(:crazy_method) {
      instance.method(:crazy_method)
    }

    it 'should be true as crazy_method has one param with a p on its name' do
      a = RegexpParameters.new
      expect(a.filter(crazy_method.parameters,1,/p/)).to be_truthy
    end

  end

end