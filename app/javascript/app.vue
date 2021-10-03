<template>
  <div id="app">
    <ul>
      <li v-for="micropost in microposts" :key="micropost.id">
        <div class="box1">
            <a @click="clickLink(micropost.id, $event)">{{micropost.content}}</a>
            <p class="text-right">{{micropost.user_name}}さん   いいね数:{{micropost.likes_count}}</p>
        </div>
      </li>
    </ul>
    </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      microposts: [],
      url: "microposts/"
    }
  },
  mounted: function(){
    axios
      .get('/api/microposts')
      .then(response => (this.microposts = response.data))
  },
  methods:{
    clickLink: function(id,event){
      let link = event.target
      link.href = this.url + id
      console.log(link)
    }
  }
}
</script>

<style scoped>
.box1 {
    padding: 0.5em 0.5em;
    margin: 1em 0;
    font-weight: bold;
    background: #FFF;
    border: double 5px #4ed3a7e5;
    border-radius: 10px;/*角の丸み*/
}
.box1 p {
    margin: 0;
    padding: 0;
    color: #6091d3;/*文字色*/
}


</style>
