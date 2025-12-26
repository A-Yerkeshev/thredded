(() => {
  const COMPONENT_SELECTOR = '[data-thredded-flash-message]';

  document.addEventListener('turbo:before-cache', () => {
    Array.prototype.forEach.call(document.querySelectorAll(COMPONENT_SELECTOR), (node) => {
      node.parentNode.removeChild(node);
    });
  });
})();
