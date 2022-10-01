import { useEffect, useState } from "react"
import { Route, Routes } from "react-router-dom"
import Equipment from "./Pages/Equipment"
import Home from "./Pages/Home"

const App = () => {
    return (
        <>
            
            <Routes>
                <Route path="/" element={<Home />} />
                <Route path="/equipment" element={<Equipment />} />
            </Routes>
        </>
    )
}

export default App
