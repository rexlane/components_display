---
---

$(document).ready ->
  $.ajax
    type: "GET"
    url: "https://bikeindex.org/api/v2/bikes/32"
    success: (data, textStatus, jqXHR) ->
      console.log(data.bike)
      window.bike = data.bike
      writeBikeInfo()
      createCompGroups()
      writeComponents()

createCompGroups = ->
  window.component_groups = {}
  for component in bike.components
     component_groups[component.component_group] = []
    
  for component in bike.components
    component_groups[component.component_group].push({"type":component.component_type, "description":component.description})


writeBikeInfo = ->
  $('#bike_title').html("#{bike.title}")
  $('#binx_link').html("<a href='#{bike.url}' target='_blank'>View this bike on the Bike Index.</a>")

writeComponents = ->
  for component_groups_key in Object.keys(component_groups)
    
    html_string = "" 
    html_string = html_string + "<h3>#{component_groups_key}</h3><ul>"

    for component in component_groups[component_groups_key]
      html_string = html_string + "<li><div>#{component.type}</div>#{component.description}</li>"

    html_string = html_string + "</ul>"
    $('#components_display').append(html_string)