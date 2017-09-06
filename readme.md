= dataLink -- Object-relational mapping

Inspired by ActiveRecord, dataLink is a Ruby Object Relational Mapping tool
that converts tables in a SQLite3 database into instances of SQLObject class.
The library provides a base class `SQLObject` that establishes mapping between
related *model* classes by defining *associations* within each model.


How To Use dataLink
-------------------

### All of your favorite methods are present, including:
* `#save`
* `#insert`
* `#update`
* `#find`
* `#all`
* `#finalize!`

### Also builds Rails table associations:
* `::belongs_to`
* `::has_many`
* `::has_one_through`

Demo App
--------

You may find referencing the dataLink sample file `./lib/teams.rb` on the dataLink Github helpful as you
explore this document.

Once dataLink is downloaded locally:
    1) Open a terminal window and navigate to the folder
    2) type `pry` in the terminal to enter pry
    3) In pry, `load ./lib/teams.rb` to load the sample file.
    4) Explore the associated teams / conferences / divisions of the sample data set of college football teams.


Features
--------

* Automated mapping between classes and tables
    class Team < SQLObject
    end

* Associations between objects defined with sinpple class methods

    class Conference < SQLObject
      has_many :teams
      belongs_to :division
    end
