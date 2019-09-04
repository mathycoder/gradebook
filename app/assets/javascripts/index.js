$(document).on('turbolinks:load', function() {
  const array = window.location.href.split('/')
  // Checks for the correct show page before running getData()
  if (array.length === 5 && array[3] === 'classes' && array[4] !== 'new'){
    getData()
  }
})


function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    // Serializer grabs way too many grades... not sure why
    console.log(json)
    createJSONObjects(json.learning_targets, LearningTarget)
    createJSONObjects(json.standards, Standard)
    createJSONObjects(json.students, Student)
    createJSONObjects(json.assignments, Assignment)
    createJSONObjects(json.grades, Grade)
  })
}

// Make these more efficient...one function!!
function createJSONObjects(json, cla){
  for (i = 0; i<json.length; i++){
    new cla(json[i])
  }
}
