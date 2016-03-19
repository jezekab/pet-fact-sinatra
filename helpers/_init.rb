module Facts
  def self.random_pet_fact
    check_pet_fact = PetFact.first.fact rescue nil

    unless check_pet_fact
      return @fact = 'In Alaska it is illegal to whisper in someone’s ear while they’re moose hunting.'
    end

    @fact = PetFact.skip(rand(PetFact.count)).first.fact
  end
end