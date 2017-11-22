import Vue from "vue"
import Vuex from "vuex"
Vue.use Vuex
S= require "string"
DEFAULT_STATE= message: "", amount: 0

class Module
  constructor: (opts)->{@attr, @validate}= opts
  namespaced: on
  mutations: 
    validate: (state, val)->
      state[@attr].errors= @validate(val) ? []
      
    clear: (state)->state[@attr].errors= []

export default new Vuex.Store
  strict: on
  state: -> _.mapObject DEFAULT_STATE, (item)->
      {errors: [], notifying: no, value: item} 
  mutations:
    toggleAll: -> state.forEach (item)->item.notifying= yes

  modules:
    message: new Module
      attr: "message"
      validate: (val)->[
        if S(val).isEmpty() then "必須入力です"
        else if val.length > 10 then "長すぎる"
      ]

    amount:
      namespaced: on
      mutations: 
        validate: (state, val)->
          if not _.include [0..5], val then state.errors= ["必須入力です"]
          else state.errors= []
          state.value= val
