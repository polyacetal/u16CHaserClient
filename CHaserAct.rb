class CHaserAct

    def initialize(target, path)  #コンストラクタ
        @target = target    #main.rbのtargetをインスタンス変数として持つ
        @values = Array.new(10) #valuesの配列
        @lookValues = Array.new(10) #lookした値
        @searchValues = Array.new(10)   #searchした値
        @blockDire = [] #ブロックのある方向(斜めも含む上下左右)
        @itemDire = []  #アイテムのある方向(斜めも含む上下左右)
        @beforeMove = []    #前回移動した方向(常に先頭が1つ前の行動になるよう配列が伸びる)
        @ableDirection = ["Up", "Left", "Right", "Down"] #行動可能方向の定数(これと差分を取ることでいい感じになる)
        @direction = "Start" #方向を文字列で持つ(最初はstart)
        map = CHaserMap.new(path)
    end

    def Move()  #walkの処理
        eval("@values = @target.walk" + @direction + "()")   #移動方向と合わせて文字列で評価する
        @beforeMove.unshift(@direction) #移動した方向をbeforeMoveに代入(多分いらなくなる)
    end

    def Search()   #searchの処理
        eval("@searchValues = @target.search" + @direction + "()")
        #return searchValues
    end

    def Look()  #lookの処理
        eval("@lookValues = @target.look" + @direction + "()")
    end

    def Put()
        eval("@values = @target.put" + @direction + "()")
    end

    def MarkDire(num, aryName)  #指定された配列に数字に対応した方向を記録する
        case num                #ただし真ん中(5)は基本通路(0)なので無視する
            when 1  #左上を記録
                eval("" + aryName + ".push(\"LeftUp\")")
            when 2  #上を記録
                eval("" + aryName + ".push(\"Up\")")
            when 3  #右上を記録
                eval("" + aryName + ".push(\"RightUp\")")
            when 4  #左を記録
                eval("" + aryName + ".push(\"Left\")")
            when 6  #右を記録
                eval("" + aryName + ".push(\"Right\")")
            when 7  #左下を記録
                eval("" + aryName + ".push(\"LeftDown\")")
            when 8  #下を記録
                eval("" + aryName + ".push(\"Down\")")
            when 9  #右下を記録
                eval("" + aryName + ".push(\"RightDown\")")
        end
    end

    def WhereBlock()    #自分の周囲のどの方向にブロックがあるか記録する
        for i in 1..9 do
            MarkDire(i, "@blockDire") if @values[i] == 2    #記録する配列は@blockDire
        end
    end

    def WhereItem()     #自分の周囲のどの方向にアイテムがあるか記録する
        for i in 1..9 do
            MarkDire(i, "@itemDire") if @values[i] == 3     #記録する配列は@itemDire
        end
    end

    def Nomal(values)   #通常時の行動メソッド(壁避けとランダムウォーク)
        @values = values
        WhereBlock()
        ableMove = @ableDirection - @blockDire
        @direction = ableMove.sample
        Move()
        @blockDire.clear
        return ItemCheck()
    end

    def SuspicionTrap() #トラップの可能性があるかのチェック
        selection = "ItemGet"   #トラップがなければ次のメソッドをItemGetに
        case @direction
            when "Up"   #上にトラップの可能性
                if @values[1] == 2 && @values[3] == 2
                    selection = "isTrap"    #次のメソッドをisTrapに
                end
            when "Left"
                if @values[1] == 2 && @values[7] == 2
                    selection = "isTrap"    #次のメソッドをisTrapに
                end
            when "Right"
                if @values[3] == 2 && @values[9] == 2
                    selection = "isTrap"    #次のメソッドをisTrapに
                end
            when "Down"
                if @values[7] == 2 && @values[9] == 2
                    selection = "isTrap"    #次のメソッドをisTrapに
                end
        end
        return selection    #selectionをreturnする
    end

    def ItemCheck() #getReadyで手に入れた情報のアイテム処理用のメソッド
        WhereItem()
        ableItem = @ableDirection - @itemDire
        @direction = ableItem.sample
        @itemDire.clear
        if ableItem.length == 0
            selection = "Nomal"
        else
            selection = SuspicionTrap(ableItem)
        end
        return selection
    end

    def isTrap(values)
        Look()
        if lookValues[5] == 2
            selection = "PutBlock"
        else
            selection = "ItemGet"
        end
        return selection
    end

    def PutBlock(values)
        @values = values
        Put()
        return "Nomal"
    end

    def ItemGet(values)
        @values = values
        Move()
        return "Nomal"
    end
end