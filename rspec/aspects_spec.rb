require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    a = TestClass.new
    Aspects.on a, /Tes/ do
      transform(where(namely(/.*crazy.*/))) do
        create_method
      end
    end

    b = TestClass.new
    b.extend(TestModule)
    print b.sarasa
    print a.sarasa

  end
end
