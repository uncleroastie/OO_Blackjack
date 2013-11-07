# File  :  card.rb
# Author:  RM2
#
# Assignment Week #2



#====================================================
class Card
#====================================================

    #================================================
    public
	#================================================
	
    attr_accessor :cardFace, :cardSuit, :cardValue
	
	CardNames = {
        :CA => "Ace",
        :C2 => "Two",
        :C3 => "Three",
        :C4 => "Four",
        :C5 => "Five",
        :C6 => "Six",
        :C7 => "Seven",
        :C8 => "Eight",
        :C9 => "Nine",
       :C10 => "Ten",
        :CJ => "Jack",
        :CQ => "Queen",
        :CK => "King"
	}
	
	#====================================================
    def pickOne()
    #====================================================
        cardNumberPicked = Random.rand(1..@totalCards);
        # determine what deck we are in
        r = (cardNumberPicked % CardsPerDeck) + 1 # 1..52
        # determine the suit
        q = r/13  # want q: 1..4
        if (q < 4)
            q = q + 1
        end
        @cardSuit = Suits[q]
        # determine the card       
        c = (r % CardFaces) + 1 # 1..13
        @cardFace = CardOptions[c]
        @cardValue = CardValues[@cardFace]
        if (@cardFace == :CA)
            whichAce = Random.rand(0..1)
            if (whichAce == 0)
                @cardValue = 1
            else
                @cardValue = 11
            end
        end

    end # pickOne()
	
	#================================================
    private
	#================================================
	
	#================================================
    def initialize()
    #================================================
        numberOfDecks = Random.rand(1..7)
        @totalCards = numberOfDecks * CardsPerDeck
	    
		@cardFace = nil
		@cardSuit = nil
		@cardValue = 0
		
	end # initialize()
	
	#================================================
    # Private Data
	#================================================
	
	CardsPerDeck = 52
	CardFaces = 13
	    
	CardOptions = {
        1 => :CA,
        2 => :C2,
        3 => :C3,
        4 => :C4,
        5 => :C5,
        6 => :C6,
        7 => :C7,
        8 => :C8,
        9 => :C9,
       10 => :C10,
       11 => :CJ,
       12 => :CQ,
       13 => :CK
    }
	
	Suits = {
        1 => "clubs",
        2 => "diamonds",
        3 => "hearts",
        4 =>"spades"
	}
	
	CardValues = {
        :CA => 1,
        :C2 => 2,
        :C3 => 3,
        :C4 => 4,
        :C5 => 5,
        :C6 => 6,
        :C7 => 7,
        :C8 => 8,
        :C9 => 9,
       :C10 => 10,
        :CJ => 10,
        :CQ => 10,
        :CK => 10
    }

#====================================================
end # class Card
#====================================================
