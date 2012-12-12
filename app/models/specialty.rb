class Specialty
  include Initializable
  attr_accessor :code, :is_primary, :type, :classification, :specialization, :definition, :notes

  def license=(license)
    if license.respond_to? :[]
      @license = License.new(license)
    else
      @license = license
    end
  end

  def license
    @license
  end

end

class NullSpecialty
  attr_accessor :code, :is_primary, :type, :classification, :specialization, :definition, :notes
  def initialize
    @license = NullLicense.new
    @code = "No Specialty"
    @is_primary = false
    @type = ""
    @classification = ""
    @specialization = "This provider does not have a primary specialty."
    @definition = ""
    @notes = ""
  end
end
