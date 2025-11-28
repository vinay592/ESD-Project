import { useEffect, useState } from "react";
import { useParams } from "react-router-dom";
import axios from "axios";
import {
  Box,
  Typography,
  Card,
  CardContent,
  Table,
  TableBody,
  TableCell,
  TableContainer,
  TableHead,
  TableRow,
  TextField,
  IconButton,
  Button
} from "@mui/material";
import ArrowBackIcon from "@mui/icons-material/ArrowBack";
import SchoolIcon from "@mui/icons-material/School";

function Students() {
  const { courseId } = useParams();
  const [students, setStudents] = useState([]);
  const [search, setSearch] = useState("");

  useEffect(() => {
    const token = localStorage.getItem("token");
    axios
      .get(`http://localhost:8080/faculty/course/${courseId}/students`, {
        headers: { Authorization: token }
      })
      .then(res => setStudents(res.data))
      .catch(() => alert("Failed to load students"));
  }, [courseId]);

  return (
    <Box
      sx={{
        minHeight: "100vh",
        background: "linear-gradient(135deg, #001d3d, #003566, #001d3d)",
        padding: "45px 20px",
      }}
    >
      <Box sx={{ maxWidth: "1100px", margin: "0 auto", animation: "fadeIn 0.5s" }}>
        
        {/* Header */}
        <Box display="flex" alignItems="center" gap={1} mb={4}>
          <IconButton
            sx={{ color: "#cfe4ff" }}
            onClick={() => (window.location.href = "/dashboard")}
          >
            <ArrowBackIcon />
          </IconButton>

          <SchoolIcon sx={{ fontSize: 32, color: "#4dabf7" }} />

          <Typography variant="h4" fontWeight={800} color="#e6f4ff">
            Students Enrolled
          </Typography>
        </Box>

        {/* Search input */}
        <TextField
          fullWidth
          placeholder="Search by name or roll number..."
          value={search}
          onChange={(e) => setSearch(e.target.value.toLowerCase())}
          sx={{
            mb: 4,
            input: { color: "#d8ecff" },
            background: "rgba(255,255,255,0.08)",
            borderRadius: "10px",
            "& .MuiOutlinedInput-root": {
              "& fieldset": { borderColor: "rgba(255,255,255,0.25)" },
              "&:hover fieldset": { borderColor: "#66c9ff" },
              "&.Mui-focused fieldset": { borderColor: "#66c9ff" }
            },
            color: "#fff"
          }}
        />

        {/* Glass Table */}
        <Card
          sx={{
            borderRadius: "18px",
            background: "rgba(255,255,255,0.1)",
            backdropFilter: "blur(14px)",
            boxShadow: "0 14px 38px rgba(0,0,0,0.55)",
            border: "1px solid rgba(255,255,255,0.18)",
          }}
        >
          <CardContent>
            <TableContainer>
              <Table>
                <TableHead>
                  <TableRow>
                    <TableCell sx={{ fontWeight: 800, color: "#a9d8ff" }}>
                      Roll Number
                    </TableCell>
                    <TableCell sx={{ fontWeight: 800, color: "#a9d8ff" }}>
                      Name
                    </TableCell>
                    <TableCell sx={{ fontWeight: 800, color: "#a9d8ff" }}>
                      Email
                    </TableCell>
                  </TableRow>
                </TableHead>

                <TableBody>
                  {students
                    .filter(
                      (stu) =>
                        stu.firstName.toLowerCase().includes(search) ||
                        stu.lastName.toLowerCase().includes(search) ||
                        stu.rollNumber.toLowerCase().includes(search)
                    )
                    .map((stu, idx) => (
                      <TableRow
                        key={idx}
                        sx={{
                          transition: "0.25s",
                          ":hover": {
                            background: "rgba(0,180,255,0.12)",
                            transform: "scale(1.01)",
                          },
                        }}
                      >
                        <TableCell sx={{ color: "#e8f5ff" }}>
                          {stu.rollNumber}
                        </TableCell>
                        <TableCell sx={{ color: "#e8f5ff" }}>
                          {stu.firstName} {stu.lastName}
                        </TableCell>
                        <TableCell sx={{ color: "#e8f5ff" }}>
                          {stu.email}
                        </TableCell>
                      </TableRow>
                    ))}
                </TableBody>
              </Table>
            </TableContainer>
          </CardContent>
        </Card>
      </Box>

      {/* Fade animation */}
      <style>{`
        @keyframes fadeIn {
          from { opacity: 0; transform: translateY(8px); }
          to { opacity: 1; transform: translateY(0); }
        }
      `}</style>
    </Box>
  );
}

export default Students;
