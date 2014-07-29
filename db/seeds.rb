# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: "Will Lowry", email: "william.c.lowry@gmail.com"}, 
			 							 {name: "Cassidy Pignatello", email: "cassidy@gmail.com"},
			 							 {name: "Denine Guy", email: "denine@gmail.com"},
			 							 {name: "Kris Kroes", email: "kris@gmail.com"},
			 							 {name: "Edward Warren", email: "ed@gmail.com"}])

users[0].friends.build(name: "Phil McGuire", birthday: DateTime.new(1991,7,3))
users[0].friends.build(name: "Ben Folds", birthday: DateTime.new(1983,10,12))
users[0].friends.build(name: "Ethan Allen", birthday: DateTime.new(1978,3,23))
users[0].friends.build(name: "Donkey Kong", birthday: DateTime.new(1987,10,3))

users[1].friends.build(name: "Allen Jackson", birthday: DateTime.new(1991,7,3))
users[1].friends.build(name: "Sam Bean", birthday: DateTime.new(1988,2,11))
users[1].friends.build(name: "Lily Kraus", birthday: DateTime.new(2002,5,29))
users[1].friends.build(name: "Angelica Kong", birthday: DateTime.new(1978,3,23))

users[2].friends.build(name: "Stevie McGuire", birthday: DateTime.new(1981,4,2))
users[2].friends.build(name: "Stevie Wonder", birthday: DateTime.new(1993,11,30))
users[2].friends.build(name: "Wonder Steven", birthday: DateTime.new(1997,1,15))
users[2].friends.build(name: "Michael Michaels", birthday: DateTime.new(1978,3,23))

users[3].friends.build(name: "Philip Bailey", birthday: DateTime.new(1996,2,29))
users[3].friends.build(name: "Quincy Jackson", birthday: DateTime.new(1968,4,10))
users[3].friends.build(name: "Darth Vader", birthday: DateTime.new(1988,2,11))
users[3].friends.build(name: "Java Script", birthday: DateTime.new(1973,1,27))

users[4].friends.build(name: "Avi Floswatch", birthday: DateTime.new(1980,7,23))
users[4].friends.build(name: "Floss Yourteeth", birthday: DateTime.new(1959,3,14))
users[4].friends.build(name: "Sometimes Just", birthday: DateTime.new(1982,6,22))
users[4].friends.build(name: "Dont CutIt", birthday: DateTime.new(1974,8,29))

users[0].save
users[1].save
users[2].save
users[3].save
users[4].save