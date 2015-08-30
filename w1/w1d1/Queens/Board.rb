class Board
  attr_accessor :grid
  attr_reader   :size

  def initialize(board_size = 8)
    @grid = Board.build_grid(board_size)
    @size = board_size
  end

  def conflict?
    rows.each do |row|
      return true if row.count(nil) <= row.length - 2
    end

    columns.each do |column|
      return true if column.count(nil) <= column.length - 2
    end

    diagonals.each do |diagonal|
      return true if diagonal.count(nil) <= diagonal.length - 2
    end

    return false
  end

  def rows
    grid
  end

  def columns
    grid.transpose
  end

  def find_diagonals(array)
    diagonals_array = []

    # Do the lower-left portion of the array
    (size - 1).downto(0) do |row_idx|
      diagonal = []

      d_idx = 1
      until diagonal.length == (size - row_idx)
        diagonal << array[size - d_idx][size - row_idx - d_idx]
        d_idx += 1
      end
      diagonals_array << diagonal
    end

    # Do the upper-right portion of the array
    0.upto(size-1) do |row_idx|
      diagonal = []

      d_idx = 0
      until diagonal.length == (size - row_idx)
        diagonal << array[d_idx][row_idx + d_idx]
        d_idx += 1
      end

      unless diagonals_array.include?(diagonal) || 
             diagonals_array.include?(diagonal.reverse)
        diagonals_array << diagonal.reverse
      end
    end
   
    diagonals_array
  end

  def diagonals
    reverse_grid = grid.map do |array|
      array.reverse
    end
    (find_diagonals(grid) + find_diagonals(reverse_grid)).uniq
    # diagonals_array = []

    # # Do the lower-left portion of the array
    # (size - 1).downto(0) do |row_idx|
    #   diagonal = []

    #   d_idx = 1
    #   until diagonal.length == (size - row_idx)
    #     diagonal << grid[size - d_idx][size - row_idx - d_idx]
    #     d_idx += 1
    #   end
    #   diagonals_array << diagonal
    # end

    # # Do the upper-right portion of the array
    # 0.upto(size-1) do |row_idx|
    #   diagonal = []

    #   d_idx = 0
    #   until diagonal.length == (size - row_idx)
    #     diagonal << grid[d_idx][row_idx + d_idx]
    #     d_idx += 1
    #   end

    #   unless diagonals_array.include?(diagonal) || 
    #          diagonals_array.include?(diagonal.reverse)
    #     diagonals_array << diagonal
    #   end
    # end
   
    # diagonals_array
  end

  def [](row, col)
    grid[row][col]
  end

  def []=(row, col, val)
    self.grid[row][col] = val
  end

  def self.build_grid(board_size)
    Array.new(board_size) { Array.new(board_size) }
    # [
    #   [0,1,2],
    #   [3,4,5],
    #   [6,7,8]
    # ]

    # [
    #   [ 0, 1, 2, 3],
    #   [ 4, 5, 6, 7],
    #   [ 8, 9,10,11],
    #   [12,13,14,15]
    # ]

    # [
    #   [ 0, 1, 2, 3, 4],
    #   [ 5, 6, 7, 8, 9],
    #   [10,11,12,13,14],
    #   [15,16,17,18,19],
    #   [20,21,22,23,24]
    # ]
  end

  def render
    print "  "
    (0...size).each do |idx|
      print "#{idx} "
    end
    print "\n"

    (0...size).each do |row|
      print "#{row} "
      (0...size).each do |col|
        if grid[row][col].nil?
          print "- "
        else
          print "#{grid[row][col].to_s} "
        end
      end
      print "\n"
    end
    nil
  end
end

if __FILE__ == $PROGRAM_NAME
  b = Board.new(5)
  b.diagonals.each do |arr|
    puts "#{arr}"
  end
end