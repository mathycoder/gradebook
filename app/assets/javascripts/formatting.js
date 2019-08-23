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
