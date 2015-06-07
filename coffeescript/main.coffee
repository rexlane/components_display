---
---

$(document).ready ->
  $("#form_submit").click (event) ->
    event.preventDefault()
    bike_id = $("#bike_id").val()
    $.ajax
      type: "GET"
      url: "https://bikeindex.org/api/v2/bikes/" + bike_id
      success: (data, textStatus, jqXHR) ->
        console.log(data.bike)
        window.bike = data.bike
        # writeBikeInfo()
        createCompGroups()
        writeComponents()

createCompGroups = ->

  # Create component_groups hash.
  window.component_groups = {}

  # Add each component group, equal to an empty array.
  for component in bike.components
     component_groups[component.component_group] = []
    
  # Push each component as a hash (containing type & description) to its component group array.
  for component in bike.components
    component_groups[component.component_group].push({"type":component.component_type, "description":component.description})


writeComponents = ->

  # Display the bike's title and image and link to it on the Bike Index.
  $('#bike_info_header').html("<div id='bike_header'>
    <h1 id='bike_title'>#{bike.title}</h1>
    <img src='#{bike.thumb}' id='bike_thumb'>
    <p><a href='#{bike.url}' id='binx_link' target='_blank'>View this bike on the Bike Index.</a></p>
    </div>")

  # Create html_string.
  html_string = "" 

  # Add each component group header to html_string; open <ul> for each component group.
  for component_groups_key in Object.keys(component_groups)
    html_string = html_string + "<table class='comp_group_table'>"

    # comp_group_img_src = "#{component_groups_key}"
    # comp_group_img_src = comp_group_img_src.replace(/\s+/g, "_").toLowerCase()
    # html_string = html_string + "<tr><th class='comp_group_head'><img src='{{ site.baseurl }}/images/#{comp_group_img_src}.png' class='comp_group_img'>#{component_groups_key}</th></tr>"

    html_string = html_string + "<tr><th class='comp_group_head'>#{component_groups_key}</th></tr>"

    # Add a <li> comtaining each component's type and description.
    for component in component_groups[component_groups_key]
      html_string = html_string + "<tr><td>#{component.type}<br />#{component.description}</td></tr>"

    # Close each <ul>.
    html_string = html_string + "</table>"
  
  # Write html_string to html.
  $('#components_display').html(html_string)