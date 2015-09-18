require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'Aspects when apply redirect_to' do

  it 'should modify the method outside Aspect s block' do
    Aspects.on Dummy_class2 do
      transform(where name(/saludar/)) do
        redirect_to(Dummy_class3.new)
      end
    end

    expect(Dummy_class2.new.saludar('Mundo')).to eq 'Adiosin, Mundo'
  end
end