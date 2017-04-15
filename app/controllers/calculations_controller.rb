class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.strip.length

    @character_count_without_spaces = @text.gsub("\n","").gsub("\r","").gsub("\t","").gsub(" ","").length

    @word_count = @text.split.count

    # @occurrences = @text.scan(@special_word).count
    @occurrences = @text.downcase.strip.gsub(".","").split.count @special_word.downcase

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    # c = (@apr/100/12)
    # n = (@years*12)
    # l = @principal
    @monthly_payment = @principal*((@apr/100/12)*(1+(@apr/100/12))**(@years*12))/(((1+(@apr/100/12))**(@years*12))-1)
    # @l*(@c*(@c+@c)**@n)/(((1+@c)**@n)-1)

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/60
    @hours = (@ending-@starting)/3600
    @days = (@ending-@starting)/3600/24
    @weeks = (@ending-@starting)/3600/24/7
    @years = (@ending-@starting)/3600/24/7/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @range = @numbers.max - @numbers.min



    @median = (@numbers.sort[(@numbers.length - 1) / 2] + @numbers.sort[@numbers.length / 2]) / 2.0


    # @median = @numbers.median

    @sum = @numbers.sum

    @mean = @numbers.inject{ |sum, el| sum + el }.to_f / @numbers.size

    @variance = @numbers.inject(0) { |variance, x| variance += (x - @mean) ** 2 }/(@numbers.size)



    @standard_deviation = @variance**0.5
    freq = @numbers.inject(Hash.new(0)) { |h,v| h[v] += 1; h }
    @mode = @numbers.max_by { |v| freq[v] }
    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
