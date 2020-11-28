class AddTitleTrigramIndexToProcedures < ActiveRecord::Migration[6.0]
  def change
    enable_extension :pg_trgm
    add_index :procedures, :title, using: :gin, opclass: { title: :gin_trgm_ops }
  end
end
