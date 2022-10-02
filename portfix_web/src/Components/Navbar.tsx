import { Box, Button, HStack, Image, Text } from "@chakra-ui/react"
import React from "react"
import { useLocation, useNavigate } from "react-router-dom"
import portFixLogoText from "../assets/PortFix-Logo-Text.svg"

interface NavbarItems {
    name: string
    pageUrl: string
}

const pages: NavbarItems[] = [
    { name: "Dashboard", pageUrl: "/dashboard" },
    { name: "Equipment", pageUrl: "/equipment" },
    { name: "All Logs", pageUrl: "/log" },
    { name: "Engineer", pageUrl: "/engineer" },
]

const Navbar = () => {
    const navigate = useNavigate()
    const location = useLocation()

    return (
        <Box bgColor="hsl(0, 0%, 99%)" mb={10} paddingX={4} paddingY={2.5}>
            <HStack>
                <Image src={portFixLogoText} width="8%" objectFit="cover" />
                <HStack spacing={5} style={{ marginLeft: "3em" }}>
                    {pages.map(page => (
                        <Button
                            key={page.name}
                            fontWeight={
                                location.pathname.includes(page.pageUrl)
                                    ? "bold"
                                    : "normal"
                            }
                            fontSize="lg"
                            color="cyan.800"
                            onClick={() => navigate(page.pageUrl)}
                            variant="link"
                            sx={{ transition: "font-weight 0.15s ease-out" }}>
                            {page.name}
                        </Button>
                    ))}
                </HStack>
            </HStack>
        </Box>
    )
}

export default Navbar
