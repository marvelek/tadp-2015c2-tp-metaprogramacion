require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    #Don't use the same classes / modules for these tests to avoid side effect on unit tests.

    a = CompleteTestClass.new
    Aspects.on a, /CompleteTes/ do
      transform(where(namely(/.*crazy.*/))) do
        inject({p1: 'Hola'})
      end
    end

    b = CompleteTestClass.new
    b.extend(CompleteTestModule)

    b.crazy_method 'Metodo'
    b.super_crazy_method 'Metodo'
    a.crazy_method 'Metodo'
    a.extend(CompleteTestModule)
    a.super_crazy_method 'Metodo'

  end
end
