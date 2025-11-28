import { useState } from "react";
import axios from "axios";
import {
  Box,
  TextField,
  Button,
  Typography,
  Card,
  CardContent,
  Divider
} from "@mui/material";
import SchoolIcon from "@mui/icons-material/School";
import { GoogleLogin } from "@react-oauth/google";

function Login() {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  if(localStorage.getItem("token")) window.location.href = "/dashboard";

  const handleLogin = async () => {
    try {
      const res = await axios.post("http://localhost:8080/auth/login", {
        email,
        password
      });

      localStorage.setItem("token", res.data.token);
      localStorage.setItem("facultyName", res.data.facultyName);

      alert("Login successful!");
      window.location.href = "/dashboard";
    } catch (error) {
      alert("Invalid email or password");
    }
  };

  return (
    <Box
      sx={{
        height: "100vh",
        display: "flex",
        alignItems: "center",
        justifyContent: "center",
        background: "linear-gradient(135deg, #001d3d, #003566, #001d3d)"
      }}
    >
      <Card
        sx={{
          width: 420,
          borderRadius: "18px",
          background: "rgba(255,255,255,0.12)",
          boxShadow: "0 12px 30px rgba(0, 0, 0, 0.45)",
          backdropFilter: "blur(14px)",
          border: "1px solid rgba(255,255,255,0.25)",
          animation: "fadeIn 0.6s ease"
        }}
      >
        <CardContent sx={{ px: 5, py: 4 }}>
          <Box display="flex" justifyContent="center" mb={2}>
            <SchoolIcon sx={{ fontSize: 52, color: "#4dabf7" }} />
          </Box>

          <Typography
            variant="h5"
            fontWeight={700}
            textAlign="center"
            color="#e0f1ff"
            mb={4}
          >
            Academic ERP Login
          </Typography>

          {/* Email */}
          <TextField
            label="Email"
            variant="outlined"
            fullWidth
            sx={{
              mb: 2,
              input: { color: "white", fontSize: "16px" },
              "& .MuiOutlinedInput-root": {
                "& fieldset": { borderColor: "#4dabf7" },
                "&:hover fieldset": { borderColor: "#76c7ff" },
                "&.Mui-focused fieldset": {
                  borderColor: "#00b4ff",
                  boxShadow: "0 0 6px #00b4ff"
                }
              }
            }}
            InputLabelProps={{ sx: { color: "#8bbcff" } }}
            value={email}
            onChange={(e) => setEmail(e.target.value)}
          />

          {/* Password */}
          <TextField
            label="Password"
            type="password"
            variant="outlined"
            fullWidth
            sx={{
              mb: 2,
              input: { color: "white", fontSize: "16px" },
              "& .MuiOutlinedInput-root": {
                "& fieldset": { borderColor: "#4dabf7" },
                "&:hover fieldset": { borderColor: "#76c7ff" },
                "&.Mui-focused fieldset": {
                  borderColor: "#00b4ff",
                  boxShadow: "0 0 6px #00b4ff"
                }
              }
            }}
            InputLabelProps={{ sx: { color: "#8bbcff" } }}
            value={password}
            onChange={(e) => setPassword(e.target.value)}
          />

          <Button
            fullWidth
            variant="contained"
            sx={{
              background: "linear-gradient(90deg,#00b4ff,#0a7cff)",
              py: 1.2,
              fontWeight: 600,
              fontSize: "16px",
              textTransform: "none",
              borderRadius: "10px",
              ":hover": {
                background: "linear-gradient(90deg,#0096ff,#005eff)"
              }
            }}
            onClick={handleLogin}
          >
            Login
          </Button>

          <Divider sx={{ my: 3, borderColor: "rgba(255,255,255,0.2)" }}>
            <span style={{ color: "#bbd4ff" }}>OR</span>
          </Divider>

          {/* Google Sign-in */}
          <Box display="flex" justifyContent="center">
            <GoogleLogin
              onSuccess={async (response) => {
                try {
                  const res = await axios.post(
                    "http://localhost:8080/auth/google",
                    { token: response.credential }
                  );
                  console.log(res)
                  localStorage.setItem("token", res.data.token);
                  localStorage.setItem("facultyName", res.data.facultyName);
                  alert("Login successful!");
                  window.location.href = "/dashboard";
                } catch {
                  alert("Google login failed!");
                }
              }}
              onError={() => alert("Google login failed")}
            />
          </Box>
        </CardContent>
      </Card>

      {/* FULL STYLES INCLUDING AUTOFILL FIX */}
      <style>{`
        @keyframes fadeIn {
          from { opacity: 0; transform: scale(0.96); }
          to { opacity: 1; transform: scale(1); }
        }

        /* Prevent autofill from turning white */
        input:-webkit-autofill,
        input:-webkit-autofill:hover,
        input:-webkit-autofill:focus,
        input:-webkit-autofill:active {
          -webkit-box-shadow: 0 0 0px 1000px rgba(255,255,255,0) inset !important;
          box-shadow: 0 0 0px 1000px rgba(255,255,255,0) inset !important;
          -webkit-text-fill-color: white !important;
          caret-color: white !important;
          transition: background-color 9999s ease-in-out 0s !important;
        }
      `}</style>
    </Box>
  );
}

export default Login;
