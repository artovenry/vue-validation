import Vue from "vue"
import Site from "./Site.vue"
import store from "./store.coffee"

new Vue
  render: (h)->h Site
  store: store
  created: ->
    document.addEventListener "DOMContentLoaded", =>@$mount "#site"
