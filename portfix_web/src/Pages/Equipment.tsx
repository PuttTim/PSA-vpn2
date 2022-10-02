import {
    Box,
    Grid,
    GridItem,
    HStack,
    Stat,
    StatLabel,
    VStack,
} from "@chakra-ui/react"
import { GeoPoint } from "@google-cloud/firestore"
import {
    getFirestore,
    getDocs,
    collection,
    onSnapshot,
} from "firebase/firestore"
import { useEffect, useState } from "react"
import EquipmentTable from "../Components/EquipmentTable"
import firebaseInstance from "../firebase"
import { Equipment } from "../Interfaces/Equipment"

const EquipmentPage = () => {
    const db = getFirestore(firebaseInstance)

    const [equipmentId, setEquipmentId] = useState("0")
    const [equipmentList, setEquipmentList] = useState<Equipment[]>([])

    const selectEquipment = (id: string) => {
        if (id === equipmentId) {
            setEquipmentId("0")
        } else {
            setEquipmentId(id)
        }
    }

    useEffect(() => {
        const unsubscribe = onSnapshot(
            collection(db, "equipment"),
            querySnapshot => {
                const tempEquipmentList: Equipment[] = []
                querySnapshot.forEach(doc => {
                    tempEquipmentList.push({
                        id: doc.id,
                        model: doc.data().model,
                        location: doc.data().location,
                        geopoint: doc.data().geopoint,
                    })
                })
                setEquipmentList(tempEquipmentList)
            },
        )

        return () => unsubscribe()
    }, [])

    return (
        <Box w="full">
            <Grid
                maxH="90vh"
                w="full"
                gridTemplateRows="repeat(5, 1fr)"
                gridTemplateColumns="repeat(2, 1fr)"
                gap={8}>
                <GridItem maxH="full" rowSpan={5} colSpan={1}>
                    <EquipmentTable
                        heading={[
                            "Status",
                            "Equipment",
                            "Model",
                            "Location",
                            "Info",
                        ]}
                        equipment={equipmentList}
                        onSelect={selectEquipment}
                    />
                </GridItem>
                <GridItem rowSpan={2} colSpan={1}>
                    <Box border="2px" h="full">
                        {equipmentId}
                    </Box>
                </GridItem>
                <GridItem rowSpan={3} colSpan={1}></GridItem>
            </Grid>
        </Box>
    )
}

export default EquipmentPage
