require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/aspects'

describe 'Selector' do

  context 'When selector is used on a crazy_method' do

    let(:crazy_method) {
      instance = TestClass.new
      instance.method(:crazy_method)
    }

    let(:super_crazy_method) {
      instance = TestClass.new
      instance.extend TestModule
      instance.method(:super_crazy_method)
    }

    it 'should match crazy_method if /crazy/ is used' do
      block = Aspects.name(/crazy/)
      expect(block.call crazy_method).to be_truthy
    end

    it 'should not match crazy_method if /boring/ is used' do
      block = Aspects.name(/boring/)
      expect(block.call crazy_method).to be_falsey
    end

    it 'should match crazy_method and super_crazy_method if /crazy/ is used' do
      block = Aspects.name(/crazy/)
      expect(block.call crazy_method).to be_truthy
      expect(block.call super_crazy_method).to be_truthy
    end

    it 'should match crazy_method but no super_crazy_method if /^crazy/ is used' do
      block = Aspects.name(/^crazy/)
      expect(block.call crazy_method).to be_truthy
      expect(block.call super_crazy_method).to be_falsey
    end


  end

end