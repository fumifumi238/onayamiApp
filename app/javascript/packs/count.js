import Vue from 'vue/dist/vue.esm'
import Count from '../components/WordCount.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
   if (document.getElementById('count')){
     new Vue({
       el: '#count',
       components: { Count }
     })
   }
})
