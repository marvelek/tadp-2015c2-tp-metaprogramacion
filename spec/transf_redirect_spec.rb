require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

describe 'Aspects when apply redirect_to' do

  let (:redirect) {
    Aspects.on Dummy_class5 do
      transform(where name(/saludar/)) do
        redirect_to(Dummy_class3.new)
      end
    end
  }

  it 'the method should not be modified' do
    expect(Dummy_class5.new.saludar('Mundo')).to eq 'Hola, Mundo'
  end
  
  it 'should modify the method outside Aspect s block' do
    redirect
    expect(Dummy_class5.new.saludar('Mundo')).to eq 'Adiosin, Mundo'
  end

  it 'the method should be modified forever' do
    expect(Dummy_class5.new.saludar('Mundo')).to eq 'Adiosin, Mundo'
  end
end