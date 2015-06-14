---
---

$(document).ready ->
  $("#bike_lookup").submit (event) ->
    event.preventDefault()
    clearContent()
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
      error: (jqXHR, textStatus, errorThrown) ->
        $('#components_display').html("Sorry! Something went wrong. Try searching for another bike.")

      # Clear search field, remove focus
      $("#bike_id").val("").blur()

  # $("#bike_id").val(32)
  # $("#form_submit").submit() 

# Clear old page content on form submit.
clearContent = ->
  $("#bike_title").html("")
  $("#general_bike_info").html("")
  $("#components_display").html("")  


createCompGroups = ->
  # Alphabetically sort bike.components by component_group.
  bike.components.sort (a,b) ->
    # if a.component_group < b.component_group
    #   return -1
    # if a.component_group > b.component_group
    #   return 1
    # 0

    if a.component_type < b.component_type
      return -1
    if a.component_type > b.component_type
      return 1
    0

  # bike.components = bike.components.reverse()

  # window.additionalPartsArray = []
  # for component in bike.components when component.component_group is "Additional parts"
  #   additionalPartsArray.push(component)
  # # console.log(additionalPartsArray)

  # # for component in bike.components when component.component_group is "Additional parts"
  #   # console.log(bike.components.splice(component, 1))
  #   console.log("hi, seth")
  #   console.log(bike.components.indexOf(component))
  #   bike.components.splice(bike.components.indexOf(component), 1)

  # bike.components.concat(additionalPartsArray)



  # window.splicedPartsArray = []
  # i = 0
  # while i < additionalPartsArray.length 
  #   splicedPartsArray.push(bike.components.splice(component, 1))
  #   i++
  # console.log(splicedPartsArray)



  # window.splicedPartsArray = []
  # for part in additionalPartsArray
  #   splicedPartsArray.push(bike.components.splice(part, 1))
  # # console.log(splicedPartsArray)

  # for part in splicedPartsArray
  #   bike.components.push(part)

   

  # Create component_groups hash.
  window.component_groups = {}

  # Add each component group, equal to an empty array.
  for component in bike.components
    component_groups[component.component_group] = []
    
  # Push each component as a hash (containing type & description) to its component group array.
  for component in bike.components
    component_groups[component.component_group].push({"type":component.component_type, "description":component.description})

  # # Alphabetically sort components by type
  # for compGroup in Object.keys(component_groups)
  #   component_groups[compGroup].sort (a, b) ->
  #     if a.type < b.type
  #       return -1
  #     if a.type > b.type 
  #       return 1
  #     0



writeComponents = ->
  # Display the bike's title and image and link to it on the Bike Index.
  $('#bike_title').html("#{bike.title}")

  # $('#general_bike_info').html('<h2>General Information</h2>')
  if bike.thumb?
    $('#general_bike_info').append("<img src='#{bike.thumb}' id='bike_thumb'>")
  else
    console.log("no image")
  $('#general_bike_info').append("<p><a href='#{bike.url}' id='binx_link' target='_blank'>View this bike on the Bike Index.</a></p>")


  # If bike has components:
  if bike.components.length > 0
    # Create html_string.
    html_string = "" 

    keys = Object.keys(component_groups)
    additional_index = keys.indexOf("Additional parts")
    if additional_index isnt -1
      keys.splice(additional_index, 1)
      keys.sort()
      keys.push("Additional parts")
    else
      keys.sort()
     
    for component_groups_key in keys

      comp_group_img_src = "#{component_groups_key}"
      comp_group_img_src = comp_group_img_src.replace(/\s+/g, "_").toLowerCase()

      html_string = html_string + "<div class='comp_group_wrapper'>
      <img src='{{ site.baseurl }}/images/#{comp_group_img_src}.png' class='comp_group_img'><h3 class='comp_group_head'>#{component_groups_key}</h3>
      <table class='comp_group_table'>"

      # Add row for each component.
      for component in component_groups[component_groups_key]
        html_string = html_string + "<tr><td><span class='comp_type_name'>#{component.type}:</span> #{component.description}</td></tr>"

      # Close table.
      html_string = html_string + "</table></div>"
    
    # Write html_string to html.
    $('#components_display').html(html_string)

  # If bike has no components:
  else
    console.log('no components')