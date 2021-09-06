class Materials 

  attr_reader :id, :description, :unit_price, :quantity, :mark_up, :material_total, :quote_id

  def initialize(id:, description:, unit_price:, quantity:, mark_up:, material_total:, quote_id:)
    @id = id
    @description = description
    @unit_price = unit_price
    @quantity = quantity
    @mark_up = mark_up
    @material_total = material_total
    @quote_id = quote_id
  end

  def self.all(quote_id:)
    result = DatabaseConnection.query("SELECT * FROM materials WHERE quote_id = #{quote_id};")
    result.map do |materials_item|
      Materials.new(
      id: materials_item[0],
      description: materials_item[1], 
      unit_price: materials_item[2], 
      quantity: materials_item[3], 
      mark_up: materials_item[4], 
      material_total: materials_item[5], 
      quote_id: materials_item[6]
    )
    end
  end

  def self.create(items, quote_id)
    @counter = 0
    while items["materials_desc_#{@counter}"] != nil
      DatabaseConnection.query("INSERT INTO materials (description, unit_price, quantity, mark_up, material_total, quote_id) 
              VALUES (
                '#{items["material_desc_#{@counter}"]}', 
                '#{items["material_unit_price_#{@counter}"]}', 
                '#{items["material_quantity_#{@counter}"]}',
                '#{items["material_mark_up_#{@counter}"]}',
                '#{items["material_total_#{@counter}"]}',
                '#{quote_id}'
                );")
      @counter += 1
    end
  end

  def self.delete(quote_id) 
    DatabaseConnection.query("DELETE FROM materials WHERE quote_id = '#{quote_id}';")
  end

  def self.update(items, quote_id)
    @counter = 0
    while items["material_desc_#{@counter}"] != nil
        result =  DatabaseConnection.query("UPDATE materials SET 
                    description = '#{items["material_desc_#{@counter}"]}', 
                    unit_price = '#{items["material_unit_price_#{@counter}"]}', 
                    quantity = '#{items["material_quantity_#{@counter}"]}', 
                    mark_up = '#{items["material_mark_up_#{@counter}"]}', 
                    material_total = '#{items["material_total#{@counter}"]}' 
                    WHERE id = '#{items["material_id_#{@counter}"]}'
                    RETURNING id, description, unit_price, quantity, mark_up, material_total, quote_id;"
                    )
        Materials.new(
          id: result[0][0],
          description: result[0][1],
          unit_price: result[0][2],
          quantity: result[0][3],
          mark_up: result[0][4],
          material_total: result[0][5],
          quote_id: result[0][6]
        )
      @counter += 1
    end
  end
end