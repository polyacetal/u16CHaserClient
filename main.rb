# -*- coding: utf-8 -*-
require 'CHaserConnect.rb' #呼び出すおまじない
require 'CHaserAct.rb'

# 書き換えない
path = ""
target = CHaserConnect.new("白鷺の姫君") # ()の中好きな名前
act = CHaserAct.new(target, path)
values = Array.new(10)
random = Random.new # 乱数生成

direction = 0 # 0上,1右,2下,3左
mode = "Nomal"
beforeMove = 4

#--------ここから--------
loop do # ここからループ

#---------ここから---------
  values = target.getReady

  if values[0] == 0
    break
  end
#-----ここまで書き換えない-----

eval("mode = act." + mode + "(values)")

#---------ここから---------
  if values[0] == 0
    break
  end

end # ループここまで
target.close
#-----ここまで書き換えない-----