# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models

# Create your models here.
class Team_Info_Table(models.Model):
    # team info
    team_name = models.CharField(max_length=128, primary_key=True)
    date_founded = models.DateField(max_length=8)
    city_location = models.CharField(max_length=256)
    stadium = models.CharField(max_length=256)
    general_manager = models.CharField(max_length=256)
    league = models.CharField(max_length=256)

    # current win, ties, loss for season
    current_wins = models.IntegerField()
    current_ties = models.IntegerField()
    current_losses = models.IntegerField()


    pass


class Player_Info_Table(models.Model): 
    # player personal info
    player_id = models.AutoField(primary_key=True)
    first_name = models.CharField(max_length=64)
    last_name = models.CharField(max_length=64)
    date_of_birth = models.DateField(max_length=8)
    height = models.CharField(max_length=16)
    twitter_link = models.CharField(max_length=512)



    # player club team info
    current_club_team = models.ForeignKey(Team_Info_Table, on_delete=models.CASCADE)
    player_club_number = models.IntegerField()

    # !!! might limit the number of positions (might do same to clubs)
    postition = models.CharField(max_length=256)

    # player national team
    national_team = models.CharField(max_length=256)
    player_national_number = models.IntegerField()


    pass

class Game_Info_Table(models.Model):
    # !!!
    game_id = models.AutoField(primary_key=True)
    home_team = models.CharField(max_length=128)
    away_team = models.CharField(max_length=128)
    stadium = models.CharField(max_length=128)
    date = models.DateField(max_length=16)
    time = models.DateTimeField(max_length=16)

    pass

