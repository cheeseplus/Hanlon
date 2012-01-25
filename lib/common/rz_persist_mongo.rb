# This is the superclass for all database object types
# there are database object types for each possible database that can back Razor
# common functions are created here to handle accessors and key/values
# Child object types override when needed for specific type
# All keys are assumed to be simple string and all values are assumed to be YAML string

# This adds Razor Common lib path to the load path for this child proc
$LOAD_PATH << "#{ENV['RAZOR_HOME']}/lib/common"

require "rz_persist_object"
require "mongo"

class RZPersistMongo < RZPersistObject
  def initialize

  end

  def connect(hostname, port)
    @connection = Mongo::Connection.new(hostname, port)
    @razor_database = @connection.db("razor")
    @connection.active?
  end

  def disconnect
    @connection.close
    @connection.active?
  end

  def is_db_selected?
    if (@razor_database != nil and @connection.active?)
      true
    end
  end
end