# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
users = User.create([{name: 'Víctor Salvatierra Mora', email: 'victor.salvatierra@monkeylabs.cr', password: '1234asdf', password_confirmation: '1234asdf'}])
roles = Role.create([{id: 0, name: 'Administrador'}, {id: 1, name: 'Conserje'}, {id: 2, name: 'Mantenimiento'}, {id: 3, name: 'Oficial 1'},
{id: 4, name: 'Oficial 2'}, {id: 5, name: 'Oficial 3'}, {id: 6, name: 'Supervisor 1'}, {id: 7, name: 'Supervisor 2'}])