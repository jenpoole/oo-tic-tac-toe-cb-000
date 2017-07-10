class TicTacToe

  # set the starting state of the board with 9 empty strings
  def initialize
    @board = Array.new(9, " ")
  end

  # list all possible winning combinations
  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [2,4,6]
  ]

  # display the current board using @board instance variable
  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  # pass user input and have it return the corresponding index of the @board array
  def input_to_index(user_input)
    user_input.to_i - 1
  end

  # move player token to index in @board array
  def move(position, player="X")
    @board[position] = player
  end

  # evaluate the user's desired move against the Tic Tac Toe board and check to see whether or not that position is already occupied
  def position_taken?(position)
    if @board[position] == " " || @board[position] == "" || @board[position] == nil
     false
   else
     true
   end
  end

  #  accept a position to check and return true if the move is valid, or false / nil if not
  # A valid move is: A position that is present on the game board & not already filled with a token.
  def valid_move?(position)
    if !position_taken?(position) && position.between?(0,8)
      true
    else
      false
    end
  end

  # 1. Ask the user for their move by specifying a position between 1-9.
  # 2. Receive the user's input.
  # 3. Translate that input into an index value.
  # 4. If the move is valid, make the move and display the board.
  # 5. If the move is invalid, ask for a new move until a valid move is received.
  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    position = input_to_index(input)

    if valid_move?(position)
      player = current_player
      move(position, player)
      display_board
    else
      turn
    end
  end

  # return the number of turns that have been played based on the @board variable
  def turn_count
    @board.count{|plays_made| plays_made != " "}
  end

  # use turn_count method to determine if it is X's or O's turn.
  def current_player
     turn_count.even? ? "X" : "O"
  end

  # return false/nil if there is no win combination present in the board and return the winning combination indexes as an array if there is a win.
  def won?
    WIN_COMBINATIONS.find do |win_combo|
      if position_taken?(win_combo[0]) && @board[ win_combo[0] ] == @board[ win_combo[1] ] && @board[ win_combo[1] ] == @board[ win_combo[2] ]
        return win_combo
      else
        false
      end
    end
  end

  # return true if every element in the board contains either an "X" or an "O".
  def full?
    @board.all? do |position|
      position != " "
    end
  end

  # return true if the board is full and has not been won, false if the board is won, and false if the board is neither won nor full.
  def draw?
    !won? && full?
  end

  # return true if the board has been won or is full (i.e., is a draw)
  def over?
    won? || draw? || full?
  end

  # return the token, "X" or "O", that has won the game.
  def winner
    if won?
      @board[won?[0]]
    end
  end

  # The play method is responsible for the game loop.
  # A Tic Tac Toe game must allow players to take turns, checking if the game is over after every turn.
  # At the conclusion of the game, whether because it was won or ended in a draw, the game should report to the user the outcome of the game.
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

end
