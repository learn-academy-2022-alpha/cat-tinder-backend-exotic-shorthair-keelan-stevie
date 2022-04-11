require 'rails_helper'

RSpec.describe Cat, type: :model do
  describe 'Create cat' do
  # user needs to submit a cat name
  it 'will not allow cat name to be empty' do
    cat = Cat.create age: 10, enjoys: 'something and everything', image: 'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=49ed3252c0b2ffb49cf8b508892e452d'
    p cat.errors[:name]
    expect(cat.errors[:name]).to_not be_empty
  end
  
  # user needs to submit a cat age 
  it 'will not allow cat age to be empty' do
    cat = Cat.create name: 'LEARN', enjoys: 'something and everything', image: 'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=49ed3252c0b2ffb49cf8b508892e452d'
    p cat.errors[:age]
    expect(cat.errors[:age]).to_not be_empty
  end

  # user must submit an 'enjoys' section
  it 'will not allow cat enjoys to be empty' do
    cat = Cat.create name: 'LEARN', age: 10, image: 'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=49ed3252c0b2ffb49cf8b508892e452d'
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end

  # user needs to not be boring; must be at least 10 chars long
  it 'will not allow cat enjoys to be less than 10 characters long' do
    cat = Cat.create name: 'LEARN', age: 10, enjoys: 'stuff', image: 'https://i.guim.co.uk/img/media/26392d05302e02f7bf4eb143bb84c8097d09144b/446_167_3683_2210/master/3683.jpg?width=1200&height=1200&quality=85&auto=format&fit=crop&s=49ed3252c0b2ffb49cf8b508892e452d'
    p cat.errors[:enjoys]
    expect(cat.errors[:enjoys]).to_not be_empty
  end

  # user must submit an image
  it 'will not allow cat image to be empty' do
    cat = Cat.create name: 'LEARN', age: 10, enjoys: 'something and everything'
    p cat.errors[:image]
    expect(cat.errors[:image]).to_not be_empty
  end

  end
end
