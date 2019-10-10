require "dry/transaction"

class CreateProjectTransaction
  include Dry::Transaction

  tee :params
  tee :upcoming
  step :create!

  private

  def params(input)
    @project = input[:project]
  end

  def upcoming(_input)

    if @project.may_fields_complete?
      @project.fields_complete
    end
  end

  def create!(_input)
    if @project.save
      Success(@project)
    else
      Failure(error: @project.errors.full_messages)
    end
  end
end
