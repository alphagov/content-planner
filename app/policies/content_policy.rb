class ContentPolicy < Struct.new(:user, :content)
  def index?
    true
  end

  def show?
    true
  end

  def create?
    content.specialist? || user.gds_editor?
  end

  def new?
    create?
  end

  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
  end
end
