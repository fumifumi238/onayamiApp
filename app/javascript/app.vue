<template>
  <div id="app">
    <p>{{ message }}</p>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: count,
    }
  }
}
</script>

<style scoped>
p {
  color: red;
  font-size: 2em;
  text-align: center;
}
</style>
