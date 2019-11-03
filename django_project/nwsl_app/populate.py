# Populate the database tables 
import os
# import django_project.nwsl_app
from nwsl_app.models import Team_Info_Table
from nwsl_app.models import Player_Info_Table
from nwsl_app.models import Game_Info_Table

def populate():
    game1 = Game_Info_Table.objects.create(home_team='North Carolina Courage', away_team='Sky Blue', 
                                            stadium="Sahlens's Stadium", date='2019-10-12', time='2019-10-12 19:00:00')
    game1.save()
    
    game2 = Game_Info_Table.objects.create(home_team='Orlando Pride', away_team='Reign', 
                                            stadium="Exploria Stadium", date='2019-10-12', time='2019-10-12 19:30:00')
    game2.save()

    team1 = Team_Info_Table.objects.create(team_name='North Carolina Courage', date_founded='2017-01-01', 
                                            city_location='Cary, North Carolina', stadium="Sahlen's Stadium", 
                                            general_manager='Curt Johnson', league='NWSL', current_wins=15, 
                                            current_ties=4, current_losses=5)
    
    team2 = Team_Info_Table.objects.create(team_name='Sky Blue', date_founded='2007-01-01', 
                                            city_location='Piscataway Township, New Jersey', stadium="Yurcak Field", 
                                            general_manager='Alyse LaHue', league='NWSL', current_wins=5, 
                                            current_ties=5, current_losses=14)
    
    # game_place = Game_Info_Table.objects.filter(team_name='')
    
    # Starting roster for NC Courage
    player1_1 = Player_Info_Table.objects.create(first_name='Crystal', last_name='Dunn', date_of_birth='1992-07-03', 
                                                height="5'1", twitter_link='https://twitter.com/crysdunn_19', 
                                                hometown='New Hyde Park, NY', current_club_team=team1, player_club_number=19, 
                                                postition='Forward', national_team='USA', player_national_number=19)

    player1_2 = Player_Info_Table.objects.create(first_name='Lynn', last_name='Williams', date_of_birth='1993-05-21', 
                                                height="5'7", twitter_link='https://twitter.com/lynnraenie', 
                                                hometown='Fresno, California', current_club_team=team1, player_club_number=9, 
                                                postition='Forward', national_team='None', player_national_number=9)
                                            
    player1_3 = Player_Info_Table.objects.create(first_name='Sam', last_name='Mewis', date_of_birth='1992-10-09', 
                                                height="6'0", twitter_link='https://twitter.com/sammymewy', 
                                                hometown='Hanson, Massachusetts', current_club_team=team1, player_club_number=5, 
                                                postition='Midfielder', national_team='USA', player_national_number=3)
    
    player1_4 = Player_Info_Table.objects.create(first_name='McCall', last_name='Zerboni', date_of_birth='1986-12-13', 
                                                height="5'4", twitter_link='https://twitter.com/mccall2', 
                                                hometown='Camarillo, California', current_club_team=team1, player_club_number=7, 
                                                postition='Midfielder', national_team='USA', player_national_number=25)

    player1_5 = Player_Info_Table.objects.create(first_name='Abby', last_name='Dahlkemper', date_of_birth='1993-05-13', 
                                                height="5'7", twitter_link='https://twitter.com/abbydahlkemper', 
                                                hometown='Lancaster, PA', current_club_team=team1, player_club_number=13, 
                                                postition='Defender', national_team='USA', player_national_number=7)
    
    player1_6 = Player_Info_Table.objects.create(first_name='Debora', last_name='Cristiane de Oliveira', date_of_birth='1991-10-20', 
                                                height="5'2", twitter_link='https://twitter.com/debinha7', 
                                                hometown='Brasopolis, Brazil', current_club_team=team1, player_club_number=10, 
                                                postition='Midfielder', national_team='Brazil', player_national_number=9)
    
    player1_7 = Player_Info_Table.objects.create(first_name='Jaelene', last_name='Hinkle', date_of_birth='1993-05-28', 
                                                height="5'4", twitter_link='https://twitter.com/jaehinkle_15', 
                                                hometown='Highlands Ranch, Colorado', current_club_team=team1, player_club_number=15, 
                                                postition='Defender', national_team='USA', player_national_number=19)

    player1_8 = Player_Info_Table.objects.create(first_name='Jessica', last_name='McDonald', date_of_birth='1988-02-28', 
                                                height="5'10", twitter_link='https://twitter.com/j_mac1422', 
                                                hometown='Phoenix, AZ', current_club_team=team1, player_club_number=14, 
                                                postition='Forward', national_team='USA', player_national_number=22)
    
    player1_9 = Player_Info_Table.objects.create(first_name='Heather', last_name="O'Reilly", date_of_birth='1985-01-02', 
                                                height="5'5", twitter_link='https://twitter.com/heatheroreilly', 
                                                hometown='East Brunswick, NJ', current_club_team=team1, player_club_number=17, 
                                                postition='Midfielder', national_team='None', player_national_number=17)

    player1_10 = Player_Info_Table.objects.create(first_name='Abby', last_name="Erceg", date_of_birth='1989-11-20', 
                                                height="5'10", twitter_link='https://twitter.com/abbyerceg', 
                                                hometown='Whangarei, New Zealand', current_club_team=team1, player_club_number=6, 
                                                postition='Defender', national_team='New Zealand', player_national_number=8)

    player1_11 = Player_Info_Table.objects.create(first_name='Katelyn', last_name="Rowland", date_of_birth='1994-03-16', 
                                                height="5'11", twitter_link='https://twitter.com/rowland_katelyn?lang=bn', 
                                                hometown='Walnut Creek, California', current_club_team=team1, player_club_number=99, 
                                                postition='Goalkeeper', national_team='None', player_national_number=99)

    # Starting roster for Sky Blue
    player2_1 = Player_Info_Table.objects.create(first_name='Carli', last_name="Lloyd", date_of_birth='1982-07-16', 
                                                height="5'7", twitter_link='https://twitter.com/carlilloyd', 
                                                hometown='Delran, NJ', current_club_team=team2, player_club_number=10, 
                                                postition='Forward', national_team='USA', player_national_number=10)

    player2_2 = Player_Info_Table.objects.create(first_name='Kailen', last_name="Sheridan", date_of_birth='1995-07-16', 
                                                height="5'9", twitter_link='https://twitter.com/kailen_sheridan', 
                                                hometown='Whitby, Canada', current_club_team=team2, player_club_number=1, 
                                                postition='Goalkeeper', national_team='Canada', player_national_number=18)
    
    player2_3 = Player_Info_Table.objects.create(first_name='Raquel', last_name="Rodríguez", date_of_birth='1993-10-28', 
                                                height="5'5", twitter_link='https://twitter.com/raque_rocky?lang=hr', 
                                                hometown='San José, Costa Rica', current_club_team=team2, player_club_number=11, 
                                                postition='Midfielder', national_team='Costa Rica', player_national_number=11)
    
    player2_4 = Player_Info_Table.objects.create(first_name='Sarah', last_name="Killion", date_of_birth='1992-07-27', 
                                                height="5'8", twitter_link='https://twitter.com/skillion16', 
                                                hometown='Fort Wayne, IN', current_club_team=team2, player_club_number=16, 
                                                postition='Midfielder', national_team='None', player_national_number=16)

    player2_5 = Player_Info_Table.objects.create(first_name='Erica', last_name="Skroski", date_of_birth='1994-02-14', 
                                                height="5'6", twitter_link='https://twitter.com/erica_skroski', 
                                                hometown='Galloway, NJ', current_club_team=team2, player_club_number=8, 
                                                postition='Defender', national_team='None', player_national_number=8)

    player2_6 = Player_Info_Table.objects.create(first_name='Imani', last_name="Dorsey", date_of_birth='1996-03-21', 
                                                height="5'7", twitter_link='https://twitter.com/imdorsey96', 
                                                hometown='Elkridge, MD', current_club_team=team2, player_club_number=28, 
                                                postition='Forward', national_team='None', player_national_number=28)

    player2_7 = Player_Info_Table.objects.create(first_name='Madison', last_name="Tiernan", date_of_birth='1995-07-03', 
                                                height="5'4", twitter_link='https://twitter.com/madisontiernan', 
                                                hometown='Voorhees Township, NJ', current_club_team=team2, player_club_number=73, 
                                                postition='Midfielder', national_team='None', player_national_number=73)

    player2_8 = Player_Info_Table.objects.create(first_name='Jen', last_name="Hoy", date_of_birth='1991-01-18', 
                                                height="5'5", twitter_link='https://twitter.com/jenhoy2', 
                                                hometown='Sellersville, PA', current_club_team=team2, player_club_number=7, 
                                                postition='Forward', national_team='None', player_national_number=7)

    player2_9 = Player_Info_Table.objects.create(first_name='Nahomi', last_name="Kawasumi", date_of_birth='1985-09-23', 
                                                height="5'2", twitter_link='None', 
                                                hometown='Yamato, Kanagawa Prefecture, Japan', current_club_team=team2, player_club_number=9, 
                                                postition='Forward', national_team='Japan', player_national_number=9)

    player2_10 = Player_Info_Table.objects.create(first_name='Mandy', last_name="Freeman", date_of_birth='1995-03-23', 
                                                height="5'8", twitter_link='https://twitter.com/x_mandii', 
                                                hometown='Royal Palm Beach, FL', current_club_team=team2, player_club_number=22, 
                                                postition='Defender', national_team='None', player_national_number=22)

    player2_11 = Player_Info_Table.objects.create(first_name='Paige', last_name="Monaghan", date_of_birth='1996-11-13', 
                                                height="5'7", twitter_link='https://twitter.com/paigeqmonaghan', 
                                                hometown='Succasunna, Roxbury Township, NJ', current_club_team=team2, player_club_number=4, 
                                                postition='Forward', national_team='USA', player_national_number=4)

def delete_all():
    Player_Info_Table.objects.all().delete()
    Team_Info_Table.objects.all().delete()
    Game_Info_Table.objects.all().delete()