require 'rails_helper'

RSpec.describe "Cats", type: :request do
  describe "GET /index" do
    it "gets a list of cats" do
      Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )

      get '/cats'

      cat = JSON.parse(response.body)
      expect(response).to have_http_status(200)
      expect(cat.length).to eq 1
    end
  end

  describe "POST /create" do
    it "creates a cat" do
      cat_params = {
        cat: {
          name: 'Jr.',
          age: 4,
          enjoys: 'Sliding and making noise while I am trying to study',
          image: 'https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C3354%2C2464&q=45&auto=format&w=926&fit=clip'
        }
      }
      
      post '/cats', params: cat_params
      
      expect(response).to have_http_status(200)
      cat = Cat.first
      expect(cat.name).to eq 'Jr.'
      expect(cat.age).to eq 4
      expect(cat.enjoys).to eq 'Sliding and making noise while I am trying to study'
      expect(cat.image).to eq 'https://images.theconversation.com/files/443350/original/file-20220131-15-1ndq1m6.jpg?ixlib=rb-1.1.0&rect=0%2C0%2C3354%2C2464&q=45&auto=format&w=926&fit=clip'
    end
  end

  describe "PATCH /update" do
    it "updates a cat" do
      Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      
      cat_felix = Cat.first
      
      cat_params = {
        cat: {
          name: 'Jeraldo',
          age: 6,
          enjoys: 'Showing up in odd places randomly',
          image: 'https://helios-i.mashable.com/imagery/articles/009YzbEnPjDaHspw2iRWT5p/images-1.fit_lim.size_2000x.v1611696799.png'
        }
      }

      patch "/cats/#{cat_felix.id}", params: cat_params

      cat_jeraldo = Cat.find(cat_felix.id)
      expect(response).to have_http_status(200)
      expect(cat_jeraldo.name).to eq 'Jeraldo'
    end
  end

  describe "DELETE /destroy" do
    it "deletes a cat from the database" do
      Cat.create(
        name: 'Felix',
        age: 2,
        enjoys: 'Walks in the park',
        image: 'https://images.unsplash.com/photo-1529778873920-4da4926a72c2?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1036&q=80'
      )
      
      cat_felix = Cat.first

      delete "/cats/#{cat_felix.id}"
      expect(response).to have_http_status(200)
      cat = Cat.all
      expect(cat).to be_empty
    end
  end

end
