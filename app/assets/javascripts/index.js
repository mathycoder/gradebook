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
}

function getData() {
  const klassId = window.location.href.split("/")[4]
  $.get('/classes/' + klassId + '.json', function(json){
    console.log(json)
    for (i = 0; i<json.learning_targets.length; i++){
      const lt = new LearningTarget(json.learning_targets[i])
      learningTargets.push(lt)
    }
  })
}
