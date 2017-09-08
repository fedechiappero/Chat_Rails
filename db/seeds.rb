# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

#rails db:seed

User.create(email: 'fede@yourdomain.com', encrypted_password: 'aq3Hs25aKaFQkr3NOmZ6j7lE4A8CY7JkGvENO9zh8eW9l1Ju', role: 'USER', active: true)
User.create(email: 'fede2@yourdomain.com', encrypted_password: 'cNA4MOaPELEg2AFkQRTt9v1T95hIiP4XQjzbK', role: 'USER', active: true)
User.create(email: 'fede3@yourdomain.com', encrypted_password: 'rP065e0yJaiW9Z6AAi0zChZKd7gBJZ.qsO5dS', role: 'USER', active: true)
User.create(email: 'fede4@yourdomain.com', encrypted_password: '$11$K.SbEGmpZsUa3pySIbfKaOhrniS.nlY7sM2RL05mGGKk8Ad.HUxJW', role: 'USER', active: true)