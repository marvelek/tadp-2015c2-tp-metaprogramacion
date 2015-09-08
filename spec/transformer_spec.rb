require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/aspectable'

describe 'Transformers' do

  context 'When inject is used on a crazy_method with a single p1 argument' do

    let(:instance) {
      instance = TestClass.new
      instance.extend(AspectableObject)
    }

    let(:method) {
      instance.get_aspectable_method(:crazy_method)
    }

    it 'should return This is a boring method if not transformed' do
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a boring method')
    end

    it 'should return This is a crazy method if p1 is injected' do
      instance.inject({p1: 'crazy'}).call(method)
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a crazy method')
    end

    it 'should return This is a boring method if p2 is injected' do
      instance.inject({p2: 'crazy'}).call(method)
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a boring method')
    end

  end
end