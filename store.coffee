import Vue from "vue"
import Vuex from "vuex"
import model from "model"
Vue.use Vuex

class Module
  namespaced: on
  state: => value: @value, errors: [], notifying: no
  constructor: (opts)->
    {@attr, @value, @validate}= opts
    @mutations=
      validate: (state, val)=>
        state.errors= _.compact @validate(val)
        state.value= val
      clear: (state)=>state.errors= []

export default new Vuex.Store
  strict: on
  mutations:
    toggleAll: (state)-> console.log state.keys;state.forEach (item)->item.notifying= yes
  modules: _.mapObject model, (item, attr)-> new Module {attr: attr, item...}
