$(document).on('turbolinks:load', function() {
  getData()
})

function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    console.log(json)
  })
}
