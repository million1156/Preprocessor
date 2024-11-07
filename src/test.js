// send an axios request to api.myip.com

import axios from "axios";

axios.get("https://api.myip.com").then((response) => {
  console.log(response.data);
});
