import packageJson from './../../package.json'

import { Helmet } from 'react-helmet'
import { TopPage } from './Pages/TopPage'

//====////==========================
const App = () => {
  return (
    <div className='h-100 w-100'>
      <Helmet>
        <link rel='preconnect' href='https://fonts.googleapis.com' />
        <link rel='preconnect' href='https://fonts.gstatic.com' crossorigin />
        <link href='https://fonts.googleapis.com/css2?family=Roboto:wght@100;300;500;700&display=swap' rel='stylesheet' />
      </Helmet>
      <TopPage /> 
      <div className='version-num'>Version: {packageJson.version}</div>
    </div>
)}
export default App