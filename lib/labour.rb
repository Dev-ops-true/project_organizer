class Labour 

  attr_reader :id, :description, :unit_price, :quantity, :mark_up, :labour_total, :quote_id

  def initialize(id:, description:, unit_price:, quantity:, mark_up:, labour_total:, quote_id:)
    @id = id
    @description = description
    @unit_price = unit_price
    @quantity = quantity
    @mark_up = mark_up
    @labour_total = labour_total
    @quote_id = quote_id
  end

  def self.all(quote_id:)
    result = DatabaseConnection.query("SELECT * FROM labour WHERE quote_id = #{quote_id};")
    result.map do |labour_item|
      Labour.new(
      id: labour_item[0],
      description: labour_item[1], 
      unit_price: labour_item[2], 
      quantity: labour_item[3], 
      mark_up: labour_item[4], 
      labour_total: labour_item[5], 
      quote_id: labour_item[6]
    )
    end
  end

  def self.create(items, quote_id)
    @counter = 0
    while items["labour_desc_#{@counter}"] != nil
      DatabaseConnection.query("INSERT INTO labour (description, unit_price, quantity, mark_up, labour_total, quote_id) 
              VALUES (
                '#{items["labour_desc_#{@counter}"]}', 
                '#{items["labour_unit_price_#{@counter}"]}', 
                '#{items["labour_quantity_#{@counter}"]}',
                '#{items["labour_mark_up_#{@counter}"]}',
                '#{items["labour_total_#{@counter}"]}',
                '#{quote_id}'
                );")
      @counter += 1
    end
  end

  def self.delete(quote_id) 
    DatabaseConnection.query("DELETE FROM labour WHERE quote_id = '#{quote_id}';")
  end

  def self.update(items, quote_id)
    @counter = 0
    while items["labour_desc_#{@counter}"] != nil
        result =  DatabaseConnection.query("UPDATE labour SET 
                    description = '#{items["labour_desc_#{@counter}"]}', 
                    unit_price = '#{items["labour_unit_price_#{@counter}"]}', 
                    quantity = '#{items["labour_quantity_#{@counter}"]}', 
                    mark_up = '#{items["labour_mark_up_#{@counter}"]}', 
                    labour_total = '#{items["labour_total_#{@counter}"]}' 
                    WHERE id = '#{items["labour_id_#{@counter}"]}'
                    RETURNING id, description, unit_price, quantity, mark_up, labour_total, quote_id;"
                    )
        Labour.new(
          id: result[0][0],
          description: result[0][1],
          unit_price: result[0][2],
          quantity: result[0][3],
          mark_up: result[0][4],
          labour_total: result[0][5],
          quote_id: result[0][6]
        )
      @counter += 1
    end
  end
end