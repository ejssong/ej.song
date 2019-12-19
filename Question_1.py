def equalsWhenOneCharRemoved(x,y):

    len_x = len(x)
    len_y = len(y)
    
    if abs(len_x - len_y) != 1:
        return False
        
    i = 0
    j = 0 
    while x[i] != y[j]:
        i += 1
        j += 1
        return False
        
        if abs(x[i] - y[j]) > 1 :
            return False
        elif abs(x[i] - y[j]) == 1:
            return True   
    
    return True

#Return False
print(equalsWhenOneCharRemoved("x","y"))
print(equalsWhenOneCharRemoved("x","XX"))
print(equalsWhenOneCharRemoved("yy","yx"))

#Return True
print(equalsWhenOneCharRemoved("abcd","abxcd"))
print(equalsWhenOneCharRemoved("xyz","xz"))

