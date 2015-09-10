require 'rspec'
require_relative '../src/aspects'
require_relative '../spec/domain_mock'

describe 'aspects' do

  it 'should always be OK because I dont know how to test it yet' do

    a = TestClass.new
    Aspects.on a, /Tes/ do
      transform(where(name(/.*crazy.*/))) do
        create_method
      end
    end

  end
end
