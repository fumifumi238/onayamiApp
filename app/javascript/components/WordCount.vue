<template>
<div>
  <p >{{contents}}</p>
</div>
</template>
<script>
export default {
  // propsでrailsのviewからデータを受け取る
  props: ['content'],
  data() {
    return {
      contents: [],
      // いいね一覧を格納するための変数　{ id: 1, user_id: 1, post_id: 1 } がArrayで入る
    }
  },
  // 算出プロパティ ここではlikeListが変更される度に、count、isLiked が再構築される (watchで監視するようにしても良いかも)
}
</script>
