class Provider
  include Tire::Model::Persistence
  index_name "#{Tire::Model::Search.index_prefix}providers"

  property :npi
  property :entity_type
  property :name, class: Name
  property :mailing_address, class: Address
  property :practice_location, class: Address
  property :authorized_official, class: AuthorizedOfficial
  property :specialties, class: [Specialty]
  property :identifiers, class: [Identifier]

  def id; npi; end

  def primary_specialty
    specialties.select { |s| s.is_primary }.first || NullSpecialty.new
  end
end

