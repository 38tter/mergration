# Mergration

Mergration gem generates migration files from markdown files written in Mermaid.js syntax.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mergration', git: 'git@github.com:38tter/mergration.git'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mergration

## Usage

Let's say you write down ER diagram on `docs/mermaid/hoge_subscription.md` in Mermaid.js syntax, something like

```mermaid
erDiagram %% write ome comment here

  hoge_subscriptions {
    bigint id PK
    integer price
    string name
    date start_on
    date end_on
    datetime disabled_at
    references account PK
    references user FK
  }
```

and then you can run mergration generator and migration file would be generated like:

```shell
$ bin/rails generate mergration:install
Running via Spring preloader in process 73574
      create  db/migrate/20230716192207_create_hoge_subscriptions.rb
$ cat db/migrate/20230716192207_create_hoge_subscriptions.rb
class CreateHogeSubscriptions < ActiveRecord::Migration[6.1]
  def change
    create_table :hoge_subscriptions do |t|
      t.bigint :id
      t.integer :price
      t.string :name
      t.date :start_on
      t.date :end_on
      t.datetime :disabled_at
      t.references :account
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mergration. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/mergration/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Mergration project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/mergration/blob/master/CODE_OF_CONDUCT.md).
