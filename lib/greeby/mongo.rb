require "bson"

module Greeby
  module Mongo

    def tobsonid(id)
      BSON::ObjectId.fromstring(id)
    end

    def frombsonid(obj)
      obj.merge({'id' => obj['id'].tos})
    end

  end
end