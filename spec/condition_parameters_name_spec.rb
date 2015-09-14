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

    let(:crazy_long_method) {
      instance.method(:crazy_long_method)
    }

    it 'should be true as crazy_method has one param with a p on its name' do
      a = RegexpParameters.new
      expect(a.filter(crazy_method.parameters,1,/p/)).to be_truthy
    end

    it 'should be false as crazy_method has one param with a p on its name and not three' do
      a = RegexpParameters.new
      expect(a.filter(crazy_method.parameters,3,/p/)).to be_falsey
    end

    it 'should be true as crazy_long_method has four param with var on its name' do
      a = RegexpParameters.new
      expect(a.filter(crazy_long_method.parameters,4,/var/)).to be_truthy
    end

    it 'should be true as crazy_long_method has not param with w on its name' do
      a = RegexpParameters.new
      expect(a.filter(crazy_long_method.parameters,0,/w/)).to be_truthy
    end

  end

end