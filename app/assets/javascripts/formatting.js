// Instead of listening to document.ready, we have to listen for when turbolinks
//load a new page.  Otherwise, testing() only invokes during the initial page load.

$(document).on('turbolinks:load', function() {
  conditionalFormatting()
})

function conditionalFormatting() {
  const allTds = $('.assignment-averages')
  for (let i=0; i<=allTds.length; i++) {
    if (allTds[i] !== undefined) {
      const num = allTds[i].querySelector('strong').innerHTML
      if (parseFloat(num) >= 3.0) {
        allTds[i].style.backgroundColor = "rgb(88, 169, 106, 0.6)"
        allTds[i].style.color = "black"
      } else if (parseFloat(num) >= 2.0) {
        allTds[i].style.backgroundColor = "rgb(212, 208, 96, 0.6)"
        allTds[i].style.color = "black"
      } else {
        allTds[i].style.backgroundColor = "rgb(212, 106, 96, 0.6)"
        allTds[i].style.color = "black"
      }
    }
  }
}

function rowSorter(direction, type) {
  const tbody = document.querySelector('tbody')
  const allTrs = document.querySelectorAll('tr')
  document.querySelector('tbody').innerHTML = ''

  for(let i=0; i<3; i++) {
    document.querySelector('tbody').appendChild(allTrs[i])
  }

  let arrayOfSortObjects = []

  for(let i=3; i<allTrs.length; i++) {
    const obj = {index: i,
                 average: parseFloat(allTrs[i].querySelector('td.average').innerText),
                 name: allTrs[i].querySelector('td.student-name').innerText
               }
    arrayOfSortObjects.push(obj)
  }

  arrayOfSortObjects.sort(function(a,b) {
    if (direction === "highest" && type === "average") {
      return b.average - a.average
    } else if (direction === "lowest" && type === "average"){
      return a.average - b.average
    } else if (direction === "highest" && type === "name") {
      return a.name.localeCompare(b.name)
    } else {
      return b.name.localeCompare(a.name)
    }
  })

  for(let i=0; i<arrayOfSortObjects.length; i++) {
    document.querySelector('tbody').appendChild(allTrs[arrayOfSortObjects[i].index])
  }
}
