require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/transformers/inject_logic'

describe 'Inject_logic' do
  include Inject_logic

  context 'When a logic inject is used' do

    let(:instance) {
      instance = Mi_clase.new
    }

    let(:m1) {
      instance.method(:m1).unbind
    }

    it 'Using before. Should be false the first time. As the original method gets to run.' do
      @methods = {m1 => instance.singleton_class}
      before do |instance,cont,*args|
        instance.send :define_method, cont.name do |*args|
          true
        end
      end
      expect(instance.m1(1,2)).to be_falsey
      expect(instance.m1(1,2)).to be_truthy #Now is true because we have injected the logic forever.
    end

    it 'Using after. Should be true as the block runs after.' do
      @methods = {m1 => instance.singleton_class}
      after do |instance,cont,*args|
        true
      end
      expect(instance.m1(1,2)).to be_truthy
    end

    it 'Using instead_of. Instead of doing 2+3 we do 20+10' do
      @methods = {m1 => instance.singleton_class}
      instead_of do |instance,cont,*args|
        20 + 10
      end
      expect(instance.m1(1,2)).to eq 30
    end

  end
end