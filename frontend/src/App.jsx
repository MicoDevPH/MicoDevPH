import './App.css'
import Agent from './components/Agent';


function App() {
  return (
    <div className="container">
      <header>
        <h1 className="name">MICODEVPH</h1>
        <p className="tagline">Full-Stack Developer | Python & React</p>
      </header>

      <main>
        <div className="card">
          <h2>Latest Project</h2>
          <p>Exploring the intersection of AI agents and web interfaces.</p>
          <div className="tech-stack">
            <span>React</span>
            <span>Vite</span>
            <span>Python</span>
          </div>
        </div>
      </main>
      <Agent />
    </div>
  )
}

export default App
