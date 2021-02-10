<script>
const card = document.querySelector(".article-summary");
const mainLink = card.querySelector(".article-link");
const clickableElements = Array.from(card.querySelectorAll(".clickable"));

clickableElements.forEach((ele) =>
ele.addEventListener("click", (e) => e.stopPropagation())
);

function handleClick(event) {
const noTextSelected = !window.getSelection().toString();

if (noTextSelected) {
    mainLink.click();
}
}

card.addEventListener("click", handleClick);
</script>