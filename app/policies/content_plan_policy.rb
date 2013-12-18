class ContentPlanPolicy < Struct.new(:user, :content_plan)

  def create?
    user.gds_editor?
  end

  def new?
    create?
  end

  def update?
    user.gds_editor?
  end

  def edit?
    update?
  end

  def destroy?
    user.gds_editor?
  end
end

