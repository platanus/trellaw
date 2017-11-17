/* helper for testing action with expected mutations */
/* eslint-disable max-params, no-shadow */

export default {
  testAction(action, payload, state, expectedMutations, done) {
    let count = 0;

    // mock commit
    function commit(type, payload) {
      const mutation = expectedMutations[count];

      try {
        expect(mutation.type).toEqual(type);
        if (payload) {
          expect(mutation.payload).toEqual(payload);
        }
      } catch (error) {
        done(error);
      }

      count++;
      if (count >= expectedMutations.length) {
        done();
      }
    }

    // call the action with mocked store and arguments
    action({ commit, state }, payload);

    // check if no mutations should have been dispatched
    if (expectedMutations.length === 0) {
      expect(count).toEqual(0);
      done();
    }
  },
};
