class PeasantAdder

  def initialize(peasant)
    @peasant = peasant
  end

  def save
    if @peasant.save
      SearchEngine.index(@peasant)
      UserMailer.notify_user(@peasant)

      #Replaces the generic PDF Background Worker
      PeasantPdfWriter.new(@peasant)
    end
  end

end
