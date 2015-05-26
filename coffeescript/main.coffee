---
---
# a = "cool thingd"
# console.log("something #{a}")

$(document).ready ->
  $.ajax
    type: "GET"
    url: "https://bikeindex.org/api/v2/bikes/32"
    success: (data, textStatus, jqXHR) ->
      console.log(data.bike)
      window.bike = data.bike
      createCompGroups()
      writeSectionHeaders()


    
# listAllComponents = (x) -> 
#   $('#components_display').text(x)



createCompGroups = ->
  window.component_groups = {}
  i = 0  
  while i < bike.components.length
    component_groups[bike.components[i].component_group] = []
    i++

  i = 0
  while i < bike.components.length
    component_groups[bike.components[i].component_group].push({"type":bike.components[i].component_type, "description":bike.components[i].description})
    i++

writeSectionHeaders = ->
  i = 0
  while i < Object.keys(component_groups).length
    $('#components_display').append("<h3>#{Object.keys(component_groups)[i]}</h3>")
      # writeComponents()
    i++


# writeComponents = ->
#       n = 0
#       while n < component_groups[bike.components[i].component_group].length
#         $('#components_display').append("<li>#{component_groups[bike.components[i].component_group][n].type}</li>")
#         n++        