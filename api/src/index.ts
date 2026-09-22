import { app } from "./app";
import { Util } from "./commons/util";

const port = Util.normalizePort(process.env.PORT || "3000");

app.set("port", port);
app.listen(port, () => console.log("Server is running! Port.: " + port));
