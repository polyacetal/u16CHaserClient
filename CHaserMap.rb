class CHaserMap

    def initialize(path)
        if path == ""
            NoMap()
        else
            ExistanceMap(path)
        end
    end

    def ExistanceMap(path)

    end

    def NoMap()
        @nowMap = Array.new(33) {Array.new(41)} #現在の状態のmap
        @entireMap = Array.new(33) {Array.new(41)}
        @x = 21
        @y = 16
    end

    def MovePosition()
        case @direction
            when "Up"
                @y = @y - 1
            when "Left"
                @x = @x - 1
            when "Right"
                @x = @x + 1
            when "Down"
                @y = @y + 1
        end
    end
