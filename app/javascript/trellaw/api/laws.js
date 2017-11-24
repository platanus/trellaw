import axios from 'axios';

export default {
  getLaws() {
    return axios.get('/api/laws')
      .then(res => res.data);
  },
};
