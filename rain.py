import random

thresh = random.random()

for i in range(10):
  line = " "
  for j in range(60):
    character = " "
    if(random.random() > thresh):
      character = "/"
    line += character  
  print(line)

