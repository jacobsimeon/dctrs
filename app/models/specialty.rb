class Specialty
  attr_accessor :code, :is_primary, :type, :classification, :specialization, :definition, :notes
  include Initializable

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
