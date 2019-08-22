function testing() {
  const allTds = document.querySelectorAll('td')
  for (let i=0; i<=allTds.length; i++) {
    allTds[i].style.color = "blue"
  }
}
