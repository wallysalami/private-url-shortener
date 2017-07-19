class ShortenedUrlPolicy
  attr_reader :user, :shortened_url

  def initialize(user, shortened_url)
    @user = user
    @shortened_url = shortened_url
  end

  def update?
    has_access
  end

  def edit?
    has_access
  end

  def show?
    has_access
  end

  private

  def has_access
    shortened_url.user_id == user.id
  end
end