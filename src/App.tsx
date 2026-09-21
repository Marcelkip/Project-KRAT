import './App.css'

const stats = [
  { label: 'OPEN', value: 0, className: 'stat-open' },
  { label: 'IN BEHANDELING', value: 0, className: 'stat-progress' },
  { label: 'OPGELOST', value: 0, className: 'stat-resolved' },
  { label: 'VERLOPEN', value: 0, className: 'stat-expired' },
]

function App() {
  return (
    <>
      <header className="topbar">
        <div className="topbar-inner">
          <h1 className="logo">
            KRAT<span>TY</span>
          </h1>
          <span className="user-label">Misael Temesgen</span>
        </div>
      </header>

      <main className="container">
        <h2 className="page-title">Ticketoverzicht</h2>

        <section className="stats">
          {stats.map((stat) => (
            <div key={stat.label} className={`stat-card ${stat.className}`}>
              <div className="stat-top">
                <span className="stat-label">{stat.label}</span>
                <span className="stat-dot"></span>
              </div>
              <span className="stat-value">{stat.value}</span>
            </div>
          ))}
        </section>
      </main>
    </>
  )
}

export default App

