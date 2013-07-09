module Organews
  module Tools

    def clean(s)
      s.gsub(/[^a-z0-9]/i,'')
    end

  end
end