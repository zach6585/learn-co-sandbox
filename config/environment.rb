require 'bundler/setup'
Bundler.require
require 'rake'
require 'active_record'

require_relative '../crm'
require_relative 'sql_runner'

DB = ActiveRecord::Base.establish_connection(
      :adapter => "sqlite3",
      :database => "../db/wbwood"
    )

  DB = ActiveRecord::Base.connection

  if ENV["ACTIVE_RECORD_ENV"] == "test"
    ActiveRecord::Migration.verbose = false
  end
