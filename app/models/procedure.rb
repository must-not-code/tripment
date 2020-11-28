class Procedure < ApplicationRecord
  def self.search_by_title(title)
    Procedure
      .where('title ILIKE ?', "%#{title}%")
      .order(Arel.sql(
        <<~SQL.squish
          CASE
            WHEN title ILIKE '#{title}%' THEN 1
            WHEN title ILIKE '% #{title}%' THEN 2
            WHEN title ILIKE '%#{title}%' THEN 3
          END
        SQL
      ))
  end
end
