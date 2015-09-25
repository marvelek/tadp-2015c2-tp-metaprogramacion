require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'

context 'When after is used' do

  let(:a_proc) {
    proc{ |instance, *args|
      @x = 10
    }
  }
  let(:klass){
    Mi_clase.new
  }

  it 'should be false the first time. As the original method gets to run.' do
    Aspects.on Mi_clase do
      transform(where name(/m1/)) do
        before do |instance,cont,*args|
          instance.send :define_method, cont.name do |*args|
            true
          end
        end
      end
    end
    expect(klass.m1(1,2)).to be_falsey
    expect(klass.m1(1,2)).to be_truthy #Now is true because we have injected the logic forever.
  end

  it 'should be true as the block runs after.' do
    Aspects.on Mi_clase do
      transform(where name(/m1/)) do
        after do |instance,cont,*args|
          true
        end
      end
    end
    expect(klass.m1(1,2)).to be_truthy
  end

  it 'should be true as the block runs after.' do
    Aspects.on Mi_clase do
      transform(where name(/m1/)) do
        instead_of do |instance,cont,*args|
          20 + 10
        end
      end
    end
    expect(klass.m1(1,2)).to eq 30
  end
end