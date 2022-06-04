extends Sprite


	#position.y += 5
	#position.y =   -249 + (48.0/10 * float(array2[9]))

func _on_Sprite_Leitura(array2, pinit, init):
	
	#position.y = -4.5 +29.5 + (49.3597/5.0 * float(Debug.x)) #21.0 #array2[13]
	#position.y = 29.5 + (49.3597/5.0 * float(Debug.x))
	#print(position.y)
	#if(float(Debug.x) <= -65):
		#position.y = -621
	#else:
	position.y = -4.5 +29.5 + (49.3597/2.0 * float(Debug.x)) 
	#-249 + (48.0/10 * float(array2[9]))
#34
