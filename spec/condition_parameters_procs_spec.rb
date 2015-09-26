require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/conditions/has_parameters'

describe 'ProcParameter instance' do

  include HasParameters

  let (:one_parameter_mandatory) {
    Dummy_class1.instance_method(:method_1param).parameters
  }
  let (:one_parameter_optional) {
    Dummy_class1.instance_method(:method_1opt).parameters
  }
  let (:one_mandatory_one_optional) {
    Dummy_class1.instance_method(:method_1man_1opt).parameters
  }

  let (:proc_parameters){
    proc_parameters = ProcParameters.new
  }

  context 'when asks for mandatory methods with one parameter' do
    let (:two_parameter_mandatories) {
      Dummy_class1.instance_method(:method_2params).parameters
    }

    it 'method_1param should be true' do
      expect(proc_parameters.filter(one_parameter_mandatory,1,mandatory)).to be_truthy
    end
    it 'method_2param should be false' do
      expect(proc_parameters.filter(two_parameter_mandatories,1,mandatory)).to be_falsey
    end
    it 'method_1opt should be false' do
      expect(proc_parameters.filter(one_parameter_optional,1,mandatory)).to be_falsey
    end
    it 'method_1man_1opt should be true' do
      expect(proc_parameters.filter(one_mandatory_one_optional,1,mandatory)).to be_truthy
    end
  end

  context 'when asks for optional methods with one parameter' do
    let (:two_optional) {
      Dummy_class1.instance_method(:method_2opt).parameters
    }
    it 'method_1param should be true' do
      expect(proc_parameters.filter(one_parameter_mandatory,1,optional)).to be_falsey
    end
    it 'method_2param should be false' do
      expect(proc_parameters.filter(two_optional,1,optional)).to be_falsey
    end
    it 'method_1opt should be false' do
      expect(proc_parameters.filter(one_parameter_optional,1,optional)).to be_truthy
    end
    it 'method_1man_1opt should be true' do
      expect(proc_parameters.filter(one_mandatory_one_optional,1,optional)).to be_truthy
    end
  end
end