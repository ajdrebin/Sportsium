# LINK TO CODE: https://github.com/KananVyas/PlayerDetection?source=post_page-----6fd2e4e373f0----------------------
# Using this program for testing purposes

#Import libraries
import cv2
import os
import numpy as np

#Reading the video
vidcap = cv2.VideoCapture('nwsl_footage/Chicago_Red_Stars_vs_Orlando_Pride.mp4')


success,image = vidcap.read()
count = 0
success = True
idx = 0

#Read the video frame by frame
while success:
	#converting into hsv image
	hsv = cv2.cvtColor(image,cv2.COLOR_BGR2HSV)

	#green range
	lower_green = np.array([40, 40, 40])
	# !!!!!
	upper_green = np.array([70, 255, 255])
	# !!!!!!!!!!!!!!!!!!!!!
################################################################################



	# HOME range
	# lower_home = np.array([5,0,0])
	# upper_home = np.array([45,255,255])

	lower_home = np.array([95,90,20])
	upper_home = np.array([140,255,255])















	# AWAY range
	lower_away = np.array([0,0, 80])
	upper_away = np.array([40,30,255])


	# lower_away =  np.array([0,0,0])
	# upper_away = np.array([180,255,255])
###########################################################################
	#white range
	lower_white = np.array([0,0,0])
	upper_white = np.array([0,0,255])

    #Define a mask ranging from lower to uppers
	mask = cv2.inRange(hsv, lower_green, upper_green)

    #Do masking
	res = cv2.bitwise_and(image, image, mask=mask)

	#convert to hsv to gray
	res_bgr = cv2.cvtColor(res,cv2.COLOR_HSV2BGR)
	res_gray = cv2.cvtColor(res,cv2.COLOR_BGR2GRAY)

    #Defining a kernel to do morphological operation in threshold image to 
    #get better output.
	kernel = np.ones((13,13),np.uint8)
	thresh = cv2.threshold(res_gray,127,255,cv2.THRESH_BINARY_INV | cv2.THRESH_OTSU)[1]
	thresh = cv2.morphologyEx(thresh, cv2.MORPH_CLOSE, kernel) 

    #find contours in threshold image  
	contours,hierarchy = cv2.findContours(thresh,cv2.RETR_TREE,cv2.CHAIN_APPROX_SIMPLE)
	

	prev = 0
	font = cv2.FONT_HERSHEY_SIMPLEX
	
	for c in contours:
		x,y,w,h = cv2.boundingRect(c)
		
		#Detect players
		if(h>=(1.5)*w):
			if(w>15 and h>= 15):
				idx = idx+1
				player_img = image[y:y+h,x:x+w]
				player_hsv = cv2.cvtColor(player_img,cv2.COLOR_BGR2HSV)
				#If player has blue jersy
				mask1 = cv2.inRange(player_hsv, lower_home, upper_home)
				res1 = cv2.bitwise_and(player_img, player_img, mask=mask1)
				res1 = cv2.cvtColor(res1,cv2.COLOR_HSV2BGR)
				res1 = cv2.cvtColor(res1,cv2.COLOR_BGR2GRAY)
				nzCount = cv2.countNonZero(res1)
				#If player has red jersy
				mask2 = cv2.inRange(player_hsv, lower_away, upper_away)
				res2 = cv2.bitwise_and(player_img, player_img, mask=mask2)
				res2 = cv2.cvtColor(res2,cv2.COLOR_HSV2BGR)
				res2 = cv2.cvtColor(res2,cv2.COLOR_BGR2GRAY)
				nzCountred = cv2.countNonZero(res2)

				if(nzCount >= 30):
					#Mark blue jersy players as france
					cv2.putText(image, 'Home', (x-2, y-2), font, 0.8, (0,0,0), 2, cv2.LINE_AA)
					cv2.rectangle(image,(x,y),(x+w,y+h),(0,0,0),3)
				else:
					pass
				if(nzCountred>=30):
					#Mark red jersy players as belgium
					cv2.putText(image, 'Away', (x-2, y-2), font, 0.8, (255,255,255), 2, cv2.LINE_AA)
					cv2.rectangle(image,(x,y),(x+w,y+h),(255,255,255),3)
				else:
					pass
		if((h>=1 and w>=1) and (h<=30 and w<=30)):
			player_img = image[y:y+h,x:x+w]
		
			player_hsv = cv2.cvtColor(player_img,cv2.COLOR_BGR2HSV)
			#white ball  detection
			mask1 = cv2.inRange(player_hsv, lower_white, upper_white)
			res1 = cv2.bitwise_and(player_img, player_img, mask=mask1)
			res1 = cv2.cvtColor(res1,cv2.COLOR_HSV2BGR)
			res1 = cv2.cvtColor(res1,cv2.COLOR_BGR2GRAY)
			nzCount = cv2.countNonZero(res1)
	

			if(nzCount >= 3):
				# detect football
				cv2.putText(image, 'football', (x-2, y-2), font, 0.8, (0,255,0), 2, cv2.LINE_AA)
				cv2.rectangle(image,(x,y),(x+w,y+h),(0,255,0),3)


	cv2.imwrite("./Cropped/frame%d.jpg" % count, res)
	print ('Read a new frame: ', success)     # save frame as JPEG file	
	count += 1
	cv2.imshow('Match Detection',image)
	
	if cv2.waitKey(1) & 0xFF == ord('q'):
		break
	success,image = vidcap.read()
    
vidcap.release()
cv2.destroyAllWindows()

