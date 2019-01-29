# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
users = User.create([
   {name: 'Víctor Salvatierra Mora', email: 'victor.salvatierra@monkeylabs.cr', password: '1234asdf', password_confirmation: '1234asdf', role: 0},
   {name: 'Víctor Salvatierra Mora', email: 'victor.salvatierra@outlook.com',   password: '1234asdf', password_confirmation: '1234asdf', role: 1},
   {name: 'Víctor Salvatierra Mora', email: 'vic3x94@gmail.com',                password: '1234asdf', password_confirmation: '1234asdf', role: 2}])