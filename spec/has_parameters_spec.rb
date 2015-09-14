require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/conditions/has_parameters'

describe 'Has paramaters' do
  let(:instance) {
    instance = Dummy_class1.new
    instance.extend Has_parameters
  }

  let (:three_mandatories) {
    instance.method(:method_3man)
  }
  let (:two_mandatories_one_optional) {
    instance.method(:method_2man_1opt)
  }
  let (:one_mandatory_two_optional) {
    instance.method(:method_1man_2opt)
  }
  let (:three_optional) {
    instance.method(:method_3opt)
  }
  let (:two_mandatories) {
    instance.method(:method_2params)
  }
  let (:one_mandatory_one_optional) {
    instance.method(:method_1man_1opt)
  }
  let (:two_optional) {
    instance.method(:method_2opt)
  }

  context 'when is used with two parameters and expects 3 parameters' do
    let (:block_three_parameters) {
      Aspects.has_parameters(3)
    }

    it 'method_3man should be true' do
      expect(block_three_parameters.call three_mandatories).to be_truthy
    end
    it 'method_2man_1opt should be true' do
      expect(block_three_parameters.call two_mandatories_one_optional).to be_truthy
    end
    it 'method_1man_2opt should be true' do
      expect(block_three_parameters.call one_mandatory_two_optional).to be_truthy
    end
    it 'method_3opt should be true' do
      expect(block_three_parameters.call three_optional).to be_truthy
    end

    it 'method_2params should be true' do
      expect(block_three_parameters.call two_mandatories).to be_falsey
    end
    it 'method_1man_1opt should be true' do
      expect(block_three_parameters.call one_mandatory_one_optional).to be_falsey
    end
    it 'method_2opt should be true' do
      expect(block_three_parameters.call two_optional).to be_falsey
    end
  end

  context 'when is used with mandatory proc and expects 2 parameters' do
    let (:block_mandatory_two_params) {
      Aspects.has_parameters(2, mandatory)
    }

    it 'method_2man_1opt should be true' do
      expect(block_mandatory_two_params.call two_mandatories_one_optional).to be_truthy
    end
  end
end