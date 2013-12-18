class TagsControllerPolicy < Struct.new(:user, :tag)
  def index?
    user.gds_editor?
  end

  def create?
    user.gds_editor?
  end

  def new?
    create?
  end

  def destroy?
    user.gds_editor?
  end
end