import { useEffect, useState } from "react"
import { Navigate, Route, Routes } from "react-router-dom"
import Navbar from "./Components/Navbar"
import EquipmentPage from "./Pages/EquipmentPage"
import Dashboard from "./Pages/Dashboard"
import EngineerPage from "./Pages/EngineerPage"
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
                    <Route path="/engineer" element={<EngineerPage />} />
                </Routes>
            </Box>
        </>
    )
}

export default App
