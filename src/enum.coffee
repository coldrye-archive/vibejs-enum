#
# Copyright 2011-2014 Carsten Klein
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#


# we always export globally
exports = window ? global


# guard preventing us from exporting twice
unless exports.enumerate?

    # The class Enum models the root of a hierarchy of derived classes.
    #
    # @memberof vibejs.lang
    class Enum

        # Default constructor. Prevents instantiation of the class.
        constructor : ->

            throw new TypeError "enums cannot be instantiated and should not be inherited from."

        # Returns the constant for either name or ordinal or null.
        #
        # @abstract
        # @return enum constant or null
        @valueOf : (value) ->

        # Returns the enum constants as an array.
        #
        # @property
        # @readonly
        # @abstract
        @values : null

    # Recommendation only, logs a warning
    ENUM_CLASS_NAME_RE = /^[$_]?E[A-Z][a-z]+(?:[A-Z][a-z]+)*[0-9]*$/

    # Requirement.
    ENUM_CONSTANT_NAME_RE = /^[A-Z_]+[A-Z_0-9]*$/

    # counter used for creating unique enum names
    anonymousEnumCount = 0

    # The factory used for creating new enum classes.
    #
    # @param {} decl
    # @option decl String name The name of the created enum class
    # @option Object logger optional logger for debugging purposes (must have a debug() method)
    # @option decl {} static static properties / methods of the created class
    # @option decl {} constants 
    # @memberof vibejs.lang
    exports.enumerate = (decl) ->

        if not decl

            throw new TypeError "required parameter decl is either missing or not an object."

        # optional name
        name = decl.name ? null
        if name is null

            name = "AnonEnum_#{anonymousEnumCount}"
            anonymousEnumCount++

        # set up optional debug logger
        logger = decl.logger ? null

        # dictionary used as ordinal/name to value mapping
        dict = {}
        values = []

        class EnumImplBase extends Enum

            constructor: (@name, @ordinal) ->

            @valueOf : (value) ->

                result = null

                if value instanceof @

                    result = value

                else if value of dict

                    result = dict[value]

                result

            Object.defineProperty @, 'values',

                enumerable : true

                configurable : false

                value : ->

                    value for value in values

        dynclass

            name : name

            base : EnumImplBase

            freeze : true

            ctor : ->

                if Object.isFrozen @constructor

                    throw new TypeError "enums cannot be instantiated and must not be inherited from."

            extend : (klass) ->

                ord = 1
                for key, spec of decl.extend

                    key = key.trim()

                    if null == ENUM_CONSTANT_NAME_RE.exec key

                        throw new Error "Constant literal must match production '#{ENUM_CONSTANT_NAME_RE}'."

                    newOrd = -1
                    if typeof spec is 'number'

                        newOrd = spec

                    else

                        throw new TypeError "Ordinal must be a number. (literal='#{key}', type='#{typeof spec}', value='#{spec}'"

                    ord = newOrd if newOrd > 0

                    if ord of dict

                        throw new TypeError "Duplicate ordinals. (ordinal='#{ord}', literal='#{dict[ord].name()}', duplicate='#{key}'.)"

                    instance = new klass key, ord
                    Object.freeze instance

                    dict[ord] = dict[key] = klass[key] = instance
                    values.push instance
                    ord += 1

                if values.length == 0

                    throw new TypeError "Enums require at least one literal constant."


    # @namespace vibejs.lang
    namespace 'vibejs.lang',

        readonly : true

        extend :

            Enum : Enum

            enumerate : exports.enumerate


    namespace 'vibejs.lang.constants',

        readonly : true

        extend :

            ENUM_CLASS_NAME_RE : ENUM_CLASS_NAME_RE

            ENUM_CONSTANT_NAME_RE : ENUM_CONSTANT_NAME_RE

