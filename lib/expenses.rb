class Expenses 

  attr_reader :id, :description, :unit_price, :quantity, :mark_up, :expense_total, :quote_id

  def initialize(id:, description:, unit_price:, quantity:, mark_up:, expense_total:, quote_id:)
    @id = id
    @description = description
    @unit_price = unit_price
    @quantity = quantity
    @mark_up = mark_up
    @expense_total = expense_total
    @quote_id = quote_id
  end

  def self.all(quote_id:)
    result = DatabaseConnection.query("SELECT * FROM expenses WHERE quote_id = #{quote_id};")
    result.map do |expenses_item|
      Expenses.new(
      id: expenses_item[0],
      description: expenses_item[1], 
      unit_price: expenses_item[2], 
      quantity: expenses_item[3], 
      mark_up: expenses_item[4], 
      expense_total: expenses_item[5], 
      quote_id: expenses_item[6]
    )
    end
  end

  def self.create(items, quote_id)
    @counter = 0
    while items["expense_desc_#{@counter}"] != nil
      DatabaseConnection.query("INSERT INTO expenses (description, unit_price, quantity, mark_up, expense_total, quote_id) 
              VALUES (
                '#{items["expense_desc_#{@counter}"]}', 
                '#{items["expense_unit_price_#{@counter}"]}', 
                '#{items["expense_quantity_#{@counter}"]}',
                '#{items["expense_mark_up_#{@counter}"]}',
                '#{items["expense_total_#{@counter}"]}',
                '#{quote_id}'
                );")
      @counter += 1
    end
  end

  def self.delete(quote_id) 
    DatabaseConnection.query("DELETE FROM expenses WHERE quote_id = '#{quote_id}';")
  end

  def self.update(items, quote_id)
    @counter = 0
    while items["expense_desc_#{@counter}"] != nil
        result =  DatabaseConnection.query("UPDATE expenses SET 
                    description = '#{items["expense_desc_#{@counter}"]}', 
                    unit_price = '#{items["expense_unit_price_#{@counter}"]}', 
                    quantity = '#{items["expense_quantity_#{@counter}"]}', 
                    mark_up = '#{items["expense_mark_up_#{@counter}"]}', 
                    expense_total = '#{items["expense_total#{@counter}"]}' 
                    WHERE id = '#{items["expense_id_#{@counter}"]}'
                    RETURNING id, description, unit_price, quantity, mark_up, expense_total, quote_id;"
                    )
        Expenses.new(
          id: result[0][0],
          description: result[0][1],
          unit_price: result[0][2],
          quantity: result[0][3],
          mark_up: result[0][4],
          expense_total: result[0][5],
          quote_id: result[0][6]
        )
      @counter += 1
    end
  end
end