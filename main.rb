class Game
    X = "X"
    O = "O"
    attr_accessor :board
    attr_reader :curPlayer, :player1Name, :player2Name
    def initialize(name1, name2)
        @player1Name = name1;
        @player2Name = name2;
        @size = 3;
        @board = Array.new(@size){Array.new(@size){nil}};
        @curPlayer = 0
    end

    def play(x, y)
        return false if(board[x][y] != nil)
        
        curChar = X
        curChar = O if(@curPlayer == 1)

        @curPlayer = (@curPlayer + 1)%2
        board[x][y] = curChar
        
        return true
    end

    def check()
        if(checkRows() || checkCols() || checkDiagonals())
            return @curPlayer
        end
        if(checkDraw() == true)
            return "Draw"
        end
        return false
    end

    def printBoard()
        print "  "
        for i in (0...@size)
            print i.to_s + " "
        end
        puts
        for i in (0...@size)
            print i.to_s + " "
            for j in (0...@size)
                if(@board[i][j] == nil)
                    print ". "
                else
                    print @board[i][j].to_s + " "
                end
            end
            puts
        end
    end

    private
    def checkRows()
        for i in (0...@size)do
            if(board[i].count(X) == @size || board[i].count(O) == @size )
                return true;
            end
        end
        return false
    end

    def checkCols()
        for i in (0...@size)do
            col = board.map{|row| row[i]}
            if(col.count(X) == @size || col.count(O) == @size )
                return true;
            end
        end
        return false
    end

    def checkDiagonals()
       return (checkSingleDiagonal(0) || checkSingleDiagonal(@size - 1))
    end

    def checkSingleDiagonal(base)
        map = {}
        for i in (0...@size) do
            j = (base) - i
            j *= -1 if( j < 0) 
            if(map[board[i][j]])
                map[board[i][j]] += 1
            else
                map[board[i][j]] = 1
            end
        end
        map.each do |key, value|
            return true if(value == @size && key != nil)
        end
        return false
    end

    def checkDraw()
        for i in (0...@size)
            for j in (0...@size)
                return false if(@board[i][j] == nil)
            end
        end
        return true
    end
end


arr = [
    ['x',nil,'x'],
    ['x','x',nil],
    [nil,nil,'x']
]

def checkForLowerCase(str)
    return (str == str.downcase())
end

def playNewGame()
    puts "Hey, I am the most boring Tic Tac Toc game"
    puts "I am a very basic game and a really boring one"
    puts "Do you really want to play this game ?(yes/no)"
    sel = gets.chomp
    while(sel != 'yes' || sel == "no")
        
        if(sel == 'y' || sel == 'Y' || sel == 'n' || sel == 'N')
            puts "man you are a lazy one, can you write the WORD like a man";
        elsif(!checkForLowerCase(sel))
            puts "NO ONE EVER WRITE ANY UPPERCASE CHAR OTHER THAN ME";
        else
            puts "okay what is that now I said a YES or NO and you get me that"
        end

        puts "Do you still want to play this game ?(yes/no)"
        sel = gets.chomp
    end

    if(sel == 'no')
        return
    end

    puts "Write your boring name"
    puts "but If its has any uppercase in it I will kick you out"
    name1 = gets.chomp
    if(!checkForLowerCase(name1))
        puts "okay I warned you loser"
        puts "Player 2 what ever your name you have won"
        return
    end 
    puts "Write your boring name"
    puts "but If its has any uppercase in it I will kick you out"
    name2 = gets.chomp
    if(!checkForLowerCase(name2))
        puts "okay I warned you loser"
        puts "#{name1} you have won"
        return
    end
    game = Game.new(name1, name2)
    
    num = 0
    while(!game.check())
        game.printBoard()
        print "Hey #{game.curPlayer} can you play?"
        print ", yes you just a one digit number to me" if(num < 2)
        puts
        num += 1
        print "row num "
        x = gets.chomp.to_i
        print "col num "
        y = gets.chomp.to_i
        game.play(x, y)
    end

    ch = game.check()
    if(ch == "Draw")
        puts "Okay no one gets any thing ( DrAw )"
    else
        if(game.curPlayer == 0)
            puts "#{game.player2Name} have waste his time and win a boring game"
        else
            puts "#{game.player1Name} have waste his time and win a boring game"
        end
    end
    
end

playNewGame()