module Facts
  def self.random_pet_fact
    check_pet_fact = PetFact.first.fact rescue nil

    unless check_pet_fact
      return @fact = 'In Alaska it is illegal to whisper in someone’s ear while they’re moose hunting.'
    end

    @fact = PetFact.skip(rand(PetFact.count)).first.fact
  end

  def self.random_turnbull_fact
    check_turnbull_fact = Turbull.first.fact rescue nil

    unless check_turnbull_fact
      return @fact = "Anyone who thinks it's smart to cut immigration is sentencing Australia to poverty."
    end

    @fact = Turbull.skip(rand(Turnbull.count)).first.fact
  end
end