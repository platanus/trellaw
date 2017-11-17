import axios from 'axios';

export default {
  getBoard(id) {
    return axios.get(`/api/boards/${id}`)
      .then(res => res.data);
  },
};
