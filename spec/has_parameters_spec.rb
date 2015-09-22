require 'rspec'
require_relative '../src/aspects'
require_relative '../src/domain_mock'
require_relative '../src/conditions/has_parameters'

describe 'Has parameters' do
  let (:mandatory) {
    Aspects.mandatory
  }
  let (:optional) {
    Aspects.optional
  }

  let(:dummy_instance) {
    dummy_instance = Dummy_class1.new
  }
  let (:three_mandatories) {
    dummy_instance.method(:method_3man)
  }
  let (:two_mandatories_one_optional) {
    dummy_instance.method(:method_2man_1opt)
  }
  let (:one_mandatory_two_optional) {
    dummy_instance.method(:method_1man_2opt)
  }
  let (:three_optional) {
    dummy_instance.method(:method_3opt)
  }
  let (:two_mandatories) {
    dummy_instance.method(:method_2params)
  }
  let (:one_mandatory_one_optional) {
    dummy_instance.method(:method_1man_1opt)
  }
  let (:two_optional) {
    dummy_instance.method(:method_2opt)
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

    it 'method_2man should be true' do
      expect(block_mandatory_two_params.call two_mandatories).to be_truthy
    end

    it 'method_3man should be false' do
      expect(block_mandatory_two_params.call three_mandatories).to be_falsey
    end

    it 'method_2opt should be false' do
      expect(block_mandatory_two_params.call two_optional).to be_falsey
    end
  end

  context 'when is used with optional proc and expects 2 parameters' do
    let (:block_optional_two_params) {
      Aspects.has_parameters(2, optional)
    }

    it 'method_1man_2opt should be true' do
      expect(block_optional_two_params.call one_mandatory_two_optional).to be_truthy
    end

    it 'method_3opt should be false' do
      expect(block_optional_two_params.call three_optional).to be_falsey
    end

    it 'method_2opt should be true' do
      expect(block_optional_two_params.call two_optional).to be_truthy
    end

    it 'method_2man should be true' do
      expect(block_optional_two_params.call two_mandatories).to be_falsey
    end
  end

  context 'when "has_parameters" is used with with a Regex as second parameter' do

    let(:dummy_instance){
      dummy_instance = Dummy_class2.new
    }

    it 'method_1arg_with_m should be true' do
      expect(Aspects.has_parameters(1, /m/).call dummy_instance.method(:method_1arg_with_m)).to be_truthy
    end

    it 'method_with_no_m should be falsey' do
      expect(Aspects.has_parameters(1, /m/).call dummy_instance.method(:method_with_no_m)).to be_falsey
    end

    it 'method_with_param should be true as it has 2 arguments with "param" in its name' do
      expect(Aspects.has_parameters(2, /param.*/).call dummy_instance.method(:method_with_param)).to be_truthy
    end

    it 'method_with_param should be false as it has exactly 2 arguments with "param" in its name and not only 1' do
      expect(Aspects.has_parameters(1, /param.*/).call dummy_instance.method(:method_with_param)).to be_falsey
    end

    it 'method_with_no_m should be false as it hasnt 2 arguments with "param" in its name' do
      expect(Aspects.has_parameters(2, /param.*/).call dummy_instance.method(:method_with_no_m)).to be_falsey
    end

    it 'method_with_no_m should be true as it hasnt 2 arguments with "param" in its name' do
      expect(Aspects.has_parameters(0, /param.*/).call dummy_instance.method(:method_with_no_m)).to be_truthy
    end

  end
end