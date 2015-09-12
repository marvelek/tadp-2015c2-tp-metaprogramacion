require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  before(:each) do
    class CompleteTestClass
      alias old_crazy_method crazy_method
      alias old_super_crazy_method crazy_method
    end
  end

  after(:each) do
    class CompleteTestClass
      alias crazy_method old_crazy_method
      alias crazy_method old_super_crazy_method
    end
  end

  context 'when CompleteTestClass is aspected' do

    it 'should filter crazy_method and inject the word crazy into param p1' do

      Aspects.on CompleteTestClass do
        transform(where(selector(/^crazy/))) do
          inject({p1: 'crazy'})
        end
      end

      instance = CompleteTestClass.new

      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'

    end

    it 'should filter crazy_method and super_crazy_method and inject the word crazy into param p1 and crazier in p2 ' do
      Aspects.on CompleteTestClass do
        transform(where(selector(/crazy/))) do
          inject({p1: 'loco', p2: 'crazier'})
        end
      end

      instance = CompleteTestClass.new

      expect(instance.crazy_method('boring')).to eq 'This is a loco method'
      expect(instance.super_crazy_method('borier')).to eq 'This is by far a crazier method'
    end
  end

end
