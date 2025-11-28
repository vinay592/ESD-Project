import { useEffect, useState } from "react";
import axios from "axios";
import {
  Typography,
  Button,
  Tooltip,
  CircularProgress,
} from "@mui/material";
import SchoolIcon from "@mui/icons-material/School";

function Dashboard() {
  const [timetable, setTimetable] = useState([]);
  const [facultyName, setFacultyName] = useState("");
  const [studentCounts, setStudentCounts] = useState({});
  const [loading, setLoading] = useState(true);

  // FINAL TIME SLOTS (12-hour format)
  const TIME_SLOTS = [
    "9-10 AM",
    "10-11 AM",
    "11-12 PM",
    "LUNCH",
    "1-2 PM",
    "2-3 PM",
    "3-4 PM",
  ];

  const DAYS = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  useEffect(() => {
    const token = localStorage.getItem("token");
    const name = localStorage.getItem("facultyName");
    if (name) setFacultyName(name);

    axios
      .get("http://localhost:8080/faculty/timetable", {
        headers: { Authorization: token },
      })
      .then((res) => setTimetable(res.data))
      .catch(() => alert("Failed to fetch timetable"))
      .finally(() => setLoading(false));
  }, []);

  // Fetch student count per course
  useEffect(() => {
    if (!timetable || timetable.length === 0) return;

    const token = localStorage.getItem("token");
    const uniqueCourseIds = [...new Set(timetable.map((t) => t.courseId))];

    Promise.all(
      uniqueCourseIds.map((cid) =>
        axios
          .get(`http://localhost:8080/faculty/course/${cid}/students`, {
            headers: { Authorization: token },
          })
          .then((res) => ({ cid, count: res.data.length }))
          .catch(() => ({ cid, count: 0 }))
      )
    ).then((results) => {
      const map = {};
      results.forEach((r) => (map[r.cid] = r.count));
      setStudentCounts(map);
    });
  }, [timetable]);

  const logout = () => {
    localStorage.clear();
    window.location.href = "/";
  };

  const normalizeDay = (d) =>
    d.charAt(0).toUpperCase() + d.slice(1).toLowerCase();

  const findClass = (day, time) =>
    timetable.find(
      (t) => normalizeDay(t.day) === day && t.time_slot.trim() === time.trim()
    );

  if (loading) {
    return (
      <div
        style={{
          height: "100vh",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          background: "linear-gradient(135deg,#001d3d,#003566,#001d3d)",
        }}
      >
        <CircularProgress sx={{ color: "#4dabf7" }} />
      </div>
    );
  }

  return (
    <div
      style={{
        minHeight: "100vh",
        background: "linear-gradient(135deg,#001d3d,#003566,#001d3d)",
        padding: "35px",
      }}
    >
      {/* HEADER */}
      <div
        style={{
          display: "flex",
          justifyContent: "space-between",
          alignItems: "center",
        }}
      >
        <Typography
          variant="h5"
          style={{
            display: "flex",
            gap: "10px",
            alignItems: "center",
            color: "#e6f4ff",
            fontWeight: 800,
          }}
        >
          <SchoolIcon sx={{ color: "#4dabf7" }} /> Academic ERP
        </Typography>

        <div style={{ display: "flex", alignItems: "center", gap: 15 }}>
          <Typography style={{ fontWeight: 700, color: "#cfe4ff" }}>
            Welcome, {facultyName}
          </Typography>
          <Button
            variant="outlined"
            sx={{
              color: "#cfe4ff",
              borderColor: "#cfe4ff",
              ":hover": { borderColor: "#76c7ff", color: "#76c7ff" },
            }}
            onClick={logout}
          >
            Logout
          </Button>
        </div>
      </div>

      {/* TITLE */}
      <Typography
        style={{
          fontSize: "32px",
          fontWeight: 800,
          marginTop: "35px",
          marginBottom: "28px",
          textAlign: "center",
          color: "#cfe4ff",
        }}
      >
        Weekly Timetable 🕒
      </Typography>

      {/* TABLE */}
      <div style={{ display: "flex", justifyContent: "center" }}>
        <table
          style={{
            borderCollapse: "collapse",
            minWidth: "1000px",
            background: "rgba(255,255,255,0.1)",
            borderRadius: "12px",
            overflow: "hidden",
          }}
        >
          <thead>
            <tr>
              <th
                style={{
                  padding: "14px",
                  background: "rgba(0,0,0,0.35)",
                  color: "#fff",
                  border: "1px solid rgba(255,255,255,0.2)",
                  width: "150px",
                }}
              >
                Day
              </th>

              {TIME_SLOTS.map((slot) => (
                <th
                  key={slot}
                  style={{
                    padding: "14px",
                    background:
                      slot === "LUNCH"
                        ? "rgba(80,140,100,0.55)"
                        : "rgba(0,0,0,0.35)",
                    color: "#fff",
                    border: "1px solid rgba(255,255,255,0.2)",
                    width: slot === "LUNCH" ? "100px" : "150px", // SMALLER lunch column
                  }}
                >
                  {slot === "LUNCH" ? "LUNCH" : slot}
                </th>
              ))}
            </tr>
          </thead>

          <tbody>
            {DAYS.map((day) => (
              <tr key={day}>
                <td
                  style={{
                    padding: "12px",
                    fontWeight: 700,
                    color: "#fff",
                    background: "rgba(255,255,255,0.18)",
                    border: "1px solid rgba(255,255,255,0.2)",
                  }}
                >
                  {day}
                </td>

                {TIME_SLOTS.map((slot) => {
                  const cls = findClass(day, slot);
                  const isLunch = slot === "LUNCH";

                  return (
                    <td
                      key={slot}
                      style={{
                        padding: "10px",
                        textAlign: "center",
                        border: "1px solid rgba(255,255,255,0.2)",
                        background: isLunch
                          ? "rgba(80,140,100,0.35)"
                          : "rgba(255,255,255,0.05)",
                        width: "150px",
                        height: "85px",
                      }}
                    >
                      {/* LUNCH CELL */}
                      {isLunch ? (
                        <b style={{ color: "#fff", fontSize: "14px" }}>
                          LUNCH
                        </b>
                      ) : cls ? (
                        <Tooltip
                          arrow
                          title={
                            <>
                              <div>
                                <b>Course:</b> {cls.courseName}
                              </div>
                              <div>
                                <b>Specialisation:</b>{" "}
                                {cls.specializationName || "General"}
                              </div>
                              <div>
                                <b>Room:</b> {cls.roomNumber}
                              </div>
                              <div>
                                <b>Building:</b> {cls.building}
                              </div>
                              <div>
                                <b>Students:</b>{" "}
                                {studentCounts[cls.courseId] || 0}
                              </div>
                            </>
                          }
                        >
                          <div
                            onClick={() =>
                              (window.location.href = `/students/${cls.courseId}`)
                            }
                            style={{
                              background: "rgba(255,255,255,0.2)",
                              backdropFilter: "blur(12px)",
                              padding: "6px",
                              borderRadius: "10px",
                              cursor: "pointer",
                              border: "1px solid rgba(255,255,255,0.25)",
                              color: "#fff",
                              fontWeight: 700,
                              transition: "0.25s",
                            }}
                            onMouseEnter={(e) =>
                              (e.currentTarget.style.transform =
                                "scale(1.07)")
                            }
                            onMouseLeave={(e) =>
                              (e.currentTarget.style.transform =
                                "scale(1)")
                            }
                          >
                            {cls.courseName}
                          </div>
                        </Tooltip>
                      ) : (
                        <span
                          style={{
                            opacity: 0.18,
                            fontSize: "18px",
                            userSelect: "none",
                          }}
                        >
                          •••
                        </span>
                      )}
                    </td>
                  );
                })}
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
}

export default Dashboard;
