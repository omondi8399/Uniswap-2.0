import React, { useState, useEffect, useContext } from 'react'

//INTERNAL IMPORT
import { HeroSection } from "../Components/index"
const Home = () => {
  return (
    <div>
      <HeroSection accounts="hey" tokenData="DATA" />
    </div>
  )
}

export default Home