$(document).on('turbolinks:load', function() {
  const array = window.location.href.split('/')
  if (array.length === 5 && array[3] === 'classes' && array[4] !== 'new'){
    getData()
  }
})

const learningTargets = []
let learningTargetId = 0

class LearningTarget {
  constructor(attributes){
    this.id = learningTargetId++
    this.name = attributes.name
    this.standard_id = attributes.standard_id
    this.created_at = attributes.created_at
    learningTargets.push(this)
  }

  standardName(){
    const standard = standards.find(st => st.id === this.standard_id)
    return standard.alt_standard_notation
  }
}

const standards = []

class Standard {
  constructor(attributes){
    this.id = attributes.id
    this.alt_standard_notation = attributes.alt_standard_notation
    standards.push(this)
  }
}

const students = []

class Student {
  constructor(attributes){
    this.first_name = attributes.first_name
    this.last_name = attributes.last_name
    students.push(this)
  }
}

function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    console.log(json)
    //createLearningTargets(json)
    createJSONObjects(json.learning_targets, LearningTarget)
    createJSONObjects(json.standards, Standard)
    createJSONObjects(json.students, Student)
  })
}

// Make these more efficient...one function!!
function createJSONObjects(json, cla){
  for (i = 0; i<json.length; i++){
    new cla(json[i])
  }
}
