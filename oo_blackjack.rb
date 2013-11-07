# File  :  oo_blackjack.rb
# Author:  RM2
#
# Assignment Week #2


require './game'


#====================================================
module Match
#====================================================

#================================================
public
#================================================
	
    @dealerName = "Dealer"
    @playerName = ""
    @gamesPlayed = {
        :count => 0,
        :wins => {
            :player => 0,
            :dealer => 0
        },
        :ties => 0
    }

	
	  #================================================
    def Match.main()
    #================================================
        initialize()
        play()
        showFinalResults()

    end # main()

    #================================================
    def Match.dealerName()
    #================================================
        @dealerName
    end

    #================================================
    def Match.gamesPlayed()
    #================================================
        @gamesPlayed
    end

    #================================================
    def Match.playerName()
    #================================================
        @playerName
    end
	
#================================================
private
#================================================
	
	  #================================================
    def Match.decideToContinuePlay()
    #================================================
        notDone = true
        invalidEntry = true
        while (invalidEntry == true) do
            puts "Do you wish to play another game (Y/N)?"
            answer = gets
            answer = answer.chomp()
            if ((answer == "Y") or
                (answer == "y"))
                invalidEntry = false
            elsif ((answer == "N") or
                   (answer == "n"))
                invalidEntry = false
                notDone = false
            end
        end
        return notDone

    end # decideToContinuePlay()
	
	  #================================================
    def Match.initialize()
    #================================================
	      notDone = true
        while (notDone == true) do
            puts "Enter player's name:  "
            @playerName = gets
            @playerName = @playerName.chomp()
            if (@playerName.empty? == true)
                puts "You failed to enter a name; try again."
            else
                notDone = false
            end # else, if
		end # while

    end # initialize()
	
	  #================================================
    def Match.play()
    #================================================
        notDone = true
        gameCount = 0
        while (notDone == true) do
            gameCount += 1
			      @gamesPlayed[:count] = gameCount
			      game = Game.new(gameCount)
            game.play();
            notDone = decideToContinuePlay()
        end

    end # play()
	
    #================================================
    #   Final Results:
    #
    #   Floyd wins the match
    #
    #   Floyd games won :
    #	Dealer games won:
    #	Ties            :
    #================================================
    def Match.showFinalResults()
    #================================================
        puts "Final Results:"
        puts "\n"
        winHash = @gamesPlayed[:wins]
        playerPoints = winHash[:player]
        dealerPoints = winHash[:dealer]
        if (playerPoints == dealerPoints)
            puts "The match ended in a tie"
        elsif (playerPoints < dealerPoints)
            puts @playerName + " wins the match"
        else
            puts "Dealer wins the match"
        end # else, if
        puts "\n"
        puts @playerName + " games won: " + playerPoints.to_s
        puts "Dealer games won: " + dealerPoints.to_s
        puts "Ties: " + @gamesPlayed[:ties].to_s

    end # showFinalResults()

#====================================================	
end # module Match
#====================================================

if (__FILE__ == $0)

    Match.main()

  end # if
