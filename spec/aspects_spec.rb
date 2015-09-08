require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    a = TestClass.new
    Aspects.on a, /Tes/ do
      transform(where(namely(/.*crazy.*/))) do
        inject({p1: 'Hola'})
      end
    end

    b = TestClass.new
    b.extend(TestModule)

    b.crazy_method 'Metodo'
    b.super_crazy_method 'Metodo'
    a.crazy_method 'Metodo'
    a.extend(TestModule)
    a.super_crazy_method 'Metodo'

  end
end
