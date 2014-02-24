Dark Harvest is a data-mining tool aimed at the Eclipse ecosystem. It is used in a research project at the University of Utrecht.

## Technology
The system is built on [Ruby](http://www.ruby-lang.org) and (partially) on [Sinatra](http://www.sinatrarb.com/). The system has two files (`harvest.rb` and `categorize.rb`) that are designed to run locally. `endpoint.rb` is not a local ruby script, but a [Sinatra](http://www.sinatrarb.com/) application that needs to be hosted (probably on something like Heroku etc).

## Usage
Copy `config.example.rb` to `config.rb` and change contents as required. The system contains several files. `harvest.rb` consumes the GitHub API to find all repositories of interest. `categorize.rb` uses the Amazon Mechanical Turk API to create classification tasks for all repositories found. `endpoint.rb` provides the callback endpoint for the AMT API.

## License
Copyright Jakob Buis 2014. All rights reserved.
