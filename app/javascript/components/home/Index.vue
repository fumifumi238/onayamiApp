 <template>
   <div>
    <header-view v-bind:title="title" v-bind:description="description"></header-view>
    <contents v-bind:contents="contents"></contents>
   </div>
 </template>

<style scoped></style>

 <script>
import HeaderView from "../HeaderView.vue";
import Contents from "./Contents.vue";

 export default {
 components: {
    "header-view": HeaderView,
    contents: Contents
  },
  props: {
    title: {
      type: String,
      default: () => ""
    },
    description: {
      type: String,
      default: () => ""
    },
    contents: {
      type: Object,
      default: () => {}
    }
  }
};
</script>
