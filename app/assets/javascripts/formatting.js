function testing() {
  const allTds = document.querySelectorAll('.assignment-averages')
  for (let i=0; i<=allTds.length; i++) {
    if (allTds[i] !== undefined) {
      const num = allTds[i].querySelector('strong').innerHTML
      if (parseFloat(num) >= 3.0) {
        allTds[i].style.backgroundColor = "green"
      } else if (parseFloat(num) >= 2.0) {
        allTds[i].style.backgroundColor = "yellow"
      } else {
        allTds[i].style.backgroundColor = "red"
      }
    }
  }
}
