import { useEffect, useState } from "react"
import { Navigate, Route, Routes } from "react-router-dom"
import Navbar from "./Components/Navbar"
import EquipmentPage from "./Pages/Equipment"
import Dashboard from "./Pages/Dashboard"
import Engineer from "./Pages/Engineer"
import { Box } from "@chakra-ui/react"

const App = () => {
    return (
        <>
            <Navbar />
            <Box maxWidth="1500" margin="auto">
                <Routes>
                    <Route path="/" element={<Navigate to="/dashboard" />} />
                    <Route path="/dashboard" element={<Dashboard />} />
                    <Route path="/equipment" element={<EquipmentPage />} />
                    <Route path="/engineer" element={<Engineer />} />
                </Routes>
            </Box>
        </>
    )
}

export default App
