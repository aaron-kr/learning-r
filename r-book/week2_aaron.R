# 2주차 과제: Create surface of torus, volume of torus functions

# r: small radius
# R: major radius

getTorusSurfaceArea <- function(r,R) {
  circ <- 2.0 * 3.14 * r
  surf <- 2.0 * 3.14 * R
  return(circ * surf)
}

getTorusVolume <- function(r,R) {
  area <- 3.14 * r ^ 2
  vol <- 2 * 3.14 * R
  return(area * vol)
}

getTorusSurfaceArea(3,10)

getTorusVolume(3,10)
