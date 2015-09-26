require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  context 'when tests from the assignment are executed' do

    Aspects.on MiClase do
      transform(where has_parameters(1, /p2/)) do
        inject(p2: 'bar')
      end
    end
    instancia = MiClase.new

    it 'should return foo-bar if hace_algo("foo")' do
      expect(instancia.hace_algo("foo")).to eq "foo-bar"
    end

    it 'should return foo-bar if hace_algo("foo", "foo")' do
      expect(instancia.hace_algo("foo", "foo")).to eq "foo-bar"
    end

    it 'should return bar:foo if hace_otra_cosa("foo", "foo")' do
      expect(instancia.hace_otra_cosa("foo", "foo")).to eq "bar:foo"
    end

  end

  context 'when CompleteTestClass is aspected' do

    it 'should filter crazy_method and inject the word crazy into param p1' do

      instance = CompleteTestClass.new
      instance2 = CompleteTestClass.new
      Aspects.on instance do
        transform(where(name(/^crazy/))) do
          inject({p1: 'crazy'})
          redirect_to(instance2)
        end
      end


      expect(instance.crazy_method('boring')).to eq 'This is a boring method'

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

    it 'should filter crazy_method and and inject the word crazy into param p1 and crazier in p2 ' do
      Aspects.on CompleteTestClass do
        transform(where(name(/crazy/),is_public)) do
          inject({p1: 'crazy', p2: 'crazier'})
        end
      end
      instance = CompleteTestClass.new
      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'
      expect(instance.super_crazy_method('borier')).to eq 'This is by far a crazier method'
    end

    it 'should filter crazy_method and and inject the word crazy into param p1 and crazier in p2 ' do
      Aspects.on CompleteTestClass do
        transform(where(name(/crazy/),is_public,neg(name(/^crazy/)))) do
          inject({p1: 'crazy'})
        end
      end
      instance = CompleteTestClass.new
      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'
    end

  end

  it 'should modify the method outside Aspect s block' do
    Aspects.on Dummy_class2 do
      transform(where name(/saludar/)) do
        redirect_to(Dummy_class3.new)
      end
    end

    expect(Dummy_class2.new.saludar('Mundo')).to eq 'Adiosin, Mundo'
  end

end
