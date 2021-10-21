<template>
  <div>
    <div v-if="isLiked" @click="deleteLike()" class="liked-btn">
      <i class="far fa-heart"></i>
    </div>
    <div v-else @click="registerLike()" class="like-btn">
      <i class="fas fa-heart"></i>
    </div>
    <p>いいね数: {{ count }}</p>
  </div>
</template>

<script>
import axios from 'axios'
import { csrfToken } from 'rails-ujs'
axios.defaults.headers.common['X-CSRF-TOKEN'] = csrfToken()

export default {
  props: ['userId', 'micropostId'],
  data() {
    return {
      likeList: [],
    }
  },
  computed: {
   
    count() {
      return this.likeList.length
    },

    isLiked() {
      if (this.likeList.length === 0) { return false }
      return Boolean(this.findLikeId())
    }
  },

  created: function() {
    this.fetchLikeByPostId().then(result => {
      this.likeList = result
    })
  },
  methods: {

    fetchLikeByPostId: async function() {
      const res = await axios.get(`/api/likes/?micropost_id=${this.micropostId}`)
      if (res.status !== 200) {

      }
      return res.data
    },

    registerLike: async function() {
      const res = await axios.post('/api/likes', { micropost_id: this.micropostId })
      if (res.status !== 201) {

      }
      this.fetchLikeByPostId().then(result => {
        this.likeList = result
      })
    },

    deleteLike: async function() {
      const likeId = this.findLikeId()
      const res = await axios.delete(`/api/likes/${likeId}`)
      if (res.status !== 200) {
      }
      this.likeList = this.likeList.filter(n => n.id !== likeId)
    },
    findLikeId: function() {
      const like = this.likeList.find((like) => {
        return (like.user_id === this.userId)
      })
      if (like) { return like.id }
    }
  }
}
</script>
<style scoped>
.like-btn{
  color: #c6c6c6;
  display: inline-block;
}

.liked-btn {
  color: #ff0000;
  display: inline-block;
}

</style>
