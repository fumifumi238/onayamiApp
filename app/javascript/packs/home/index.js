import TurbolinksAdapter from 'vue-turbolinks'
import Vue from 'vue'
import Index from '../../components/home/Index.vue'

Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
   const node = document.getElementById("homeIndex");
   if(node == null){
     return '';
   }
   const props = JSON.parse(node.getAttribute("data"));
const app = new Vue({
    render: h => h(Index, { props })
  }).$mount();
  document.body.appendChild(app.$el);
})
