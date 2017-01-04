# Created (Cole Albers, 9/30): Contains the Jobs class.

# Public: Class used to create and display Jobs objects.
#
# Examples
#
#   Jobs.new
#   # => (Jobs Object)
class Jobs
  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the University Title.
  attr_accessor :university_title

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Working Title.
  attr_accessor :working_title

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Department.
  attr_accessor :department

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Application Deadline.
  attr_accessor :application_deadline

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Requisition Number.
  attr_accessor :requisition_number

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Target Salary.
  attr_accessor :target_salary

  # Created (Cole Albers, 9/30).
  # Public: Gets/Sets the String of the Summary of Duties.
  attr_accessor :summary_of_duties

  # Created (Cole Albers, 9/30).
  # Public: Initialize a Jobs Object.
  #
  # university_title - A String of the University Title.
  # working_title - A String of the Working Title.
  # department - A String of the Department.
  # application_deadline - A String of the Application Deadline.
  # requisition_number - A String of the Requisition Number.
  # target_salary - A String of the Target Salary.
  # summary_of_duties - A String of the Summary of Duties.
  def initialize(university_title = nil, working_title = nil, department = nil, application_deadline = nil,
                 requisition_number = nil, target_salary = nil, summary_of_duties = nil)
    @university_title = university_title
    @working_title = working_title
    @department = department
    @application_deadline = application_deadline
    @requisition_number = requisition_number
    @target_salary = target_salary
    @summary_of_duties = summary_of_duties
  end
end