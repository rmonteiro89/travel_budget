module ExpensesHelper

  def expense_created_message(expense)
    link_to_edit = view_context.link_to 'edit', '#', 'data-toggle'=>'modal', 'data-target'=> "#editExpenseModal_#{expense.id}"
    "Expense created successfully!</br> #{expense.description}, #{expense.amount.format}, #{I18n.l(expense.date)}, #{expense.category_name} (#{link_to_edit})"
  end
end
