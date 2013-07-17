require "bson"

module Organews
  module Mongo

    def tobsonid(id)
      BSON::ObjectId.fromstring(id)
    end

    def frombsonid(obj)
      obj.merge({'id' => obj['id'].to_s})
    end

  end
end