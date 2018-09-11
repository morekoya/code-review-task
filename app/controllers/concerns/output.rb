module Output
  extend ActiveSupport::Concern

  def not_owned
    { errors: { article: ['not owned by user'] } }
  end
end
