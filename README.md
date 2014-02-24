Dark Harvest is a data-mining tool aimed at the Eclipse ecosystem. It is used in a research project at the University of Utrecht.

## Technology
The system contains several files. `harvest.rb` consumes the GitHub API to find all repositories of interest. `categorize.rb` uses the Amazon Mechanical Turk API to create classification tasks for all repositories found. `endpoint.rb` is a Sinatra application that provides the callback endpoint for the AMT API.

## Installation
Copy `config.example.rb` to `config.rb` and change contents as required. 

## License
Copyright Jakob Buis 2014. All rights reserved.
