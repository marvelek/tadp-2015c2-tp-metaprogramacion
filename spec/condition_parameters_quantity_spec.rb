require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/conditions/has_parameters'

describe 'QuantityParameters instance' do

  let (:quantity_parameters) {
    quantity_parameters = QuantityParameters.new
  }

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
      expect(quantity_parameters.filter(one_parameter_mandatory, 1)).to be_truthy
    end
    it 'method_2param should be false' do
      expect(quantity_parameters.filter(two_parameter_mandatories, 1)).to be_falsey
    end
    it 'method_1opt should be true' do
      expect(quantity_parameters.filter(one_parameter_optional, 1)).to be_truthy
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
      expect(quantity_parameters.filter(three_mandatories, 3)).to be_truthy
    end
    it 'method_2man_1opt should be true' do
      expect(quantity_parameters.filter(two_mandatories_one_optional, 3)).to be_truthy
    end
    it 'method_1man_2opt should be true' do
      expect(quantity_parameters.filter(one_mandatory_two_optional, 3)).to be_truthy
    end
    it 'method_3opt should be true' do
      expect(quantity_parameters.filter(three_optional, 3)).to be_truthy
    end

    it 'method_2params should be false' do
      expect(quantity_parameters.filter(two_mandatories, 3)).to be_falsey
    end
    it 'method_1man_1opt should be false' do
      expect(quantity_parameters.filter(one_mandatory_one_optional, 3)).to be_falsey
    end
    it 'method_2opt should be false' do
      expect(quantity_parameters.filter(two_optional, 3)).to be_falsey
    end
  end
end