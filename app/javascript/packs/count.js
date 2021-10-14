document.addEventListener('turbolinks:load', () => {
  if(document.getElementById('content')){
  console.log("a")
    const content = document.getElementById('content');
    let count = 1000 - content.value.length;
    const counter = document.getElementById('counter');
    counter.textContent = `残り: ${count}文字`;

    content.addEventListener('keyup',()=>{
      count = 1000 - content.value.length
      counter.textContent = `残り: ${count}文字`;
      if(count < 0){
        counter.classList.add('text-danger')
      }
    })
  }

})
