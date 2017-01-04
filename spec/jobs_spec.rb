# Created (Cole Albers, 9/30): Spec used to test the Jobs class.

require_relative '../lib/jobs'

describe Jobs do
  context 'while testing attr_accessor' do
    it 'should get the attributes of the Jobs Object when attr_accessor is called' do
      job = Jobs.new('UT', 'WT', 'D', 'AD', 'RN', 'TS', 'SOD')
      expect(job.university_title).to eq 'UT'
      expect(job.working_title).to eq 'WT'
      expect(job.department).to eq 'D'
      expect(job.application_deadline).to eq 'AD'
      expect(job.requisition_number).to eq 'RN'
      expect(job.target_salary).to eq 'TS'
      expect(job.summary_of_duties).to eq 'SOD'
    end

    it 'should set the attributes of the Jobs Object when attr_accessor is called' do
      job = Jobs.new
      job.university_title = 'UT'
      job.working_title = 'WT'
      job.department = 'D'
      job.application_deadline = 'AD'
      job.requisition_number = 'RN'
      job.target_salary = 'TS'
      job.summary_of_duties = 'SOD'
      expect(job.university_title).to eq 'UT'
      expect(job.working_title).to eq 'WT'
      expect(job.department).to eq 'D'
      expect(job.application_deadline).to eq 'AD'
      expect(job.requisition_number).to eq 'RN'
      expect(job.target_salary).to eq 'TS'
      expect(job.summary_of_duties).to eq 'SOD'
    end
  end

  context 'while testing new' do
    it 'should create a new Jobs Object with no input when new is called' do
      job = Jobs.new
      expect(job).to be_instance_of Jobs
      expect(job.university_title).to be_nil
      expect(job.working_title).to be_nil
      expect(job.department).to be_nil
      expect(job.application_deadline).to be_nil
      expect(job.requisition_number).to be_nil
      expect(job.target_salary).to be_nil
      expect(job.summary_of_duties).to be_nil
    end

    it 'should create a new Jobs Object with input when new is called' do
      job = Jobs.new('UT', 'WT', 'D', 'AD', 'RN', 'TS', 'SOD')
      expect(job).to be_instance_of Jobs
      expect(job.university_title).to eq 'UT'
      expect(job.working_title).to eq 'WT'
      expect(job.department).to eq 'D'
      expect(job.application_deadline).to eq 'AD'
      expect(job.requisition_number).to eq 'RN'
      expect(job.target_salary).to eq 'TS'
      expect(job.summary_of_duties).to eq 'SOD'
    end
  end
end