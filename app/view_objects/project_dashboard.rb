class ProjectDashboard
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def trending
    @trending ||= Project.all.limit(5)
  end

  def recommended
    @recommended ||= Project.all.limit(5).order('random()')
  end

  def search_results
    @search_results ||= Project
      .where("name ILIKE ? or description ILIKE ?", "%#{query}%",  "%#{query}%")
      .page(params[:page]).per(20)
  end

  def search?
    !query.blank?
  end

  def query
    @query ||= params[:query].freeze
  end
end