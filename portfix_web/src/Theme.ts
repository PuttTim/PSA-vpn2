import { extendTheme } from "@chakra-ui/react";

const theme = extendTheme({
    styles: {
        global: {
            body: {
                bg: "hsl(210, 12%, 97%)",
            },
        },
    },
})

export default theme;