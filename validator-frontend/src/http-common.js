import axios from "axios";

export default axios.create({
  baseURL: ":8080/api/v1",
  headers: {
    "Content-type": "application/json",
  },
});
