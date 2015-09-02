require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    Aspects.on TestClass, TestModule do
      transform(where(name(/.*crazy.*/))) do
        print_name(', super crazy. ')
      end
    end

  end
end
