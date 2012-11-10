module Nppes
  class RawTaxonomy
    def initialize(raw)
      @raw = raw
    end

    def to_hash
      {
        code: @raw[:code],
        type: @raw[:type],
        classification: @raw[:classification],
        specialization: @raw[:specialization],
        definition: @raw[:definition],
        notes: @raw[:notes]
      }
    end
  end
end
