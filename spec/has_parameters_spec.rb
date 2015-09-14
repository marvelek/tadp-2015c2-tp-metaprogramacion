require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/conditions/has_parameters'

describe 'QuantityParameters instance' do

  context 'when asks for methods with one parameter' do
    let (:one_parameter_mandatory) {
      Dummy_class1.instance_method(:method_1param).parameters
    }
    let (:two_parameter_mandatories) {
      Dummy_class1.instance_method(:method_2params).parameters
    }
    let (:one_parameter_optional) {
      Dummy_class1.instance_method(:method_1opt).parameters
    }
    it 'method_1param should be true' do
      expect(QuantityParameters.new.filter(one_parameter_mandatory,1)).to be_truthy
    end
    it 'method_2param should be false' do
      expect(QuantityParameters.new.filter(two_parameter_mandatories,1)).to be_falsey
    end
    it 'method_1opt should be true' do
      expect(QuantityParameters.new.filter(one_parameter_optional,1)).to be_truthy
    end
  end

  context 'when asks for methods with 3 parameters' do
    let (:three_mandatories) {
      Dummy_class1.instance_method(:method_3man).parameters
    }
    let (:two_mandatories_one_optional) {
      Dummy_class1.instance_method(:method_2man_1opt).parameters
    }
    let (:one_mandatory_two_optional) {
      Dummy_class1.instance_method(:method_1man_2opt).parameters
    }
    let (:three_optional) {
      Dummy_class1.instance_method(:method_3opt).parameters
    }
    let (:two_mandatories) {
      Dummy_class1.instance_method(:method_2params).parameters
    }
    let (:one_mandatory_one_optional) {
      Dummy_class1.instance_method(:method_1man_1opt).parameters
    }
    let (:two_optional) {
      Dummy_class1.instance_method(:method_2opt).parameters
    }

    it 'method_3man should be true' do
      expect(QuantityParameters.new.filter(three_mandatories,3)).to be_truthy
    end
    it 'method_2man_1opt should be true' do
      expect(QuantityParameters.new.filter(two_mandatories_one_optional,3)).to be_truthy
    end
    it 'method_1man_2opt should be true' do
      expect(QuantityParameters.new.filter(one_mandatory_two_optional,3)).to be_truthy
    end
    it 'method_3opt should be true' do
      expect(QuantityParameters.new.filter(three_optional,3)).to be_truthy
    end

    it 'method_2params should be false' do
      expect(QuantityParameters.new.filter(two_mandatories,3)).to be_falsey
    end
    it 'method_1man_1opt should be false' do
      expect(QuantityParameters.new.filter(one_mandatory_one_optional,3)).to be_falsey
    end
    it 'method_2opt should be false' do
      expect(QuantityParameters.new.filter(two_optional,3)).to be_falsey
    end
  end
end

describe 'Has paramaters' do
  context 'when is used with two parameters and expects 3 parameters' do
    let (:block_three_parameters) {
      Aspects.has_parameters(3)
    }
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
end