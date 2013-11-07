# File  :  game.rb
# Author:  RM2
#
# Assignment Week #2


require './card'


#====================================================
class Game
#====================================================

	#================================================
	public
	#================================================
	
	#================================================
    def play()
    #================================================
        continueToPlay = start()
        if (continueToPlay == false)
            showResults()
        else
            finish()
        end

    end # play()

	#================================================
	private
	#================================================
	
	PersonData = Struct.new(:allCards, :points, :win, :loss, :tie, :which)
	
	#================================================
    def initialize(count)
	#================================================
	    @count = count
		@player = PersonData.new(Array.new, 0, false, false, false, :player)
		@dealer = PersonData.new(Array.new, 0, false, false, false, :dealer)
		@winner = nil
		
	end # initialize()
	
	#================================================
    # The dealer must initially draw cards until he 
    # has at least 17 points (forget the "she" political correctness).
    #================================================
    def dealerMustMeetPointMinimum()
    #================================================
        notDone = true
        continueToPlay = true
        while (notDone == true) do
            if (@dealer.points  < 17)
                handleOneCard(@dealer)
                continueToPlay = mayGameContinue(@dealer)
            else
                notDone = false
            end # else, if
        end # while
        return continueToPlay

    end # dealerMustMeetPointMinimum()
	
	#================================================
    def determineResults()
    #================================================
        winHash = Match.gamesPlayed[:wins]
        if (@dealer.points == @player.points)
            @winner = nil  # tie
            Match.gamesPlayed[:ties] += 1
        elsif (@dealer.points < @player.points)
            @winner = :player
            @player.win = true
            @dealer.loss = true
            winHash[:player] += 1
        else
            @winner = :dealer
            @dealer.win = true
            @player.loss = true
            winHash[:dealer] += 1
        end # else, if
        Match.gamesPlayed[:wins] = winHash

    end # determineResults()
	
	#================================================
    def finish()
    #================================================
        continueToPlay = proceed(@player)
        if (continueToPlay == false)
            showResults()
        else
            continueToPlay = proceed(@dealer)
        end # else, if
        if (continueToPlay == false)
            showResults()
        else
            determineResults()
            showResults()
        end # else, if

    end # finishGame()
	
	#================================================
    def handleOneCard(person)
    #================================================
        oneCard = Card.new()
		oneCard.pickOne()
        person.allCards.push(oneCard)
        person.points += oneCard.cardValue

    end # handleOneCard()
	
    #================================================
    def mayGameContinue(person)
    #================================================
        result = true
        if (person.points > 21)
            if (person.which == :player)
                @player.loss = true
                @dealer.win = true
                @winner = :dealer
            else
                @dealer.loss = true
                @player.win = true
                @winner = :player
            end # else, if
            result = false
        elsif (person.points == 21)
            if (person.which == :player)
                @dealer.loss = true
                @player.win = true
                @winner = :player
            else
                @player.loss = true
                @dealer.win = true
                @winner = :dealer
            end # else, if
            winHash = Match.gamesPlayed[:wins]
            if (person.which == :player)
                winHash[:player] += 1
            else
                winHash[:dealer] += 1
            end # else, if
            Match.gamesPlayed[:wins] = winHash
            result = false
        end # else, if
        return result

    end # mayGameContinue()
	
	#================================================
    def proceed(person)
    #================================================
        invalidEntry = true
        continueToPlay = true
        while (invalidEntry == true) do
	          name = ""
		        if (person.which == :player)
		            name = Match.playerName
		        else
		            name = Match.dealerName
            end # else, if
            puts  name + ", you have " + person.points.to_s + " points."
            notDone = true
            while (notDone == true) do
                puts "Do you want another card (Y/N)?"
                answer = gets
                answer = answer.chomp()
                if ((answer == "Y") or
                    (answer == "y"))
                    invalidEntry = false
                    handleOneCard(@player)
                    continueToPlay = mayGameContinue(person)
                    notDone = false
                elsif ((answer == "N") or
                       (answer == "n"))
                    invalidEntry = false
                    notDone = false
                end # else, if
            end # while
        end
        return continueToPlay

    end #proceed()

    #================================================
    #  Game #  57
    #      Floyd wins
    #	   Floyd:  
    #	       Points:
    #		   Cards:
    #	   Dealer:  
    #	       Points:
    #	       Cards:
    #================================================
    def showResults()
    #================================================
        puts "Game # " + @count.to_s
        if (@winner == :player)
            puts Match.playerName + " wins"
        else
            puts "Dealer wins"
        end # else, if
        #
        puts Match.playerName + ":"
        puts "\tPoints: " + @player.points.to_s
        puts "\tCards: "
        playerCards = @player.allCards
        count = 0
        while (count < playerCards.length) do
            oneCard = playerCards[count]
            puts "\t\t" + Card::CardNames[oneCard.cardFace] + " of " + oneCard.cardSuit
            count = count + 1
        end # while
        #
        puts "Dealer:"
        puts "\tPoints: " + @dealer.points.to_s
        if (@dealer.points == 0)
            puts "\tCards: none"
        else
            puts "\tCards: "
            dealerCards = @dealer.allCards
            count = 0
            while (count < dealerCards.length) do
                oneCard = dealerCards[count]
                puts "\t\t" + Card::CardNames[oneCard.cardFace] + " of " + oneCard.cardSuit
                count += 1
            end # while
        end #else, if

    end # showResults()

    #================================================
    def start()
    #================================================
        handleOneCard(@player)
        handleOneCard(@player)
        continueToPlay =  mayGameContinue(@player)
        if (continueToPlay == false)
            showResults()
        else
            handleOneCard(@dealer)
            handleOneCard(@dealer)
            continueToPlay =  mayGameContinue(@dealer)
            if (continueToPlay == true)
                continueToPlay = dealerMustMeetPointMinimum()
            end # if
        end # else, if
        return continueToPlay

    end # start()
	
#================================================
end # class Game
#================================================
