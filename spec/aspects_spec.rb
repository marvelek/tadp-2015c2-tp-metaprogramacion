require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    #Don't use the same classes / modules for these tests to avoid side effect on unit tests.

    object_instance = Object.new
    object_instance.extend CompleteTestModule
    Aspects.on CompleteTestClass, CompleteTestModule, object_instance  do
      transform(where(selector(/.*crazy.*/))) do
        inject({p2: 'crazier', p1: proc { |receptor, mensaje, arg_anterior|
                 "crazy(#{mensaje}->#{arg_anterior})"}
               }
        )
      end
    end

    complete_test_class_instance = CompleteTestClass.new
    object_instance_not_transformed = Object.new
    object_instance_not_transformed.extend CompleteTestModule
    puts object_instance_not_transformed.crazy_method 'Metodo'
    puts object_instance_not_transformed.super_crazy_method 'Metodo'
    puts complete_test_class_instance.crazy_method 'Metodo'
    puts complete_test_class_instance.super_crazy_method 'Metodo'
    puts object_instance.crazy_method 'Metodo'
    puts object_instance.super_crazy_method 'Metodo'

  end
end
