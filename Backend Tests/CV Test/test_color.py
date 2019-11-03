from colorfilters import HSVFilter
import cv2 

img = cv2.imread("Red_vs_Courage_test_1.jpg")
window = HSVFilter(img)
window.show()

print(f"Image filtered in HSV between {window.lowerb} and {window.upperb}.")