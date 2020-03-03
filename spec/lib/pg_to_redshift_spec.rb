# frozen_string_literal: true

require "spec_helper"

RSpec.describe PgToRedshift do
  it "opens a read only connection to source database" do
    read_only_state = PgToRedshift.source_connection.exec("SHOW transaction_read_only").first["transaction_read_only"]

    expect(read_only_state).to eq("on")
  end

  context "with a simple table" do
    before do
      PgToRedshift::Test.test_connection.exec(%[DROP TABLE IF EXISTS "films"; CREATE TABLE IF NOT EXISTS "films" ("id" SERIAL PRIMARY KEY, "title" text);])
    end

    it "lists available tables" do
      expect(PgToRedshift.new.tables.size).to eq(1)
      expect(PgToRedshift.new.tables.first.name).to eq("films")
    end

    it "lists column definitions" do
      table = PgToRedshift.new.tables.first
      film_columns = PgToRedshift.new.column_definitions(table)

      expect(film_columns.to_a.size).to eq(2)
      expect(film_columns.first["column_name"]).to eq("id")
      expect(table.columns.first.name).to eq("id")
    end
  end
end
