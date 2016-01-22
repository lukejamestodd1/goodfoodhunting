require './db_config'
require './models/dish'
require './models/dish_type'
require './models/user'
require './models/like'

# DishType.delete_all
# Dish.delete_all
#for testing if need to clear database

img = "http://blogs.plos.org/obesitypanacea/files/2014/10/sandwich.jpg"

DishType.create(name: 'snack')
DishType.create(name: 'dessert')
DishType.create(name: 'lunch')

brunch = DishType.create(name: 'brunch')

Dish.create(name: 'carrotcakepudding', dish_type_id: brunch.id)

DishType.all.map{ |dish_type| dish_type.id}
DishType.pluck(:id)		#show all ids

10.times do |count|
	Dish.create(name: "dish-#{count}", image_url: img)
end