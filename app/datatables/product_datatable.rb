class ProductDatatable < AjaxDatatablesRails::ActiveRecord

  def view_columns
    # Declare strings in this format: ModelName.column_name
    # or in aliased_join_table.column_name format
    @view_columns ||= {
      id: { source: "Product.id", cond: :eq },
      # name: { source: "User.name", cond: :like }
      name: { source: "Product.name", cond: :like, searchable: true },
      description: { source: "Product.description" },
      price: { source: "Product.price" }
    }
  end

  def data
    records.map do |product|
      {
        # example:
        id: product.id,
        name: product.name,
        description: product.description,
        price: product.price,
        DT_RowId: product.id, # This will automagically set the id attribute on the corresponding <tr> in the datatable
      }
    end
  end

  def get_raw_records
    # insert query here
    # User.all
    Product.all
  end

  # def additional_data
  #   {
  #     foo: 'bar'
  #   }
  # end

end
