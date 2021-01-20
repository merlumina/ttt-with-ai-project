class Game
    attr_accessor :board, :player_1, :player_2

    WIN_COMBINATIONS = [
        [0, 1, 2], # Top Row
        [3, 4, 5], # Middle Row
        [6, 7, 8], # Bottom Row
        [0, 3, 6], # Left Column
        [1, 4, 7], # Middle Column
        [2, 5, 8], # Right Column
        [0, 4, 8], # TL - BR Diagonal
        [6, 4, 2]  # BL - TR Diagonal
    ]

    def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
        @player_1 = player_1
        @player_2 = player_2
        @board = board
    end

    def current_player
        board.turn_count % 2 == 0 ? player_1 : player_2
    end

    def turn
        puts "Please enter a number (1-9):"
        current_move = current_player.move(board)
        if !board.valid_move?(current_move)
            turn
        else
            board.update(current_move, current_player)
        end
        board.display
    end

    def play
        while !over?
            turn
        end
        if won?
            puts "Congratulations #{winner}!"
        elsif draw?
            puts "Cat's Game!"
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
            board.cells[combo[0]] == board.cells[combo[1]] &&
            board.cells[combo[1]] == board.cells[combo[2]] &&
            board.taken?(combo[0] + 1)
        end
    end

    def draw?
        board.full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        if winning_combo = won?
            @winner = board.cells[winning_combo.first]
        end
    end

end