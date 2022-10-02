import { extendTheme } from "@chakra-ui/react";

const theme = extendTheme({
    styles: {
        global: {
            body: {
                bg: "hsl(210, 12%, 97%)",
            },
        },
    },
    components: {
        Table: {
            parts: ["th", "td"],
            baseStyle: {
                th: {
                    borderColor: "black",
                },
                td: {
                    borderColor: "black",
                },
            },
        },
    },
})

export default theme;