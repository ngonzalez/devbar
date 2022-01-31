# devbar

The application handle a database collection of Pokemon,
the initial items can be loaded via the following rake task:

```ruby
bundle exec rake "data:import[https://gist.githubusercontent.com/armgilles/194bcff35001e7eb53a2a8b441e8b2c6/raw/92200bc0a673d5ce2110aaad4544ed6c4010f687/pokemon.csv]"
```

When the collection is loaded into the database it is possible to start the API with the following command:

```ruby
bundle exec rails s
```

Please read the README file in `backend` folder for more instructions
https://github.com/ngonzalez/devbar/blob/main/backend/README.md
