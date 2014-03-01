Dark Harvest is a data-mining tool aimed at the Eclipse ecosystem. It is used in a research project at the University of Utrecht.

## Technology
The system is built on [Ruby](http://www.ruby-lang.org) and (partially) on [Sinatra](http://www.sinatrarb.com/). The system has two files (`harvest.rb` and `categorize.rb`) that are designed to run locally. `endpoint.rb` is not a local ruby script, but a [Sinatra](http://www.sinatrarb.com/) application that needs to be hosted (probably on something like Heroku etc).

## Usage
Copy `config.example.rb` to `config.rb` and change contents as required. The system contains several files. `harvest.rb` consumes the GitHub API to find all repositories of interest. `categorize.rb` uses the Amazon Mechanical Turk API to create classification tasks for all repositories found. `endpoint.rb` provides the callback endpoint for the AMT API.

### Harvest command line arguments
`harvest.rb` supports three command line arguments. Each of these options skips a step in the process, and allows for easily stopping and resuming the harvest. The script assumes that the data of the skipped steps is present, complete and valid (there's no check). 

* `--skip-eclipse-repositories` will not retrieve the inital set of repositories of the Eclipse organisation.
* `--skip-contributors` will not retrieve the contributors of all Eclipse repositories
* `--skip-contributor-repositories` will not retrieve the repositories of all contributors

## License
Copyright Jakob Buis 2014. All rights reserved.
