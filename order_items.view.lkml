
view: order_items {
  view_label: "test"
#   sql_table_name: public.order_items ;;
  derived_table: {sql:select * public.order_items
    ;;}

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
    group_label: "demo"
    type: string
    sql: ${TABLE}.status ;;
  }

# Exercise: Create 'complete' yesNo field off of status and then a measure called total_complete_sale_price

  dimension: sale_price {
    group_label: "demo"
    type: number
    sql: ${TABLE}.sale_price ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }
  measure: count_organic {
    type: count
    filters: {
      field: users.traffic_source
      value: "Organic"
    }
  }



  measure: total_sale_price {
    type: sum
    sql: ${sale_price} ;;
  }
  measure: min_sale_price {
    type: min
    sql: ${sale_price} ;;
  }
  measure: example {
    type: number
    sql: ${total_sale_price}+1 ;;
  }



#######################
##### Sets ######
  set: detail {
    fields: [id, users.id, inventory_items.id, users.first_name, users.last_name, inventory_items.product_name]
  }

}
