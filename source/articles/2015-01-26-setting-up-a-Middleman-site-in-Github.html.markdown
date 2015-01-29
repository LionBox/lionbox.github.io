---
title: Setting up a Middleman site in Github
date: 2015-01-26
tags: Test
layout: post
published: true
---

Create a Github account without two verification steps.

In Github, create a repo that will be your page. username.github.io

Clone that repo into your computer using Github or SourceTree. 

Init a new Middleman project. Use a template (Casper)

```
$ middleman init --template=casper
```
Add the `gem 'middleman-deploy', '~> 1.0'` into your gemfile.

Then confirm your remote git inside your folder. It should be `git@github.com:username/username.github.io.git`

```
$ git remote -v
```

Add the deploy configuration in the `config.rb`.

```
# github deploy
activate :deploy do |deploy|
 deploy.method = :git
 deploy.build_before = true
 deploy.branch   = "master"
 
end
```

We are almost ready. 
Run the commands to build and deploy your middleman.
` $ middleman build` && `$ middleman deploy`

You should now enter your github username and password.
(here is where I got a lot of isssues due to the two steps authentication).

Now should be your code running in your github page username.github.io.

Add a .gitignore file in the root of your project with at least the following content.


```
# Ignore bundler config
/.bundle

# Ignore the build directory
/build

# Ignore Sass' cache
/.sass-cache

# Ignore .DS_store file
.DS_Store
```
On Github app, under the branches tab, create a new branch from master, and called it source
Commit and push your changes. 
(This step is optional if you will be working ALWAYS from the same computer, but I still do it to keep a version control of the environment.)

Now you can start modifying and create articles.