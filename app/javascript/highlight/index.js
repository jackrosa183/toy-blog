import hljs from 'highlight.js'
import 'highlight.js/styles/monokai.css'

hljs.configure({languages: ['ruby', 'javascript', 'bash'] })
document.addEventListener("turbo:load", (event) => {
  document.querySelectorAll('pre').forEach((block) => {
    hljs.highlightBlock(block)
  })
})