require "bson"

module Organews
  module Mongo

    def tobsonid(id)
      BSON::ObjectId(id)
    end

    def frombsonid(obj)
      obj.merge({'id' => obj['_id'].to_s})
    end

  end
end