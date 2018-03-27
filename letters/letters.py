from Tkinter import *
import math, random
import tkFont

W = 8.5 * 70
H = 11 * 70

root = Tk()
canvas = Canvas(root, width=W, height=H)
canvas.pack(side=TOP)
font = tkFont.Font(family="courier new", size=24)
frameCount = 0

def draw():
  canvas.delete(ALL)
  global frameCount
  points = []
  segs = 25
  loops = 26
  inc = math.pi*2/segs
  for i in range(0, segs * loops):
    rad = 150 + i
    theta = i * inc + (frameCount * i) * 0.0001
    points += [W/2 + math.cos(theta) * rad]
    points += [H/2 + math.sin(theta) * rad]
    canvas.create_text(points[-2], points[-1], text=chr(ord('a')+i%26), font=font)
  #canvas.postscript(file="frame_%04i.ps" % frameCount, colormode="color")
  frameCount += 1
  canvas.after(10, draw)

draw()
mainloop()
