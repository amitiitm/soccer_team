class Ranking
  POINTS = { win: 3, lose: 0, tie: 1 }.freeze

  def initialize(filename = nil)
    unless filename
      puts 'Enter File Name'
      filename = gets.chomp
    end
    raise ArgumentError, 'Filename should be present' if filename.empty?
    @filepath = "lib/input/#{filename}.txt"
    raise 'File not found' unless File.exist?(@filepath)
    @team_hash = {}
  end

  def team_score
    parse
    sort(@team_hash)
  end

  def parse
    lines = File.readlines(@filepath)
    lines.each do |line|
      team_scores = calculate_points(line)

      @team_hash.merge!(team_scores[:team1][:name] => team_scores[:team1][:score], team_scores[:team2][:name] => team_scores[:team2][:score])
    end
  end

  def calculate_points(line)
    team_scores = stats(line)

    result = team_scores[:team1][:score] - team_scores[:team2][:score]

    team_scores = if result.positive?
                    score(team_scores[:team1][:name], team_scores[:team2][:name], :win, :lose)
                  elsif result.negative?
                    score(team_scores[:team1][:name], team_scores[:team2][:name], :lose, :win)
                  elsif result.zero?
                    score(team_scores[:team1][:name], team_scores[:team2][:name], :tie, :tie)
                  end
    team_scores
  end

  def score(team1, team2, team1_result, team2_result)
    {
      team1: { name: team1, score: (@team_hash[team1] || 0) + POINTS[team1_result] },
      team2: { name: team2, score: (@team_hash[team2] || 0) + POINTS[team2_result] }
    }
  end

  def sort(hash)
    Hash[hash.sort_by { |_k, v| v }.reverse]
  end

  def stats(line)
    teams = line.split(',')

    team1 = teams[0].split(' ')
    team2 = teams[1].split(' ')

    team1_score = team1.last.to_i
    team1.pop
    team1_name = team1.join(' ')

    team2_score = team2.last.to_i
    team2.pop
    team2_name = team2.join(' ')
    {
      team1: { name: team1_name, score: team1_score },
      team2: { name: team2_name, score: team2_score }
    }
  end
end

# ranking = Ranking.new()
# puts ranking.team_score
