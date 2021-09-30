<template>
  <div id="app">
    <ul>
      <li v-for="micropost in microposts" :key="micropost.id">
            <p>{{micropost.content}}</p>
            <p>{{micropost.user_name}}　さん</p>
            <p>いいね数:{{micropost.likes_count}}</p>
            <i class="far fa-heart like-btn"></i>
      </li>
    </ul>
  </div>
</template>

<script>
import axios from 'axios';

export default {
  data: function () {
    return {
      microposts: []
    }
  },
  mounted: function(){
    axios
      .get('/api/microposts')
      .then(response => (this.microposts = response.data))
  }
}
</script>

<style scoped>

</style>
