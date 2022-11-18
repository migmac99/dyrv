import packageJson from './../../../package.json'
import './../../css/App.css'
import squid from '/squid.svg'
import {useState} from 'react'

import { Glitch } from '/src/js/components/Glitch.jsx'
import { useLocalStorage } from '../hooks/useLocalStorage'
import { useTimeout } from '../hooks/useTimeout'

//===========////////==========================
export const TopPage = () => {

  //---glitch animation---
  const [isGlitching, set_isGlitching] = useState(true)
  useTimeout(()=>set_isGlitching( ! isGlitching ), (isGlitching) ? 200 : (1000 + (Math.random() * 5000)))
  const glitchStyle = isGlitching ? {filter: 'url(#glitchshadow)'} : {}
  
  //---Click [Logout] to: clear pw token from local storage and reload---
  const [lockupPw, set_lockupPw] = useLocalStorage('Dyrv_lockupifier', '')
  const logoutNow = () => {
    set_lockupPw('')
    window.parent.caches.delete("call")
    setTimeout( ()=> {
      console.log('Refreshing...')
      // window.location = window.location.href + '?upd=' + Math.round(Math.random() * 12345678)
      location.reload()
    }, 1000 )
  }
  //-----------------------------------------------
  return (
    <div className='App ocean h-100'>
      <Glitch />
      <div className='dyrv-logo'>
        <a href={packageJson.repository.url} target="_blank" style={glitchStyle}> 
          <img src={squid} alt='Dyrv logo' style={glitchStyle}/>
        </a>
      </div>
      <h2><b>Dyrv</b> sez hi</h2>
      {/* <pre>{JSON.stringify(packageJson.repository, null, 2)}</pre> */}
      <h3>(D)ocker + (Y)arn + (R)eact + (V)ite</h3>
      <br />
      <div className='read-the-docs'>
        Go edit the file
        <code> src/js/Pages/TopPage.jsx</code>
      </div>
      <br/>
      <a href={packageJson.repository.url} target="_blank">
        Dyrv on GitHub
      </a>
      <br/>
      <br/>
      {/* <small style={{fontSize:11}}>
        <a href='#' onClick={logoutNow}>
          [ Logout ]
        </a>
      </small> */}
    </div>
  )
}
