# vibejs-enum

[![Build Status](https://travis-ci.org/vibejs/vibejs-enum.svg?branch=master)](https://travis-ci.org/vibejs/vibejs-enum)

## Introduction

*enum* provides you with an enum factory and an Enum class you can use for declaring
enums in your Javascript/Coffee-Script application.


### Motivation

In 2011 I was looking for a working Enum class and method to create such enums. The first stab
at this was the enumjs project which had since been abandoned. Regardless to say that since then
numerous other developers published their own solutions on NPM. Having reviewed a few of them,
I must say that they as a whole would suit my requirements, yet, with some of these requirements
still being unfulfilled I must start over from scratch and reimplement the whole shebang,
especially when targetting multiple platforms such as Meteor Client/Server, Node only and
Browser only. Besides of that, it will fit nicely into the overall infrastructure of core 
libraries I am currently setting up for my future projects.


### Features

 - TODO
 - exports vibe.lang.enum namespace
 - NPM package
 - Meteor package


## LICENSE


    Copyright 2011-2014 Carsten Klein
   
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
   
         http://www.apache.org/licenses/LICENSE-2.0
   
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and 
    limitations under the License.
   

## Installation


### NPM

You can install TODO using npm.

    npm [-g] install vibejs-enum


### Meteor

You can install TODO using meteor.

    meteor add vibejs:enum


## Usage


### Node - Javascript

    require('vibejs-enum');


### Node - Coffee-Script

    require 'vibejs-enum'


### Meteor - Javascript

    if (Meteor.isClient(){
        TODO
    }
    else {
        TODO
    }

    
### Meteor - Coffee-Script

    if Meteor.isClient()

        TODO

    else

        TODO

