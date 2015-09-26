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
        transform(where(name(/crazy/), is_public)) do
          inject({p1: 'crazy', p2: 'crazier'})
        end
      end
      instance = CompleteTestClass.new
      expect(instance.crazy_method('boring')).to eq 'This is a crazy method'
      expect(instance.super_crazy_method('borier')).to eq 'This is by far a crazier method'
    end

    it 'should filter crazy_method and and inject the word crazy into param p1 and crazier in p2 ' do
      Aspects.on CompleteTestClass do
        transform(where(name(/crazy/), is_public, neg(name(/^crazy/)))) do
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

context 'When a logic inject transformer is used' do
  let(:klass) {
    Mi_clase_cp.new
  }

  it 'Using before. Should be false the first time. As the original method gets to run.' do
    Aspects.on Mi_clase_cp do
      transform(where name(/m1/)) do
        before do |instance, cont, *args|
          instance.define_singleton_method cont.name do |*args|
            true
          end
        end
      end
    end
    expect(klass.m1(1, 2)).to be_falsey
    expect(klass.m1(1, 2)).to be_truthy #Now is true because we have injected the logic forever.
  end

  it 'Using after. Should be true as the block runs after.' do
    Aspects.on Mi_clase_cp do
      transform(where name(/m1/)) do
        after do |instance, cont, *args|
          true
        end
      end
    end
    expect(klass.m1(1, 2)).to be_truthy
  end

  it 'Using instead_of. Instead of doing 2+3 we do 20+10' do
    Aspects.on Mi_clase_cp do
      transform(where name(/m1/)) do
        instead_of do |instance, cont, *args|
          20 + 10
        end
      end
    end
    expect(klass.m1(1, 2)).to eq 30
  end

end
