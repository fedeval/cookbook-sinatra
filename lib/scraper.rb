class ScrapeAllrecipesService
  def self.call(keyword)
    url = "https://www.allrecipes.com/search/?wt=#{keyword}"
    html_content = open(url).read
    doc = Nokogiri::HTML(html_content)
    names = doc.search('.fixed-recipe-card__h3').first(5).map { |element| element.text.strip }
    descriptions = doc.search('.fixed-recipe-card__description').first(5).map { |element| element.text.strip }
    ratings = doc.search('.stars').first(5).map { |element| element.attributes['data-ratingstars'].value.to_i }
    prep_times = scrape_prep_times(doc)
    names.zip(descriptions, ratings, prep_times).map do |name, description, rating, prep_time|
      Recipe.new(name, description, rating, prep_time)
    end
  end

  private

  def self.scrape_prep_times(doc)
    urls = doc.search('.fixed-recipe-card__h3 a').first(5).map { |element| element.attributes['href'].value }
    prep_times = []
    urls.each do |url|
      html_content = open(url).read
      new_doc = Nokogiri::HTML(html_content)
      prep_times << new_doc.search('.recipe-meta-item-body').first.text.strip.to_i
    end
    return prep_times
  end
end