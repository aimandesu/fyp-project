const express = require("express");
const app = express();
const axios = require("axios");

// Your API key and other configurations
const apiKey = "AIzaSyD3RGwE1INwks_lLKM728DxI8HfS54z9xU";
const port = 3000;

app.get("/", (req, res) => {
  res.send("Hello World!");
});

app.listen(port, () => {
  console.log(`Server running at http://localhost:${port}`);
});

app.use(function (req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Methods", "GET,PUT,PATCH,POST,DELETE");
  res.header(
    "Access-Control-Allow-Headers",
    "Origin, X-Requested-With, Content-Type, Accept"
  );
  next();
});

app.get("/api/maps/:place", (req, res) => {
  const searchQuery = req.params.place;
  // const searchQuery = "Eiffel Tower"; // Replace with your search query

  // First, make the request to findplacefromtext to get the place_id
  const findPlaceApiUrl =
    "https://maps.googleapis.com/maps/api/place/findplacefromtext/json";

  const findPlaceParams = {
    input: searchQuery,
    inputtype: "textquery",
    key: apiKey,
  };

  axios
    .get(findPlaceApiUrl, { params: findPlaceParams })
    .then((findPlaceResponse) => {
      const placeData = findPlaceResponse.data;

      if (placeData.candidates && placeData.candidates.length > 0) {
        const placeId = placeData.candidates[0].place_id;

        // Now that you have the place_id, make the request to place/details
        const placeDetailsApiUrl =
          "https://maps.googleapis.com/maps/api/place/details/json";

        const placeDetailsParams = {
          placeid: placeId,
          key: apiKey,
        };

        axios
          .get(placeDetailsApiUrl, { params: placeDetailsParams })
          .then((placeDetailsResponse) => {
            const location = placeDetailsResponse.data.result.geometry.location;

            const latitude = location.lat;
            const longitude = location.lng;
            console.log(latitude);
            console.log(longitude);

            // Send the latitude and longitude as a response
            res.json({ latitude, longitude });
          })
          .catch((placeDetailsError) => {
            console.error("Error fetching place details:", placeDetailsError);
            res.status(500).json({ error: "Internal Server Error" });
          });
      } else {
        console.error("No candidates found in findplacefromtext response.");
        res.status(404).json({ error: "Place not found" });
      }
    })
    .catch((findPlaceError) => {
      console.error("Error fetching place ID:", findPlaceError);
      res.status(500).json({ error: "Internal Server Error" });
    });
});
