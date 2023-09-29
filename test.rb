require "CHMatCal.rb"

values = [1, 1, 2, 1, 0, 0, 2, 0, 0, 1]
mat = CHMatrixCalc.new(values)
mat.mtPut()
hoge = mat.checkPattern([1,2,1])
p hoge