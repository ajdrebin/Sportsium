# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.db import models

# Create your models here.
class Team_Info_Table(models.Model):
    """ Team_Info_Table holds a team's information"""
    # team info
    team_name = models.CharField(max_length=128, primary_key=True)
    date_founded = models.CharField(max_length=32, blank=True)
    city_location = models.CharField(max_length=256, blank=True)
    stadium = models.CharField(max_length=256, blank=True)
    head_coach = models.CharField(max_length=256, blank=True)
    league = models.CharField(max_length=256)

    # team wins, ties, losses for season
    current_wins = models.CharField(max_length=8, blank=True)
    current_ties = models.CharField(max_length=8, blank=True)
    current_losses = models.CharField(max_length=8, blank=True)

    # team social media
    fb = models.CharField(max_length=256, blank=True)
    twitter = models.CharField(max_length=256, blank=True)
    instagram = models.CharField(max_length=256, blank=True)
    snapchat = models.CharField(max_length=256, blank=True)

    def __str__(self):
        return ("team_name: " + self.team_name + " "
        + "date_founded: " + self.date_founded + " "
        + "city_location: " + self.city_location + " "
        + "stadium: " + self.stadium + " "
        + "head_coach: " + self.head_coach + " "
        + "league: " + self.league + " "
        + "current_wins: " + self.current_wins + " "
        + "current_ties: " + self.current_ties + " "
        + "current_losses: " + self.current_losses + " "
        + "fb: " + self.fb + " "
        + "twitter: " + self.twitter + " "
        + "instagram: " + self.instagram + " "
        + "snapchat: " + self.snapchat)



class Player_Info_Table(models.Model):
    """ Player_Info_Table holds a player's information """
    # player unique identifier
    player_id = models.AutoField(primary_key=True)

    # player personal info
    first_name = models.CharField(max_length=64)
    last_name = models.CharField(max_length=64)
    number = models.CharField(max_length=8, blank=True)
    position = models.CharField(max_length=128, blank=True)
    hometown = models.CharField(max_length=256, blank=True)
    country = models.CharField(max_length=256, blank=True)
    date_of_birth = models.CharField(max_length=16, blank=True)
    height = models.CharField(max_length=8, blank=True)
    
    # player social media
    fb = models.CharField(max_length=256, blank=True)
    twitter = models.CharField(max_length=256, blank=True)
    instagram = models.CharField(max_length=256, blank=True)
    snapchat = models.CharField(max_length=256, blank=True)

    def __str__(self):
        return ("player_id: " + str(self.player_id) + " "
        + "first_name: " + self.first_name + " "
        + "last_name: " + self.last_name + " "
        + "number: " + self.number + " "
        + "position: " + self.position + " "
        + "hometown: " + self.hometown + " "
        + "country: " + self.country + " "
        + "date_of_birth: " + self.date_of_birth + " "
        + "height: " + self.height + " "
        + "fb: " + self.fb + " "
        + "twitter: " + self.twitter + " "
        + "instagram: " + self.instagram + " "
        + "snapchat: " + self.snapchat)

class Team_Player_Table(models.Model):
    """ Team_Player_Table holds the relationship between teams and players """
    team = models.ForeignKey(Team_Info_Table, on_delete=models.CASCADE)
    player = models.ForeignKey(Player_Info_Table, on_delete=models.CASCADE)

    def __str__(self):
        return ("team_name: " + self.team.team_name + " "
        + "player: " + self.player.first_name + " " + self.player.last_name)


class Game_Info_Table(models.Model):
    """ Game_Info_Table holds a game's information """
    game_id = models.AutoField(primary_key=True)
    home_team = models.CharField(max_length=128)
    away_team = models.CharField(max_length=128)
    stadium = models.CharField(max_length=128)
    date = models.CharField(max_length=16) # YYYY-MM-DD
    time = models.CharField(max_length=16)

    def __str__(self):
        return ("game_id: " + self.game_id + " "
        + "home_team: " + self.home_team + " "
        + "away_team: " + self.away_team + " "
        + "stadium: " + self.stadium + " "
        + "date: " + self.date + " "
        + "time: " + self.time)
