class ContentPlanPolicy < Struct.new(:user, :content_plan)
  def index?
    true
  end

  def show?
    true
  end

  def versions?
    true
  end

  def create?
    true
  end

  def new?
    true
  end

  def update?
    true
  end

  def edit?
    true
  end

  def destroy?
    content_plan.contents.empty?
  end
end
