module Concerns::Findable

  def find_by_name(name)
    all.find do |item|
      item.name == name
    end
  end

end
