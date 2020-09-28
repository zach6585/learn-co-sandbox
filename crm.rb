require 'sqlite3'


database_connection = SQLite3::Database.new('db/wbwood.db')

database_connection.execute("CREATE TABLE IF NOT EXISTS CRM (id INTEGER PRIMARY KEY, company_id INTEGER, contact_id INTEGER, notes TEXT);")



database_connection.execute("CREATE TABLE IF NOT EXISTS companies (id INTEGER PRIMARY KEY, company_name TEXT, contact_name TEXT)")

database_connection.execute("CREATE TABLE IF NOT EXISTS wb_wood (id INTEGER PRIMARY KEY, contact_name TEXT)")

database_connection.execute("INSERT INTO CRM(company_id, contact_id, notes) VALUES (#{1},#{1},'Hello, world!')")