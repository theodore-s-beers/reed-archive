function switchTheme(e) {
  if (e.target.checked) {
    document.documentElement.setAttribute("data-theme", "dark");
    document.getElementById("theme-text").innerHTML = "Dark";
    localStorage.setItem("theme", "dark");
  } else {
    document.documentElement.setAttribute("data-theme", "light");
    document.getElementById("theme-text").innerHTML = "Light";
    localStorage.setItem("theme", "light");
  }
}

const toggleSwitch = document.querySelector(
  '.theme-switch input[type="checkbox"]'
);

toggleSwitch.addEventListener("change", switchTheme, false);

const currentTheme = localStorage.getItem("theme")
  ? localStorage.getItem("theme")
  : null;

if (currentTheme) {
  document.documentElement.setAttribute("data-theme", currentTheme);

  if (currentTheme === "dark") {
    toggleSwitch.checked = true;
    document.getElementById("theme-text").innerHTML = "Dark";
  }
}
