import { useState } from "react"
import reactLogo from "./assets/react.svg"
import { Button, Center, Text } from "@chakra-ui/react"

function App() {
    const [count, setCount] = useState(0)

    return (
        <div>
            <Center>
                <Button colorScheme="teal">Hello</Button>
                <Text>Hello</Text>
            </Center>
        </div>
    )
}

export default App
