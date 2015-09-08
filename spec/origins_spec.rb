require 'rspec'
require_relative '../src/aspects'

describe 'origins sources' do

  context 'when origins are class, modules and objects' do

    it 'sources without duplicate' do
      sources = Aspects.get_sources([Foo, J12, Foo, XX12X, GJ2, XX12X])
      expect(sources).to contain_exactly(Foo, J12, XX12X, GJ2)
    end

    it 'get 2 source from one class and one object' do
      sources = Aspects.get_sources([Foo, Foo.new])
      expect(sources.size).to equal(2)
    end

    it 'get 2 source from one class with mixin included and one object' do
      sources = Aspects.get_sources([ABA1, XX12X.new])
      expect(sources.size).to equal(2)
    end
  end

  context 'empty origin' do
    it 'throws an NonMatchingOriginException' do
      expect { Aspects.get_sources([/Trulala/]) }.to raise_error(NonMatchingOriginException)
    end
  end

  context 'when origins have some regexp' do
    let(:sources) {
      Aspects.get_sources([/1/, /XX/, /[X]12/])
    }
    it 'sources should be exactly...' do
      expect(sources).to contain_exactly(J12, XX12X, X123XX, ABA1)
    end

    it 'sources should not contain A35X' do
      expect(sources).to_not contain_exactly(A35X)
    end

    it 'should get 4 sources when regexp is /2/' do
      sources_regexp_2 = Aspects.get_sources([/2/])
      expect(sources_regexp_2.size).to equal(4)
    end
  end

  context 'when origins are class,modules, objects and regexp' do
    #To Do: tests!
  end
end


#Dummy seed-test
module GJ2
end
module ZZ
end
module J12
end
class XX12X
end
class X123XX
end
class A35X
end
class Foo
end
class ABA1
  extend J12
end