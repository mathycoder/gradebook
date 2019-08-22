// Instead of listening to document.ready, we have to listen for when turbolinks
//load a new page.  Otherwise, testing() only invokes during the initial page load.

$(document).on('turbolinks:load', function() {
  testing()
})

function testing() {
  const allTds = document.querySelectorAll('.assignment-averages')
  for (let i=0; i<=allTds.length; i++) {
    if (allTds[i] !== undefined) {
      const num = allTds[i].querySelector('strong').innerHTML
      if (parseFloat(num) >= 3.0) {
        allTds[i].style.backgroundColor = "rgb(171, 220, 165, 0.5)"
      } else if (parseFloat(num) >= 2.0) {
        allTds[i].style.backgroundColor = "rgb(220, 219, 165, 0.5)"
      } else {
        allTds[i].style.backgroundColor = "rgb(220, 183, 165, 0.5)"
      }
    }
  }
}
