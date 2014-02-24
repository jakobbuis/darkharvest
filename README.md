Dark Harvest is a data-mining tool aimed at the Eclipse ecosystem. It is used in a research project at the University of Utrecht.

## Technology
The system contains several files. `harvest.rb` consumes the GitHub API to find all repositories of interest. `categorize.rb` uses the Amazon Mechanical Turk API to create classification tasks for all repositories found. `endpoint.rb` is a Sinatra application that provides the callback endpoint for the AMT API.

## Installation
Copy `config.example.rb` to `config.rb` and change contents as required. Execute `ruby harvest.rb` to download all repositories of interest to a local database. Execute `ruby categorize.rb` to send all gathered repositories to Amazon Mechanical Turk. Finally, `endpoint.rb` not a local ruby script, but a [Sinatra](http://www.sinatrarb.com/) application that needs to be hosted (probably on something like Heroku etc).

## License
Copyright Jakob Buis 2014. All rights reserved.
