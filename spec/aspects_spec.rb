require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  context 'when CompleteTestClass is aspected' do

    it 'should filter crazy_method and inject the word crazy into param p1' do

      instance = CompleteTestClass.new
      Aspects.on instance do
        transform(where(name(/^crazy/))) do
          inject({p1: 'crazy'})
        end
      end


      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'

    end

    it 'should filter crazy_method and super_crazy_method and inject the word crazy into param p1 and crazier in p2 ' do
      Aspects.on CompleteTestClass do
        transform(where(name(/crazy/))) do
          inject({p1: 'crazy', p2: 'crazier'})
        end
      end

      instance = CompleteTestClass.new

      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'
      expect(instance.super_crazy_method('borier')).to eq 'This is by far a crazier method'
    end
  end

end
