import packageJson from './../../../package.json'
import './../../css/App.css'
import squid from '/squid.svg'
import {useState} from 'react'

import { Glitch } from '/src/js/components/Glitch.jsx'
import {useTimeout} from '../hooks/useTimeout'

//====////==========================
export const TopPage = () => {
  const [isGlitching, set_isGlitching] = useState(true)
  useTimeout(()=>set_isGlitching( ! isGlitching ), (isGlitching) ? 200 : (1000 + (Math.random() * 5000)))
  const glitchStyle = isGlitching ? {filter: 'url(#glitchshadow)'} : {}

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
    </div>
  )
}
