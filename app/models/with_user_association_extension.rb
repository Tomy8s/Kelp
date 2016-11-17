module WithUserAssociationExtension
  def create_with_user(attributes = {}, banana)
    attributes[:user] ||= banana
    create(attributes)
  end

  def create_with_user!(attributes = {}, banana)
    attributes[:user] ||= banana
    create!(attributes)
  end

  def build_with_user(attributes = {}, banana)
    attributes[:user] ||= banana
    build(attributes)
  end

  def new_with_user(attributes = {}, banana)
    attributes[:user] ||= banana
    new(attributes)
  end
end