$(document).on('turbolinks:load', function() {
  const array = window.location.href.split('/')
  if (array.length === 5 && array[3] === 'classes' && array[4] !== 'new'){
    getData()
  }
})

function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    console.log(json)
  })
}
