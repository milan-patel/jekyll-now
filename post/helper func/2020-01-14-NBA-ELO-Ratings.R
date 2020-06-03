#-------- NBA ELO Ratings ----------------------------------------------------
#' newRatings
#' 
#' @param R1 The rating of team 1.
#' @param R2 The rating of team 2.
#' @param result The result of the match; 1 if Player 1 won, 0 otherwise.
#' @param k Update factor.
#' @param scale Scale factor.
#' @return Vector of length 2, with updated rating of team 1 and updated team of player 2
newRatings <- function(R1, R2, result, k=40, scale=400){
  
  
  p1 = plogis(R1-R2, scale=scale) # compute the probability of player 1 winning 
  p2 = 1 - p1 # compute the probability of player 2 winning
  
  R1_new = R1 + k * (result-p1) # update player 1's rating 
  R2_new = R2 + k * ((1-result)-p2) # update player 2's rating
  
  c(round(R1_new), round(R2_new)) # return both updated ratings, rounded to nearest whole number
}


#' runELO
#' @param teamELOs A vector containing the initial ratings for each team.
#' @param games A dataframe containing the results of the games.
#' @param updateFunc A function that takes a game from `games` and returns a result (either 1 or 0)
#' @return A vector containing the updated ratings for each team.
runELO <- function(teamELOs, games, updateFunc){
  for(index in 1:nrow(games)){
    R1 = teamELOs[toString(games[index,]$Visitor.Neutral)] # retrieve visiting team's ELO
    R2 = teamELOs[toString(games$Home.Neutral[index])]  # retrieve home team's ELO
    result = games$S[index] # retrieve result of game
    
    
    
    # update team ratings based on results
    ratings <- updateFunc(R1,R2, result)
    teamELOs[toString(games$Visitor.Neutral[index])] <- ratings[1]
    teamELOs[toString(games$Home.Neutral[index])] <- ratings[2]
  }
  return(teamELOs)
}
