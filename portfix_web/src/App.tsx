import { useEffect, useState } from "react"
import { Navigate, Route, Routes } from "react-router-dom"
import Navbar from "./Components/Navbar"
import EquipmentPage from "./Pages/EquipmentPage"
import DashboardPage from "./Pages/DashboardPage"
import { Box } from "@chakra-ui/react"
import LogPage from "./Pages/LogPage"

const App = () => {
    return (
        <>
            <Navbar />
            <Box maxWidth="1500" margin="auto">
                <Routes>
                    <Route path="/" element={<Navigate to="/dashboard" />} />
                    <Route path="/dashboard" element={<DashboardPage />} />
                    <Route path="/equipment" element={<EquipmentPage />} />
                    <Route path="/logs" element={<LogPage />} />
                </Routes>
            </Box>
        </>
    )
}

export default App
