require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'redirect_to' do

  include Redirect

  context 'When redirect is used on a crazy_method' do

    let(:instance) {
      instance = TestClass.new
    }

    let(:instance_redirected) {
      instance = TestClassRedirected.new
    }

    let(:method) {
      instance.method(:crazy_method).unbind
    }

    it 'should return This is a boring method if not transformed' do
      expect(instance.crazy_method('boring')).to eq('This is a boring method')
    end

    it 'should raise an ArgumentError Wrong number of arguments (0 for 1) if used without args' do
      expect { redirect_to }.to raise_error ArgumentError, 'wrong number of arguments (0 for 1)'
    end

    it 'should raise a NoMethodError if redirected to an instance with the method not defined' do
      @methods = {method => instance.singleton_class}
      redirect_to(Object.new)
      expect { instance.crazy_method('crazy') }.to raise_error NoMethodError
    end

    it 'should return This is a redirected method if its redirected to instance_redirected' do
      @methods = {method => instance.singleton_class}
      redirect_to(instance_redirected)
      expect(instance.crazy_method('crazy')).to eq('This is a redirected crazy method')
    end

  end


end