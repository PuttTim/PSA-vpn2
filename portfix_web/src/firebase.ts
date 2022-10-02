// Import the functions you need from the SDKs you need
import { initializeApp } from "firebase/app"
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
const firebaseConfig = {
    apiKey: "AIzaSyDPDfWIC_kokSHIA0yc3fcFwQsJw1KERLc",
    authDomain: "psa-vpn2.firebaseapp.com",
    projectId: "psa-vpn2",
    storageBucket: "psa-vpn2.appspot.com",
    messagingSenderId: "989640490656",
    appId: "1:989640490656:web:dd6c4963dfe73a8c5413c5",
}

// Initialize Firebase
const firebaseInstance = initializeApp(firebaseConfig)

export default firebaseInstance
