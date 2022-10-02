import React, { useEffect } from "react"
import {
    collection,
    doc,
    getDoc,
    getFirestore,
    getDocs,
} from "firebase/firestore"
import firebaseInstance from "../firebase"

const Dashboard = () => {
    useEffect(() => {
        console.log("Dashboard")
        const db = getFirestore(firebaseInstance)
        getDocs(collection(db, "equipment")).then(querySnapshot => {
            querySnapshot.forEach(doc => {
                console.log({ id: doc.id, ...doc.data() })
            })
        })
    }, [])

    return <div>Home</div>
}

export default Dashboard
