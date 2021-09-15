# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create(name: "Fabi", password: "zukunft", password_confirmation: "zukunft", admin: true, active: true)
FinanceValue.create(name: "Fabi", sum: 0, rate: 0, food: 0, invest: 0, cleaning: 0, user_id: 1, cleaned: false)