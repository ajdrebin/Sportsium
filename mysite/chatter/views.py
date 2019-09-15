from django.shortcuts import render
from django.http import JsonResponse, HttpResponse
from django.db import connection 
from django.views.decorators.csrf import csrf_exempt
import json

@csrf_exempt
def getchatts(request):     
	if request.method != 'GET':         
		return HttpResponse(status=404)     
	response = {}     
	cursor = connection.cursor() 
	cursor.execute('SELECT * FROM chatts;') 
	# cursor.execute('select * from information_schema.tables')
	rows = cursor.fetchall()
	response['chatts'] = rows    
	return JsonResponse(response)

@csrf_exempt
def addchatt(request):
	if request.method != 'POST':
		return HttpResponse(status=404)
	json_data = json.loads(request.body)
	username = json_data['username']
	message = json_data['message']
	cursor = connection.cursor()
	cursor.execute('INSERT INTO chatts (username, message) VALUES '
		'(%s, %s);', (username, message))
	return JsonResponse({})


@csrf_exempt
def adduser(request):
	if request.method != 'POST':
		return HttpResponse(status=404)
	json_data = json.loads(request.body)
	username = json_data['username']
	email = json_data['email']
	name = json_data['name']
	cursor = connection.cursor()
	cursor.execute('INSERT INTO users (username, name, email) VALUES '
		'(%s, %s);', (username, name, email))
	return JsonResponse()

# def deletechatt(request):
# 	if request.method != 'DELETE':
# 		return HttpResponse(status=404)
# 	json_data = json_data



