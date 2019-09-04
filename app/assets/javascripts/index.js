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
    //createLearningTargets(json)
    createJSONObjects(json.learning_targets, LearningTarget)
    createJSONObjects(json.standards, Standard)
    createJSONObjects(json.students, Student)
    createJSONObjects(json.assignments, Assignment)
  })
}

// Make these more efficient...one function!!
function createJSONObjects(json, cla){
  for (i = 0; i<json.length; i++){
    new cla(json[i])
  }
}
