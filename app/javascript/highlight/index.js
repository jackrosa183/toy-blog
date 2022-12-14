import hljs from 'highlight.js'
import 'highlight.js/styles/monokai.css'

hljs.configure({languages: ['ruby', 'javascript', 'bash', 'html', 'elixir', 'css'] })
document.addEventListener("turbo:load", (event) => {
  document.querySelectorAll('pre').forEach((block) => {
    hljs.highlightElement(block)
  })
})