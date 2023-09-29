class CHMatCal
    def initialize()    #コンストラクタ
        #arry: 2次元配列にする配列
        #自分の周辺を2次元配列に落とし込む
        @mat = Array.new(3){Array.new(3, 0)}
    end

    def setMat(values)
        Matclear()
        for i in 1 .. 9 do
            @mat[(i-1)/3][(i-1)%3] = values[i]
        end
    end

    def Matclear()
        for i in 1 .. 9 do
            @mat[(i-1)/3][(i-1)%3] = 0
        end
    end

    def mtPut()
        for i in 0 .. 2 do
            for j in 0 .. 2 do
                print(@mat[i][j])
            end
            print("\n")
        end
    end

    def checkPattern(patList)
        direction = []
        direction.push("Up") if @mat[0] == patList
        direction.push("Down") if @mat[2] == patList
        direction.push("Left") if @mat.transpose[0] == patList
        direction.push("Right") if @mat.transpose[2] == patList
        return direction
    end

end