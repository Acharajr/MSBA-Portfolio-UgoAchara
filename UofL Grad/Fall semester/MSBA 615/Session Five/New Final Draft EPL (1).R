library(tidyverse)

library(shiny)

library(knitr)

library(kableExtra)

EPL_Standings <-  function(date , season) {
  
  
  # Convert input date from character type to date type
  
  date <- as.Date(date,format = '%m/%d/%Y')
  
  # Change season format: Example: '2019/20' to '1920/'
  
  url_season <- paste0(substr(season,3,4), substr(season,6,7),'/')
  
  # Create a url to download csv file for season input
  
  #url <- paste0('https://www.football-data.co.uk/mmz4281/2021/E0.csv')
  
  url <- paste0('https://www.football-data.co.uk/mmz4281/', url_season,'/E0.csv')
  
  # Assign the csv file object df_original
  
  df_original <- read_csv(url)
  
  # Form a subset from df_original, only included necessary columns
  
  df <- df_original %>%
    
    select(Date, HomeTeam, AwayTeam, FTHG, FTAG,FTR) %>%
    
    # Change the year format; 'YYYY' format and 'yy' format. Example: year 2019 vs year 19
    
    mutate(year = ifelse(nchar(Date) == 10,substring(Date,9,10),
                         
                         ifelse(nchar(Date) == 8,substring(Date,7,8),'Check Date format')),
           
           Date = paste0(substring(Date,1,6),year),
           
           # Convert to Date format
           
           Date1 = as.Date(Date,format = '%d/%m/%y')) %>% 
    
    # Create subset of df_original that only includes matches played up to and including the specified date input
    
    filter(Date1 <= date) %>%
    
    # points earned played at home city
    
    mutate(point_home = ifelse(FTR == 'D', 1, ifelse(FTR == 'H', 3, ifelse(FTR == 'A', 0,NA))), 
           
           # point earned played at opponent's city
           point_away = ifelse(FTR == 'D', 1, ifelse(FTR == 'H', 0, ifelse(FTR == 'A', 3,NA))), 
           
           # if win at home, count 1
           win_home = ifelse(FTR == 'H',1,0),
           
           # if win away, count 1
           win_away = ifelse(FTR == 'A', 1,0), 
           
           # if draw at home, count 1
           draw_home = ifelse(FTR == 'D',1,0),
           
           # if draw away, count 1
           draw_away = ifelse(FTR == 'D',1,0),
           
           # if lost at home, count 1
           loss_home = ifelse(FTR == 'A',1,0), 
           
           # if lost away, count 1
           loss_away = ifelse(FTR == 'H',1,0)) 
  
  # Create a subset of only matches played at home
  
  home <- df %>%
    
    select(Date, HomeTeam, FTHG,FTAG, FTR,Date1,point_home, win_home,draw_home,loss_home) %>%
    
    # Group by Team name and calculate:
    group_by(TeamName = HomeTeam) %>% 
    
    #Total games played
    summarise(count_home = n(), 
              
              #Total points earned
              point_home = sum(point_home), 
              
              #Total wins
              wins_home = sum(win_home), 
              
              #Total draws
              draws_home = sum(draw_home),
              
              #Total losses
              losses_home = sum(loss_home), 
              
              #Total goals scored
              goals_for_home = sum(FTHG), 
              
              #Total goals opponents scored against
              goals_against_home = sum(FTAG)) 
  
  # Create a subset of only matches played away
  
  away <- df %>%
    
    select(Date, Date1, AwayTeam, FTHG,FTAG, FTR, point_away, win_away, draw_away, loss_away) %>%
    
    #Group by Team name and calculate: (see below)
    group_by(TeamName = AwayTeam) %>% 
    
    #Total games played
    summarise(count_away = n(), 
              
              #Total points earned
              point_away = sum(point_away), 
              
              #Total wins
              wins_away = sum(win_away), 
              
              #Total draws
              draws_away = sum(draw_away), 
              
              #Total losses
              losses_away = sum(loss_away), 
              
              #Total goals scored
              goals_for_away = sum(FTAG), 
              
              #Total goals opponents scored against
              goals_against_away = sum(FTHG)) 
  
  #Join the home and away subsets by 'TeamName'
  
  join_df1 <- home %>%
    
    full_join(away, by = c('TeamName'))
  
  #Convert any NA to 0
  
  join_df1[is.na(join_df1)] <- 0
  
  #Now forming the columns to address the following questions
  
  join_df <- join_df1 %>%
    
    #Total matches played
    mutate(MatchesPlayed = count_home + count_away, 
           
           #Total points earned
           Points = point_home + point_away, 
           
           #PPM
           PPM = round(Points/MatchesPlayed,3), 
           
           #Point percentage= (points/3)*(the number of games played) 
           PtPct = round(Points/(3*MatchesPlayed),2),
           
           #Total wins to find win column of record
           Wins = wins_home + wins_away, 
           
           #Total draws to find draw column of record
           Draws = draws_home + draws_away,
           
           #Total losses to find loss column of record
           Losses = losses_home + losses_away, 
           
           #Record(wins-loses-ties)
           Record = paste0(Wins,'-',Losses,'-',Draws), 
           
           #Home record
           HomeRec = paste0(wins_home,'-',losses_home,'-',draws_home), 
           
           #Away record
           AwayRec = paste0(wins_away,'-',losses_away,'-',draws_away), 
           
           #Goals scored
           GS = goals_for_home + goals_for_away, 
           
           # goals scored per match
           GSM = round(GS/MatchesPlayed,2), 
           
           # goals allowed
           GA = goals_against_home + goals_against_away, 
           
           # goals allowed per match
           GAM = round(GA/MatchesPlayed,2)) 
  
  
  
  # Create a subset to calculate the team’s record over the last 10 games played (Last10)
  
  # last 10 home
  
  last10_home <- df %>%
    
    select(Date1, TeamName = HomeTeam, win = win_home,draw = draw_home,loss = loss_home)
  
  # last 10 away
  last10_away <- df %>%
    
    select(Date1, TeamName = AwayTeam, win = win_away, draw = draw_away,loss = loss_away)
  
  # join last 10 home and last 10 away
  last_10df <- rbind(last10_home, last10_away)
  
  # from last 20 games, only get lasted 10 games played
  join_df <- last_10df %>%
    
    group_by(TeamName) %>%
    
    arrange(desc(Date1)) %>%
    
    top_n(10,wt = Date1) %>%
    
    summarise(Wins = sum(win),
              
              Losses = sum(loss),
              
              Draws = sum(draw)) %>%
    
    mutate(Last10 = paste0(Wins,'-',Losses,'-',Draws)) %>%
    
    select(TeamName,Last10) %>%
    
    # Join last 10 subset with join_df
    inner_join(join_df, by = c('TeamName')) %>% 
    
    # arrange Team Name by alphabetical order
    arrange(TeamName) 
  
  # Create a subset to calculate the team’s current streak
  
  # streak home
  streak_home <- df %>%
    
    select(Date1,TeamName = HomeTeam,FTR) %>%
    
    mutate(result = ifelse(FTR == 'D', 'D', ifelse(FTR == 'H', 'W','L'))) %>%
    
    select(-c(FTR))
  
  # streak away
  streak_away <- df %>%
    
    select(Date1,TeamName = AwayTeam,FTR) %>%
    
    mutate(result = ifelse(FTR == 'D', 'D', ifelse(FTR == 'A', 'W','L'))) %>%
    
    select(-c(FTR))
  
  #Join streak home and streak away
  streak <- rbind(streak_home,streak_away)
  
  #Spread data frame to have date columns
  streak <- rbind(streak_home,streak_away) %>%
    
    spread(key = 'Date1', value = result) %>%
    
    arrange(TeamName)
  
  #Subset of TeamName
  TeamName <- streak$TeamName
  
  #Subset of streak without Team Name but the order of this streak match Team names alphabetical order
  
  #Use function rle() to count consecutive win, draw, lost
  
  streak1 <- apply(streak, 1, function(x) {
    
    x <- x[!is.na(x)]
    
    r <- rle(x)
    
    streak1 = tail(unlist(r[1]),n=1)
    
    streak2 =tail(unlist(r[2]),n=1)
    
    paste0(streak1,streak2)
    
  })
  
  #convert streak subset to a vector
  streak1 <- as.vector(unlist(streak1)) 
  
  # Join team names with its streak
  streak2 <- data.frame(cbind(TeamName,streak1)) %>%
    
    mutate(TeamName = as.character(TeamName)) # convert TeamName from factor to character
  
  # Join streak with join_df, select necessary columns, called this final_df
  final_df <- join_df %>%
    
    inner_join(streak2, by = c('TeamName')) %>%
    
    arrange(desc(PPM), desc(Wins),desc(GSM),GAM) %>%
    
    select(TeamName, Record, HomeRec,AwayRec,MatchesPlayed,Points,PPM,PtPct,GS,GSM,GA,GAM,Last10,Streak = streak1)
  
  return(final_df)
  
}


EPL_Standings("05/23/2021","2020/21")

EPL_Standings("05/22/2022", "2021/22")

EPL_Standings("11/01/2022", "2022/23")