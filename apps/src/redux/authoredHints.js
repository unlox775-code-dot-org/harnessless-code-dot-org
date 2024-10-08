const ENQUEUE_HINTS = 'authoredHints/ENQUEUE_HINTS';
const SHOW_NEXT_HINT = 'authoredHints/SHOW_NEXT_HINT';
const DISPLAY_MISSING_BLOCK_HINTS = 'authoredHints/DISPLAY_MISSING_BLOCK_HINTS';

import {bisect} from '../utils';

/**
 * @typedef {Object} AuthoredHint
 * @property {string} markdown
 * @property {string} hintId
 * @property {string} hintClass
 * @property {string} hintType
 * @property {?Array<Array>>} hintPath
 * @property {string} hintVideo
 * @property {boolean} alreadySeen
 * @property {string} ttsMessage
 * @property {Element} block
 */

const authoredHintsInitialState = {
  /**
   * @type {!AuthoredHint[]}
   */
  seenHints: [],

  /**
   * @type {!AuthoredHint[]}
   */
  unseenHints: [],
};

export default function reducer(state = authoredHintsInitialState, action) {
  if (action.type === ENQUEUE_HINTS) {
    const [seen, unseen] = bisect(
      action.hints,
      hint => action.hintsUsedIds.indexOf(hint.hintId) !== -1
    );
    return Object.assign({}, state, {
      unseenHints: state.unseenHints.concat(unseen),
      seenHints: state.seenHints.concat(seen),
    });
  }

  if (action.type === SHOW_NEXT_HINT) {
    const nextHint = Object.assign({}, state.unseenHints[0], {
      alreadySeen: true,
    });

    return Object.assign({}, state, {
      unseenHints: state.unseenHints.slice(1),
      seenHints: state.seenHints.concat([nextHint]),
    });
  }

  if (action.type === DISPLAY_MISSING_BLOCK_HINTS) {
    // any contextual hints already displayed but not in this new set
    // should be removed
    const seenHints = state.seenHints.filter(seenHint => {
      if (seenHint.hintType === 'contextual') {
        return action.hints.some(newHint => seenHint.hintId === newHint.hintId);
      }

      return true;
    });

    // any hints we intend to enqueue that are already displayed should
    // not be enqueued to be displayed again.
    const newHintsToEnqueue = action.hints.filter(newHint =>
      state.seenHints.every(seenHint => newHint.hintId !== seenHint.hintId)
    );

    // any currently-enqueued contextual hints should be removed
    const unseenNonContextualHints = state.unseenHints.filter(
      hint => hint.hintType !== 'contextual'
    );

    // unseen contextual hints go to front of queue
    const newUnseenHints = newHintsToEnqueue
      .filter(hint => !hint.alreadySeen)
      .concat(unseenNonContextualHints);

    // seen contextual hints go to back of queue
    const newSeenHints = seenHints.concat(
      newHintsToEnqueue.filter(hint => hint.alreadySeen)
    );

    return Object.assign({}, state, {
      unseenHints: newUnseenHints,
      seenHints: newSeenHints,
    });
  }

  return state;
}

export const enqueueHints = (hints, hintsUsedIds) => ({
  type: ENQUEUE_HINTS,
  hints,
  hintsUsedIds,
});

export const showNextHint = () => ({
  type: SHOW_NEXT_HINT,
});

export const displayMissingBlockHints = hints => ({
  type: DISPLAY_MISSING_BLOCK_HINTS,
  hints,
});
