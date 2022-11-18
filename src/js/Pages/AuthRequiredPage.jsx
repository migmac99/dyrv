import { useState, useEffect } from 'react'
import { useLocalStorage } from '../hooks/useLocalStorage'
const hashCode = (str)=>(
  str.split('').reduce((agg, x)=>{
    agg = (agg << 5) - agg + x.charCodeAt(0)
    return Math.abs(agg & agg)
  }, 0)
)
//-------////////---------------------------------------------------------
export function AuthRequiredPage({setLoggedIn}) {
  
  const [lockupPw, set_lockupPw] = useLocalStorage('Dyrv_lockupifier', '')
  const [hasErr, set_hasErr] = useState(false)
  const checkPw = (pw) => {
    if (hashCode(pw) == 607151044) {
      setLoggedIn(true)
      set_hasErr(false)
      return true
    }
    else {
      set_hasErr(true)
      return false
    }
  }
  useEffect(()=>{
    if (lockupPw?.length) {
      setLoggedIn(checkPw(lockupPw)) // touch 3 for deployment
    }
  }, [])
  return (
    <div className="auth-req" style={{marginTop:150}}>
      <div className="password-enabled" >
        <div>
          <div className="card">
            <div className="container">
              <h1>Authentication Required</h1>
              <h1>This is fake</h1>
              <p>This deployment requires authentication.</p>
            </div>
            <div className="container">
              <div className={"password "+(hasErr?'error':'')} method="post" data-bitwarden-watching="1">
                <label style={{width:'100%'}}>
                  <div className="label">VISITOR PASSWORD</div>
                  <input 
                    type="password" 
                    name="_sporm_password" 
                    required="" 
                    autofocus=""
                    value={lockupPw}
                    onChange={(ev)=>set_lockupPw(ev.target.value) }
                    onKeyDown={(ev)=>{if (ev.key=='Enter') checkPw(lockupPw)}}
                  />
                </label>
                <div className="alert">
                  <div className="icon-container">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M10.0001 18.3333C14.6025 18.3333 18.3334 14.6023 18.3334 9.99996 18.3334 5.39759 14.6025 1.66663 10.0001 1.66663c-4.60239.0-8.33335 3.73096-8.33335 8.33333C1.66675 14.6023 5.39771 18.3333 10.0001 18.3333z"
                        stroke="#e00"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      ></path>
                      <path d="M10 6.66663V9.99996" stroke="#e00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                      <path d="M10 13.3334H10.0083" stroke="#e00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    </svg>
                  </div>
                  <div className="message">Incorrect password. Please try again.</div>
                </div>
                <div>
                  <button className="NOPE_submit" onClick={()=>checkPw(lockupPw)}>
                    <div className="spinner-wrapper">
                      <div className="spinner">
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                        <div className="spinner-bar"></div>
                      </div>
                    </div>
                    Log in
                  </button>
                </div>
              </div>
              <div className="or">
                <hr />
                <div className="badge">OR</div>
              </div>
              <div className="sso">
                <div onClick={checkPw}>
                  <button type="button">
                    <svg className="sporm" width="24" height="20" viewBox="0 0 24 20" fill="none"><path fill-rule="evenodd" clip-rule="evenodd" d="M12 0 24 20H0L12 0z" fill="#fff"></path></svg> Log in
                  </button>
                </div>
                <div className="alert">
                  <div className="icon-container">
                    <svg width="20" height="20" viewBox="0 0 20 20" fill="none" xmlns="http://www.w3.org/2000/svg">
                      <path
                        d="M10.0001 18.3333C14.6025 18.3333 18.3334 14.6023 18.3334 9.99996 18.3334 5.39759 14.6025 1.66663 10.0001 1.66663c-4.60239.0-8.33335 3.73096-8.33335 8.33333C1.66675 14.6023 5.39771 18.3333 10.0001 18.3333z"
                        stroke="#e00"
                        stroke-width="1.5"
                        stroke-linecap="round"
                        stroke-linejoin="round"
                      ></path>
                      <path d="M10 6.66663V9.99996" stroke="#e00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                      <path d="M10 13.3334H10.0083" stroke="#e00" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"></path>
                    </svg>
                  </div>
                  <div className="message">Unexpected error occurred while authenticating, please try again later.</div>
                </div>
              </div>
            </div>
          </div>
          <div className="footer">
            Powered by <b>Dyrv</b> 
          </div>
        </div>
      </div>
    </div>
  )}
