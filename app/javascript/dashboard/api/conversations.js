/* global axios */
import ApiClient from './ApiClient';

class ConversationApi extends ApiClient {
  constructor() {
    super('conversations', { accountScoped: true });
  }

  getLabels(conversationID) {
    return axios.get(`${this.url}/${conversationID}/labels`);
  }

  updateLabels(conversationID, labels) {
    return axios.post(`${this.url}/${conversationID}/labels`, { labels });
  }

  pinConverstation (conversationID) {
    return axios.post(`${this.url}/${conversationID}/pinned`)
  }

  unpinConverstation (conversationID) {
    return axios.post(`${this.url}/${conversationID}/unpin`)
  }

  getAllPinConversations () {
    return axios.get(`${this.url}`)
  }
}

export default new ConversationApi();
