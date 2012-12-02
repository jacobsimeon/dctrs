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
