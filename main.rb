# -*- coding: utf-8 -*-
require 'CHaserConnect.rb' #呼び出すおまじない
require 'CHaserAct.rb'
require 'CHaserMap.rb'

# 書き換えない
path = ""
target = CHaserConnect.new("白鷺の姫君") # ()の中好きな名前
map = CHaserMap.new(path)
act = CHaserAct.new(target, path)
values = Array.new(10)
random = Random.new # 乱数生成

mode = "Nomal"

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