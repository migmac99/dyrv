import { React, StrictMode } from 'react'
import ReactDOM from 'react-dom'

import './scss/Custom.scss'
import './css/index.css'

import App from './js/App'

const rootElement = document.getElementById('root')
ReactDOM.render(
  <StrictMode>
    <App />
  </StrictMode>,
  rootElement
)
