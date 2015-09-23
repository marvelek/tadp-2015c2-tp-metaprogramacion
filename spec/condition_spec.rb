require 'rspec'
require_relative '../src/domain_mock'

describe 'Name' do

  context 'When selector is used on a crazy_method' do

    let(:instance) {
      instance = TestClass.new
    }

    let(:crazy_method) {
      instance.method(:crazy_method)
    }

    let(:super_crazy_method) {
      instance.extend TestModule
      instance.method(:super_crazy_method)
    }

    it 'should raise ArgumentError wrong number of arguments (0 for 1) if no regex is given' do
      expect { instance.name() }.to raise_error ArgumentError, 'wrong number of arguments (0 for 1)'
    end

    it 'should match crazy_method if /crazy/ is used' do
      block = instance.name(/crazy/)
      expect(block.call crazy_method).to be_truthy
    end

    it 'should not match crazy_method if /boring/ is used' do
      block = instance.selector(/boring/)
      expect(block.call crazy_method).to be_falsey
    end

    it 'should match crazy_method and super_crazy_method if /crazy/ is used' do
      block = instance.selector(/crazy/)
      expect(block.call crazy_method).to be_truthy
      expect(block.call super_crazy_method).to be_truthy
    end

    it 'should match crazy_method but no super_crazy_method if /^crazy/ is used' do
      block = instance.selector(/^crazy/)
      expect(block.call crazy_method).to be_truthy
      expect(block.call super_crazy_method).to be_falsey
    end


  end
end