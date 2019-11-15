import json
import requests
import os

from bs4 import BeautifulSoup

# import django_project.nwsl_app
from nwsl_app.models import Team_Info_Table
from nwsl_app.models import Player_Info_Table
from nwsl_app.models import Game_Info_Table
from nwsl_app.models import Team_Player_Table

def delete_all():
    Player_Info_Table.objects.all().delete()
    Team_Info_Table.objects.all().delete()
    Game_Info_Table.objects.all().delete()
    Team_Player_Table.objects.all().delete()

def debug_tables():
    print("Player_Info_Table:")
    print(Player_Info_Table.objects.all())
    print("Team_Info_Table:")
    print(Team_Info_Table.objects.all())
    print("Team_Player_Table:")
    print(Team_Player_Table.objects.all())
    print("Game_Info_Table:")
    print(Game_Info_Table.objects.all())


def populate():
    # create list of team urls 9 total
    
    team_urls = []
    team_urls.append("chicago-red-stars")
    team_urls.append("houston-dash")
    team_urls.append("north-carolina-courage")
    team_urls.append("orlando-pride")
    team_urls.append("portland-thorns")
    team_urls.append("reign")
    team_urls.append("sky-blue")
    team_urls.append("utah-royals")
    team_urls.append("washington-spirit")

    date_founded = {}
    date_founded["chicago-red-stars"] = "2006"
    date_founded["north-carolina-courage"] = "2009"
    date_founded["orlando-pride"] = "October 20, 2015"
    date_founded["houston-dash"] = "December 11, 2013"
    date_founded["portland-thorns"] = "2012"
    date_founded["reign"] = "2012"
    date_founded["sky-blue"] = "2007"
    date_founded["utah-royals"] = "December 1, 2017"
    date_founded["washington-spirit"] = "2011"

    city_location = {}
    city_location["chicago-red-stars"] = "Bridgeview, Illinois"
    city_location["north-carolina-courage"] = "Cary, North Carolina"
    city_location["orlando-pride"] = "Orlando, Florida"
    city_location["houston-dash"] = "Houston, Texas"
    city_location["portland-thorns"] = "Portland, Oregon"
    city_location["reign"] = "Tacoma, Washington"
    city_location["sky-blue"] = "Piscataway, New Jersey"
    city_location["utah-royals"] = "Sandy, Utah"
    city_location["washington-spirit"] = "Germantown, Maryland"

    url_base = "http://www.nwslsoccer.com"
    url_base_teams = "http://www.nwslsoccer.com/teams/"
    league = "NWSL"

    for team in team_urls:
        print("###############" + team)

        # creating a BeautifulSoup object
        htmlContent = requests.get(url_base_teams + team)
        soup = BeautifulSoup(htmlContent.text, 'html.parser')

        # parsing head coach
        final_head_coach = ""
        head_coach = soup.find("span", {"class": "jsx-2285198277 team-top-section__team-head-coach"})
        if head_coach != None:
            count = 0
            for line in head_coach:
                if count == 2:
                    final_head_coach = line
                    count = 0
                else:
                    count += 1
        
        # parsing home field
        final_stadium = ""
        home_field = soup.find("span", {"class": "jsx-2285198277 team-top-section__team-home-field"})
        if home_field != None:
            count = 0
            for line in home_field:
                if count == 2:
                    final_stadium = line
                    count = 0
                else:
                    count += 1

        # parsing media items
        final_fb = ""
        final_twitter = ""
        final_instagram = ""
        final_snapchat = ""
        media_items = soup.find_all("li", {"class": "jsx-428482374 social-media-links__item"})
        if media_items != None:            
            for li_item in media_items:
                letter_social = li_item.a.get("aria-label")[6] 
                if letter_social == 'f':
                    final_fb = li_item.a.get('href')  
                elif letter_social == 't':
                    final_twitter = li_item.a.get('href')
                elif letter_social == 'i':
                    final_instagram = li_item.a.get('href')
                elif letter_social == 's':
                    final_snapchat = li_item.a.get('href')
        
    
        # parsing team results
        team_results = soup.find_all("span", {"class": "jsx-2285198277 team-top-section__team-results"})
        final_wins = 0
        final_losses = 0
        final_ties = 0
        wins_str = ""
        losses_str = ""
        ties_str = ""
        is_losses = False
        is_ties = False
        for letter in team_results[0].text:
            if letter == ',':
                is_losses = False
                is_ties = False
                final_wins = int(wins_str)
                final_losses = int(losses_str)
                final_ties = int(ties_str)
                wins_str = ""
                losses_str = ""
                ties_str = ""
            elif letter == 'h':
                break
            elif letter == '-':
                if is_losses == False and is_ties == False:
                    is_losses = True
                elif is_losses == True and is_ties == False:
                    is_losses = False
                    is_ties = True
            elif is_losses == False and is_ties == False:
                wins_str += letter
            elif is_losses == True and is_ties == False:
                losses_str += letter
            elif is_losses == False and is_ties == True:
                ties_str += letter

        final_wins += int(wins_str)
        final_losses += int(losses_str)
        final_ties += int(ties_str)

        # registering the team
        team_obj = Team_Info_Table.objects.create(
            team_name=team,
            date_founded=date_founded[team],
            city_location=city_location[team],
            stadium=final_stadium,
            head_coach=final_head_coach,
            league=league,
            current_wins=final_wins,
            current_ties=final_ties,
            current_losses=final_losses,
            fb=final_fb,
            twitter=final_twitter,
            instagram=final_instagram,
            snapchat=final_snapchat
            )
        team_obj.save()

        # parsing player roster
        player_roster = soup.find_all("div", {"class": "jsx-3034400795 c-players-table-row without-team-cell"})
        if player_roster != None:
            for player in player_roster:
                # go to each player's web page
                players_href = player.div.a.get('href')
                player_htmlContent = requests.get(url_base + players_href)
                player_soup = BeautifulSoup(player_htmlContent.text, 'html.parser')
                
                print(players_href)

                # player number
                player_number = player_soup.find("span", {"class": "jsx-3410377750"}).text
                
                # player first and last name
                player_first_name = ""
                player_last_name = ""
                player_name_and_social = player_soup.find("div", {"class": "jsx-3410377750 player-top-section__player-name-wrapper"})          
                count = 0
                for line in player_name_and_social.span:
                    if count == 0:
                        player_first_name = line
                    if count == 4: 
                        player_last_name = line
                    count += 1


                # player social media
                player_fb = ""
                player_twitter = ""
                player_instagram = ""
                player_snapchat = ""
                for li_item in player_name_and_social.ul:
                    letter_social = li_item.a.get("aria-label")[6] 
                    if letter_social == 'f':
                        player_fb = li_item.a.get('href')   
                    elif letter_social == 't':
                        player_twitter = li_item.a.get('href')
                    elif letter_social == 'i':
                        player_instagram = li_item.a.get('href')
                    elif letter_social == 's':
                        player_snapchat = li_item.a.get('href')
                        
                # player info: position, date_of_birth, height, hometown, country
                player_position = ""
                player_date_of_birth = ""
                player_height = ""
                player_hometown = ""
                player_country = ""
                player_info = player_soup.find("div", {"class": "jsx-3410377750 player-top-section__player-info-container"})
                if player_info != None:
                    for i in player_info:
                        if i == "NaN":
                            continue
                        title = i.select('span')[0].get_text(strip=True)
                        if title == "position:":
                            player_position = i.select('span')[1].get_text(strip=True)
                        elif title == "age:":
                            player_date_of_birth = i.select('span')[1].get_text(strip=True)[3:13]
                        elif title == "height:":
                            player_height = i.select('span')[1].get_text(strip=True)
                        elif title == "hometown:":
                            player_hometown = i.select('span')[1].get_text(strip=True)
                        elif title == "country:":
                            player_country = i.select('span')[1].get_text(strip=True)



                # creating the player object
                player_obj = Player_Info_Table.objects.create(
                    first_name=player_first_name,
                    last_name=player_last_name,
                    number=player_number,
                    position=player_position,
                    hometown=player_hometown,
                    country=player_country,
                    date_of_birth=player_date_of_birth,
                    height=player_height,
                    fb=player_fb,
                    twitter=player_twitter,
                    instagram=player_instagram,
                    snapchat=player_snapchat
                )
                player_obj.save()

                team_player_obj = Team_Player_Table.objects.create(
                    team=team_obj,
                    player=player_obj
                )
                team_player_obj.save()

                # !!! including for now due to robot issues
                # break
