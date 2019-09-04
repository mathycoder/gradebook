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
  }

  standardName(){
    const standard = standards.find(st => {
      return st.id === this.standard_id
    })
    return standard.alt_standard_notation
  }
}

const standards = []

class Standard {
  constructor(attributes){
    this.id = attributes.id
    this.alt_standard_notation = attributes.alt_standard_notation
  }
}

function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    console.log(json)
    createLearningTargets(json)
    createStandards(json)
  })
}

function createLearningTargets(json){
  for (i = 0; i<json.learning_targets.length; i++){
    const lt = new LearningTarget(json.learning_targets[i])
    learningTargets.push(lt)
  }
}

function createStandards(json){
  for (i = 0; i<json.standards.length; i++){
    const lt = new Standard(json.standards[i])
    standards.push(lt)
  }
}
