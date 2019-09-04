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

const grades = []

class Grade {
  constructor(attributes){
    this.assignment_id = attributes.assignment_id
    this.id = attributes.id
    this.score = attributes.score
    this.student_id = attributes.student_id
    grades.push(this)
  }
}

const assignments = []

class Assignment {
  constructor(attributes){
    this.date = attributes.date
    this.id = attributes.id
    this.learning_target_id = attributes.learning_target_id
    this.name = attributes.name
    assignments.push(this)
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
