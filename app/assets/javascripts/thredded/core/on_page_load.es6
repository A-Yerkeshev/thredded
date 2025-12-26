//= require thredded/core/thredded

(() => {
  const isTurbo = 'Turbo' in window;
  let onPageLoadFiredOnce = false;
  let lastTriggeredLocation = null;
  const pageLoadCallbacks = [];
  const triggerOnPageLoad = () => {
    const currentLocation = window.location.href;
    if (currentLocation === lastTriggeredLocation) {
      return;
    }
    lastTriggeredLocation = currentLocation;
    pageLoadCallbacks.forEach((callback) => {
      callback();
    });
    onPageLoadFiredOnce = true;
  };

  // Fires the callback on DOMContentLoaded or a Turbo page load.
  // If called from an async script on the first page load, and the DOMContentLoad event
  // has already fired, will execute the callback immediately.
  window.Thredded.onPageLoad = (callback) => {
    pageLoadCallbacks.push(callback);
    // With async script loading, a callback may be added after the DOMContentLoaded event has already triggered.
    // This means we will receive neither a DOMContentLoaded event, nor a turbo:load event on Hotwire Turbo.
    if (!onPageLoadFiredOnce && window.Thredded.DOMContentLoadedFired && !isTurbo) {
      onPageLoadFiredOnce = true;
      lastTriggeredLocation = window.location.href;
      callback();
    }
  };

  if (isTurbo) {
    if (window.Turbo.session.view.lastRenderedLocation) {
      document.addEventListener('DOMContentLoaded', () => {
        triggerOnPageLoad();
      });
    }
    document.addEventListener('turbo:load', () => {
      triggerOnPageLoad();
    });
  } else {
    // No Turbo:
    if (!window.Thredded.DOMContentLoadedFired) {
      document.addEventListener('DOMContentLoaded', () => {
        triggerOnPageLoad();
      });
    }
  }
})();

