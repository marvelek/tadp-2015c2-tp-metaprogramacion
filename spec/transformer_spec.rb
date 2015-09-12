require 'rspec'
require_relative '../src/domain_mock'
require_relative '../src/aspectable'

describe 'Inject' do

  context 'When inject is used on a crazy_method with a single p1 param' do

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

    it 'should raise an ArgumentError Wrong number of arguments (0 for 1) if used without args' do
      expect { instance.inject }.to raise_error ArgumentError, 'wrong number of arguments (0 for 1)'
    end

    it 'should raise an ArgumentError Empty hash if an empty hash is used' do
      expect { instance.inject({}) }.to raise_error ArgumentError, 'empty hash'
    end

    it 'should return This is a crazy method if p1 is injected' do
      instance.inject({p1: 'crazy'})
      instance.transformer_command[0].call(method)
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a crazy method')
    end

    it 'should return This is a boring method if p2 is injected' do
      instance.inject({p2: 'crazy'})
      instance.transformer_command[0].call(method)
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a boring method')
    end

    it 'should return This is a crazy(crazy_method->boring) method if a a proc is injected' do
      instance.inject({p1: proc { |receptor, mensaje, arg_anterior|
                        "crazy(#{mensaje}->#{arg_anterior})" }})
      instance.transformer_command[0].call(method)
      ret = instance.crazy_method('boring')
      expect(ret).to eq('This is a crazy(crazy_method->boring) method')
    end

  end

  context 'When inject is used on a crazy_method with a single p1 param and on a super_crazy_method with a p2 param' do

    let(:instance) {
      instance = TestClass.new
      instance.extend(AspectableObject)
    }

    let(:crazy_method) {
      instance.get_aspectable_method(:crazy_method)
    }

    let(:super_crazy_method) {
      instance.extend(TestModule)
      instance.get_aspectable_method(:super_crazy_method)
    }

    it 'should transform both methods' do
      instance.inject({p1: 'crazy', p2: 'crazier'})
      instance.transformer_command[0].call(crazy_method)
      instance.transformer_command[0].call(super_crazy_method)
      ret_1 = instance.crazy_method('boring')
      ret_2 = instance.super_crazy_method('borier')
      expect(ret_1).to eq('This is a crazy method')
      expect(ret_2).to eq('This is a by far a crazier method')
    end

  end

end