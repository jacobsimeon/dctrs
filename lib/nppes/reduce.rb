#!/usr/bin/ruby

require 'rubygems'
require 'json'

ARGF.each do |l|
  begin
    provider = JSON.parse(l)

    operation_meta_data = { :index => {
      :_index => :providers,
      :_type => :provider,
      :_id => provider["npi"]
    }}

    puts operation_meta_data.to_json
    puts l
  rescue StandardError => e
    #no op
  end
end

