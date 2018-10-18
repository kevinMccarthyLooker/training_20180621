include: "*.view" # include all the views

connection: "events_ecommerce"

persist_with: training_default_datagroup

explore: users {}

explore: order_items {
  #To Do: Add distribution_centers join to this explore
  description: "Information about orders including user information"
  join: users {
    type: left_outer
    sql_on: ${order_items.user_id} = ${users.id} ;;
    relationship: many_to_one
  }

  join: inventory_items {
    type: left_outer
    sql_on: ${order_items.inventory_item_id} = ${inventory_items.id} ;;
    relationship: many_to_one
  }
}

#To do: Create Derived Table to provide a dimension 'years_as_consumer' based on first order

## Datagroup definition(s): ##
datagroup: training_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "1 hour"
}
