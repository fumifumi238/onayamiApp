import Vue from 'vue/dist/vue.esm'
import LikeButton from '../components/Like/LikeButton.vue'
import TurbolinksAdapter from 'vue-turbolinks';

Vue.use(TurbolinksAdapter);

document.addEventListener('turbolinks:load', () => {
   if (document.getElementById('like')){
     new Vue({
       el: '#like',
       components: { LikeButton }
     })
   }
})
