module TagsHelper
  def comma_join(tags)
    result = []
    tags.each do |tag|
      result << tag[:name]
    end
    result.join(",")
  end
end
