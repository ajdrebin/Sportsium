# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection
import json


# Create your views here.

""" Server returns a list of all games being played that day"""
def game_check(request):
    if request.method != 'GET':
        return HttpResponse(status=404)

    response = {}

    return JsonResponse(response)


""" Server returns both team's roster and basic player info"""
def check_in(request):
    if request.method != 'GET':
        return HttpResponse(status=404)

    response = {}

    return JsonResponse(response)


""" Server returns a specific player bio, stats, and social media"""
def player_lookup(request):
    if request.method != 'GET':
        return HttpResponse(status=404)

    response = {}

    return JsonResponse(response)


""" Server returns a team's stats and history"""
def team_lookup(request):
    if request.method != 'GET':
        return HttpResponse(status=404)

    response = {}

    return JsonResponse(response)



