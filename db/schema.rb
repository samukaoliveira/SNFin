# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_01_03_181106) do
  create_table "cartaos", force: :cascade do |t|
    t.string "nome"
    t.decimal "limite"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "fechamento"
    t.integer "vencimento"
  end

  create_table "competencia", force: :cascade do |t|
    t.integer "mes"
    t.integer "ano"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "faturas", force: :cascade do |t|
    t.integer "cartao_id", null: false
    t.integer "mes"
    t.integer "ano"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["cartao_id"], name: "index_faturas_on_cartao_id"
  end

  create_table "lancamentos", force: :cascade do |t|
    t.date "data"
    t.integer "natureza"
    t.decimal "valor", precision: 15, scale: 2
    t.integer "frequencia"
    t.integer "quantidade"
    t.integer "fatura_id"
    t.integer "competencia_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "descricao"
    t.index ["competencia_id"], name: "index_lancamentos_on_competencia_id"
    t.index ["fatura_id"], name: "index_lancamentos_on_fatura_id"
  end

  add_foreign_key "faturas", "cartaos"
  add_foreign_key "lancamentos", "competencia", column: "competencia_id"
  add_foreign_key "lancamentos", "faturas"
end
