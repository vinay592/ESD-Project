import { Link } from "react-router-dom";

function Navbar() {
  const logout = () => {
    localStorage.removeItem("token");
    window.location.href = "/";
  };

  return (
    <nav style={{ padding: "15px", background: "#222", color: "white" }}>
      <Link to="/dashboard" style={{ marginRight: "20px", color: "white" }}>
        Dashboard
      </Link>

      <button onClick={logout} style={{ float: "right" }}>
        Logout
      </button>
    </nav>
  );
}

export default Navbar;
