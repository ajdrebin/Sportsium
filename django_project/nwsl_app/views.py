# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.shortcuts import render, get_object_or_404
from django.http import JsonResponse, HttpResponse
from django.db import connection

import datetime
import json

from .models import Team_Info_Table
from .models import Player_Info_Table
from .models import Game_Info_Table

# Create your views here.

""" Server returns a list of all games being played that day"""
def game_check(request):
    if request.method != 'GET':
        return HttpResponse(status=404)
    response = {}

    # obtaining date and checking for query result
    date = datetime.datetime.now().date()
    q_set_games = Game_Info_Table.objects.all()
    if len(q_set_games) < 1:
        response['debug'] = "need to add data"
        return JsonResponse(response) 

    # return data for each game being played today
    game_count = 0
    for game in q_set_games:
        temp = {}
        temp['game_id'] = game.game_id
        temp['home'] = game.home_team
        temp['away'] = game.away_team
        temp['time'] = game.time
        temp['stadium'] = game.stadium         
        response[game.game_id] = temp
        game_count += 1
    response['total_num_games'] = game_count
    
    return JsonResponse(response)


""" Server returns both team's roster and basic player info"""
def check_in(request):
    if request.method != 'GET':
        return HttpResponse(status=404)
    response = {}

    # check what game is being looked at return 404 if None found
    game_id = request.GET.get('game_id', None)
    if game_id == None:
        return HttpResponse(status=404)
    
    # obtain the two teams of interest
    game_obj = get_object_or_404(Game_Info_Table, pk=game_id)
    home_team = game_obj.home_team
    away_team = game_obj.away_team
    
    # obtain query set for each team
    q_set_h_players = Player_Info_Table.objects.filter(current_club_team__exact=home_team)
    q_set_a_players = Player_Info_Table.objects.filter(current_club_team__exact=away_team)
    
    if len(q_set_h_players) < 1 or len(q_set_a_players) < 1:
        response['debug'] = "Either home or away team is incorrect"
        return JsonResponse(response)

    # add home team to response
    h_player_holder = []
    for h_player in q_set_h_players:
        temp_h = {}
        temp_h['player_id'] = h_player.player_id
        temp_h['first_name'] = h_player.first_name
        temp_h['last_name'] = h_player.last_name
        temp_h['player_club_number'] = h_player.player_club_number
        temp_h['position'] = h_player.position
        h_player_holder.append(temp_h)
    response[home_team] = h_player_holder

    # get home team's win loss ratio and manager
    home_team_obj = get_object_or_404(Team_Info_Table, pk=home_team)
    response['home_wins'] = home_team_obj.current_wins
    response['home_ties'] = home_team_obj.current_ties
    response['home_losses'] = home_team_obj.current_losses
    response['home_manager'] = home_team_obj.general_manager

    # add away team to response
    a_player_holder = []
    for a_player in q_set_a_players:
        temp_a = {}
        temp_a['player_id'] = a_player.player_id
        temp_a['first_name'] = a_player.first_name
        temp_a['last_name'] = a_player.last_name
        temp_a['player_club_number'] = a_player.player_club_number
        temp_a['position'] = a_player.position
        a_player_holder.append(temp_a)
    response[away_team] = a_player_holder
    
     # get away team's win loss ratio and manager
    away_team_obj = get_object_or_404(Team_Info_Table, pk=away_team)
    response['away_wins'] = away_team_obj.current_wins
    response['away_ties'] = away_team_obj.current_ties
    response['away_losses'] = away_team_obj.current_losses
    response['away_manager'] = away_team_obj.general_manager

    return JsonResponse(response)


""" Server returns a specific player bio, stats, and social media"""
def player_lookup(request):
    if request.method != 'GET':
        return HttpResponse(status=404)
    response = {}

    # check what player is being looked at return 404 if None found
    player_id = request.GET.get('player_id', None)
    if player_id == None:
        return HttpResponse(status=404)
 
    # obtain specific player using player_id and add to response
    player_obj = get_object_or_404(Player_Info_Table, pk=player_id)
    response['player_id'] = player_obj.player_id
    response['first_name'] = player_obj.first_name
    response['last_name'] = player_obj.last_name
    response['DOB'] = player_obj.date_of_birth
    response['height'] = player_obj.height
    response['twitter_link'] = player_obj.twitter_link
    response['hometown'] = player_obj.hometown
    response['current_club_team'] = player_obj.current_club_team.team_name
    response['current_club_number'] = player_obj.player_club_number
    response['position'] = player_obj.position
    response['national_team'] = player_obj.national_team
    response['player_national_number'] = player_obj.player_national_number
 
    return JsonResponse(response)


""" Server returns a team's stats and history"""
def team_lookup(request):
    if request.method != 'GET':
        return HttpResponse(status=404)
    response = {}

    # check what team is being looked at return 404 if none found
    team_name = request.GET.get('team_name', None)
    if team_name == None:
        return HttpResponse(status=404)

    # obtain specific team using team_name and add to response
    team_obj = get_object_or_404(Team_Info_Table, pk=team_name)
    response['team_name'] = team_obj.team_name
    response['date_founded'] = team_obj.date_founded
    response['city_location'] = team_obj.city_location
    response['stadium'] = team_obj.stadium
    response['general_manager'] = team_obj.general_manager
    response['league'] = team_obj.league
    response['current_wins'] = team_obj.current_wins
    response['current_ties'] = team_obj.current_ties
    response['current_losses'] = team_obj.current_losses

    return JsonResponse(response)



