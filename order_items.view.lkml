view: order_items {
  sql_table_name: public.order_items ;;

#######################
##### Primary Key #####
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

#######################
##### Foreign Keys ####
  dimension: user_id {
    type: number
#   hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  dimension: inventory_item_id {
    type: number
    sql: ${TABLE}.inventory_item_id ;;
  }

  dimension: order_id {
    type: number
    sql: ${TABLE}.order_id ;;
  }

#######################
##### Dimensions ######
  dimension_group: created {
    group_label: "Date Created"
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.created_at ;;
  }

  dimension_group: returned {
    group_label: "Date Returned"
    type: time
    timeframes: [raw,date,month,year]
    sql: ${TABLE}.returned_at ;;
  }


  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

# Exercise: Create 'complete' yesNo field off of status and then a measure called total_complete_sale_price

  dimension: sale_price {
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


#######################
##### Sets ######
  set: detail {
    fields: [id, users.id, inventory_items.id, users.first_name, users.last_name, inventory_items.product_name]
  }

}
