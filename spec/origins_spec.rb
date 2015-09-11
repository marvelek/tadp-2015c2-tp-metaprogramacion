require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'origins sources' do

  context 'when origins are class, modules and objects' do

    it 'sources without duplicate' do
      sources = Aspects.get_sources([Dummy_class1, Dummy_class2, Dummy_class1, Dummy_mixin2, Dummy_class_mixin2, Dummy_class2])
      expect(sources).to contain_exactly(Dummy_class1, Dummy_class2, Dummy_mixin2, Dummy_class_mixin2)
    end

    it 'get 2 source from one class and one object' do
      sources = Aspects.get_sources([Dummy_class3, Dummy_class3.new])
      expect(sources.size).to equal(2)
    end

    it 'get 2 source from one class with mixin included and one object' do
      sources = Aspects.get_sources([Dummy_class_mixin2, Dummy_class3.new])
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
      Aspects.get_sources([/1/,/mixin/])
    }
    it 'sources should be exactly...' do
      expect(sources).to contain_exactly(Dummy_class1,Dummy_class_mixin2,Dummy_mixin1,Dummy_mixin2,Dummy_mixin3)
    end

    it 'sources should not contain Dummy_class4' do
      expect(sources).to_not contain_exactly(Dummy_class4)
    end

    it 'should get 3 sources when regexp is /2/' do
      sources_regexp_2 = Aspects.get_sources([/2/])
      expect(sources_regexp_2.size).to equal(3)
    end
  end
end