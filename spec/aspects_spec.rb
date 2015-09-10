require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

<<<<<<< HEAD:spec/aspects_spec.rb
    #Don't use the same classes / modules for these tests to avoid side effect on unit tests.

    Aspects.on CompleteTestClass do
      transform(where(name(/.*crazy.*/))) do
        sarasa
        inject({p1: 'Crazy'})
      end
    end

    a = CompleteTestClass.new
    b = CompleteTestClass.new
    print b.crazy_method 'Metodo'
    print b.super_crazy_method 'Metodo'
    print a.crazy_method 'Metodo'
    print a.super_crazy_method 'Metodo'

=======
    a = TestClass.new
    Aspects.on a, /Tes/ do
      transform(where(name(/.*crazy.*/))) do
        create_method
      end
    end

>>>>>>> origin/develop:specs/aspects_spec.rb
  end
end
