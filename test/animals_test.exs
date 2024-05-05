defmodule AnimalsTest do
  use ExUnit.Case

  test "creates a zoo with a predefined list of animals" do
    zoo = ["lion", "tiger", "gorilla", "elephant", "monkey", "giraffe"]
    assert zoo == Animals.create_zoo()
  end

  test "randomizes the order of animals in the zoo" do
    zoo = Animals.create_zoo()
    assert zoo != Animals.randomise(zoo)
  end

  test "checks if a specific animal is present in the zoo" do
    zoo = Animals.create_zoo()
    animal = "monkey"
    assert Animals.contains?(zoo, animal)
  end

  test "verifies that an animal not in the zoo returns false" do
    zoo = Animals.create_zoo()
    animal = "animal out of the list"
    assert Animals.contains?(zoo, animal) == false
  end

  test "ensures the ability to view a specific quantity of animals in the zoo" do
    zoo = Animals.create_zoo()
    count = 4
    assert length(Animals.see_animals(zoo, count)) == count
  end

  test "saves the list of animals in a file" do
    zoo = Animals.create_zoo()
    filename = "zoo_list"
    assert Animals.save(zoo, filename) == :ok
  end

  test "reads the list of animals from a file" do
    filename = "zoo_list"
    assert Animals.load(filename) == Animals.create_zoo()
  end

  test "throws an error when attempting to load a non-existent file of animal list" do
    filename = "not_found_zoo_list"
    assert Animals.load(filename) == "File does not exist"
  end

  test "selects a specific number of animals from the zoo and randomizes the list" do
    zoo = Animals.create_zoo()
    number_animals = 4
    selected_animals = Animals.selection(number_animals)
    assert length(selected_animals) == number_animals
    assert selected_animals != Animals.see_animals(zoo, number_animals)
  end
end
