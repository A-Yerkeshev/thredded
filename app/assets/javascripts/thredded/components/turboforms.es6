//= require thredded/core/thredded
//= require thredded/core/on_page_load
//= require thredded/core/serialize_form

// Submit GET forms with turbo
(() => {
  const Thredded = window.Thredded;
  const Turbo = window.Turbo;

  const handleSubmit = (evt) => {
    evt.preventDefault();
    const form = evt.currentTarget;
    Turbo.visit(form.action + (form.action.indexOf('?') === -1 ? '?' : '&') + Thredded.serializeForm(form));

    // On mobile the soft keyboard doesn't won't go away after the submit since we're submitting with
    // Turbo. Hide it:
    Thredded.hideSoftKeyboard();
  };

  Thredded.onPageLoad(() => {
    if (!Turbo) return;
    Array.prototype.forEach.call(document.querySelectorAll('[data-thredded-turboform]'), (form) => {
      form.addEventListener('submit', handleSubmit);
    });
  });
})();
