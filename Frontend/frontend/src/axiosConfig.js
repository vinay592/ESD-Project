import axios from "axios";

const instance = axios.create({
  baseURL: "http://localhost:8080",
});

// Attach JWT token if it exists
instance.interceptors.request.use((config) => {
  const token = localStorage.getItem("token");

  if (token) {
    // token already includes "Bearer <token>"
    config.headers = config.headers || {};
    config.headers.Authorization = token;
  }

  return config;
});

// Auto logout if backend returns 401
instance.interceptors.response.use(
  (res) => res,
  (err) => {
    if (err.response?.status === 401) {
      localStorage.clear();
      window.location.href = "/";
    }
    return Promise.reject(err);
  }
);


export default instance;
