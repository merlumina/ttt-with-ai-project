require "pry"

class Board
    attr_accessor :cells

    def initialize
        @cells = Array.new(9, " ")
    end

    def reset!
        self.cells = Array.new(9, " ") #possible refactor to put this in its own function
    end

    def display
        puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
        puts "------------"
        puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
        puts "------------"
        puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
    end

    def position(input)
        cells[input.to_i - 1]
    end

    def full?
        cells.all? {|cell| cell == "X" || cell == "O"}
    end

    def turn_count
        cells.count {|cell| cell == "X" || cell == "O"}
    end

    def taken?(input)
        position(input) == "X" || position(input) == "O"
    end

    def valid_move?(input)
        input.to_i.between?(1,9) && !taken?(input)
    end

    def update(input, player)
        if valid_move?(input)
            cells[input.to_i - 1] = player.token
        end
    end

end