<template>
  <div class="conversations-list-wrap">
    <slot></slot>
    <div class="chat-list__top">
      <h1 class="page-title text-truncate" :title="pageTitle">
        {{ pageTitle }}
      </h1>
      <chat-filter @statusFilterChange="updateStatusType" />
    </div>

    <chat-type-tabs
      :items="assigneeTabItems"
      :active-tab="activeAssigneeTab"
      class="tab--chat-type"
      @chatTabChange="updateAssigneeTab"
    />

    <p v-if="!chatListLoading && !conversationList.length" class="content-box">
      {{ $t('CHAT_LIST.LIST.404') }}
    </p>

    <div v-if="activeAssigneeTab === 'me' && !chatListLoading && conversationList.length != 0 && pinnedConvoArr.length !=  0">
      <div class="pinned">
      <span>
        Pinned
      </span></div>
      <div ref="activePinConversation" class="conversations-list" v-if="pinnedConvoArr.length !=  0">
        <pinned-conversation-card
          v-for="chat in pinnedConvoArr"
          :key="chat.id"
          :active-label="label"
          :team-id="teamId"
          :chat="chat"
          :show-assignee="showAssigneeInConversationCard"
          :is-pinned="true"
        />

        <div v-if="chatListLoading" class="text-center">
          <span class="spinner"></span>
        </div>


        <!-- <woot-button
          v-if="!hasCurrentPageEndReached && !chatListLoading"
          variant="clear"
          size="expanded"
          @click="fetchConversations"
        >
          {{ $t('CHAT_LIST.LOAD_MORE_CONVERSATIONS') }}
        </woot-button> -->


        <p
          v-if="
            pinnedConvoArr.length &&
              hasCurrentPageEndReached &&
              !chatListLoading
          "
          class="text-center text-muted end-of-list-text"
        >
          {{ $t('CHAT_LIST.EOF') }}
        </p>
      </div>
    </div>

    <span v-if="!chatListLoading && conversationList.length != 0 && activeAssigneeTab === 'me' && pinnedConvoArr.length !=  0" class="pinned">
      All Chats
    </span>
    <div ref="activeConversation" class="conversations-list">
      <conversation-card
        v-for="chat in conversationList"
        :key="chat.id"
        :active-label="label"
        :team-id="teamId"
        :chat="chat"
        :show-assignee="showAssigneeInConversationCard"
        :is-pinned="pinnedIdConvoArr.includes(chat.id)"
        :is-mine="activeAssigneeTab === 'me'? true : false"
      />

      <div v-if="chatListLoading" class="text-center">
        <span class="spinner"></span>
      </div>

      <woot-button
        v-if="!hasCurrentPageEndReached && !chatListLoading"
        variant="clear"
        size="expanded"
        @click="fetchConversations"
      >
        {{ $t('CHAT_LIST.LOAD_MORE_CONVERSATIONS') }}
      </woot-button>

      <p
        v-if="
          conversationList.length &&
            hasCurrentPageEndReached &&
            !chatListLoading
        "
        class="text-center text-muted end-of-list-text"
      >
        {{ $t('CHAT_LIST.EOF') }}
      </p>
    </div>

  </div>
</template>

<script>
import { mapGetters } from 'vuex';

import ChatFilter from './widgets/conversation/ChatFilter';
import ChatTypeTabs from './widgets/ChatTypeTabs';
import ConversationCard from './widgets/conversation/ConversationCard';
import PinnedConversationCard from './widgets/conversation/PinnedConversationCard';
import timeMixin from '../mixins/time';
import eventListenerMixins from 'shared/mixins/eventListenerMixins';
import conversationMixin from '../mixins/conversations';
import wootConstants from '../constants';
import ConversationAPI from '../api/conversations'

import {
  hasPressedAltAndJKey,
  hasPressedAltAndKKey,
} from 'shared/helpers/KeyboardHelpers';

export default {
  components: {
    ChatTypeTabs,
    ConversationCard,
    PinnedConversationCard,
    ChatFilter,
  },
  mixins: [timeMixin, conversationMixin, eventListenerMixins],
  props: {
    conversationInbox: {
      type: [String, Number],
      default: 0,
    },
    teamId: {
      type: [String, Number],
      default: 0,
    },
    label: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      activeAssigneeTab: wootConstants.ASSIGNEE_TYPE.ME,
      activeStatus: wootConstants.STATUS_TYPE.OPEN,
      pinnedConvoArr: [],
      pinnedIdConvoArr: [],
    };
  },
  computed: {
    ...mapGetters({
      currentChat: 'getSelectedChat',
      chatLists: 'getAllConversations',
      mineChatsList: 'getMineChats',
      allChatList: 'getAllStatusChats',
      unAssignedChatsList: 'getUnAssignedChats',
      chatListLoading: 'getChatListLoadingStatus',
      currentUserID: 'getCurrentUserID',
      activeInbox: 'getSelectedInbox',
      conversationStats: 'conversationStats/getStats',
    }),
    assigneeTabItems() {
      return this.$t('CHAT_LIST.ASSIGNEE_TYPE_TABS').map(item => {
        const count = this.conversationStats[item.COUNT_KEY] || 0;
        return {
          key: item.KEY,
          name: item.NAME,
          count,
        };
      });
    },
    showAssigneeInConversationCard() {
      return this.activeAssigneeTab === wootConstants.ASSIGNEE_TYPE.ALL;
    },
    inbox() {
      return this.$store.getters['inboxes/getInbox'](this.activeInbox);
    },
    currentPage() {
      return this.$store.getters['conversationPage/getCurrentPageFilter'](
        this.activeAssigneeTab
      );
    },
    hasCurrentPageEndReached() {
      return this.$store.getters['conversationPage/getHasEndReached'](
        this.activeAssigneeTab
      );
    },
    conversationFilters() {
      return {
        inboxId: this.conversationInbox ? this.conversationInbox : undefined,
        assigneeType: this.activeAssigneeTab,
        status: this.activeStatus,
        page: this.currentPage + 1,
        labels: this.label ? [this.label] : undefined,
        teamId: this.teamId ? this.teamId : undefined,
      };
    },
    pageTitle() {
      if (this.inbox.name) {
        return this.inbox.name;
      }
      if (this.activeTeam.name) {
        return this.activeTeam.name;
      }
      if (this.label) {
        return `#${this.label}`;
      }
      return this.$t('CHAT_LIST.TAB_HEADING');
    },
    conversationList() {
      let conversationList = [];
      const filters = this.conversationFilters;
      if (this.activeAssigneeTab === 'me') {
        conversationList = [...this.mineChatsList(filters)];
      } else if (this.activeAssigneeTab === 'unassigned') {
        conversationList = [...this.unAssignedChatsList(filters)];
      } else {
        conversationList = [...this.allChatList(filters)];
      }

      return conversationList;
    },
    activeTeam() {
      if (this.teamId) {
        return this.$store.getters['teams/getTeam'](this.teamId);
      }
      return {};
    },
  },
  watch: {
    activeTeam() {
      this.resetAndFetchData();
    },
    conversationInbox() {
      this.resetAndFetchData();
    },
    label() {
      this.resetAndFetchData();
    },
  },
  async mounted() {
    try {
      this.$store.dispatch('setChatFilter', this.activeStatus);
      this.resetAndFetchData();

      bus.$on('fetch_conversation_stats', () => {
        this.$store.dispatch('conversationStats/get', this.conversationFilters);
      });

      const response = await ConversationAPI.getAllPinConversations();
      const pinnedConversations = response.data.data.meta.pinned_conversations;
      const pinnedConvoIdArr = [];
      for(let i = 0; i < pinnedConversations.length; i++) {
        const singlePinnedConvo = pinnedConversations[i];
        const id = singlePinnedConvo.id;
        pinnedConvoIdArr.push(id);
      }

      this.pinnedIdConvoArr = pinnedConvoIdArr


      const allConvoArr = JSON.parse(JSON.stringify(this.conversationList));
      for(let key in allConvoArr){
      const singleThisConversation = allConvoArr[key];
        const id =  singleThisConversation.id;
        if(pinnedConvoIdArr.includes(id))
          this.pinnedConvoArr.push(singleThisConversation);
      }
    } catch(error) {
      console.log("error in catch block")
      console.log(error)
    }
  },
  methods: {
    getKeyboardListenerParams() {
      const allConversations = this.$refs.activeConversation.querySelectorAll(
        'div.conversations-list div.conversation'
      );
      const activeConversation = this.$refs.activeConversation.querySelector(
        'div.conversations-list div.conversation.active'
      );
      const activeConversationIndex = [...allConversations].indexOf(
        activeConversation
      );
      const lastConversationIndex = allConversations.length - 1;
      return {
        allConversations,
        activeConversation,
        activeConversationIndex,
        lastConversationIndex,
      };
    },
    handleKeyEvents(e) {
      if (hasPressedAltAndJKey(e)) {
        const {
          allConversations,
          activeConversationIndex,
        } = this.getKeyboardListenerParams();
        if (activeConversationIndex === -1) {
          allConversations[0].click();
        }
        if (activeConversationIndex >= 1) {
          allConversations[activeConversationIndex - 1].click();
        }
      }
      if (hasPressedAltAndKKey(e)) {
        const {
          allConversations,
          activeConversationIndex,
          lastConversationIndex,
        } = this.getKeyboardListenerParams();
        if (activeConversationIndex === -1) {
          allConversations[lastConversationIndex].click();
        } else if (activeConversationIndex < lastConversationIndex) {
          allConversations[activeConversationIndex + 1].click();
        }
      }
    },
    resetAndFetchData() {
      this.$store.dispatch('conversationPage/reset');
      this.$store.dispatch('emptyAllConversations');
      this.fetchConversations();
    },
    fetchConversations() {
      this.$store
        .dispatch('fetchAllConversations', this.conversationFilters)
        .then(() => this.$emit('conversation-load'));
    },
    updateAssigneeTab(selectedTab) {
      if (this.activeAssigneeTab !== selectedTab) {
        bus.$emit('clearSearchInput');
        this.activeAssigneeTab = selectedTab;
        if (!this.currentPage) {
          this.fetchConversations();
        }
      }
    },
    updateStatusType(index) {
      if (this.activeStatus !== index) {
        this.activeStatus = index;
        this.resetAndFetchData();
      }
    },
  },
};
</script>

<style scoped lang="scss">
@import '~dashboard/assets/scss/woot';
.spinner {
  margin-top: var(--space-normal);
  margin-bottom: var(--space-normal);
}

.conversations-list-wrap {
  flex-shrink: 0;
  width: 34rem;

  @include breakpoint(large up) {
    width: 36rem;
  }
  @include breakpoint(xlarge up) {
    width: 35rem;
  }
  @include breakpoint(xxlarge up) {
    width: 38rem;
  }
  @include breakpoint(xxxlarge up) {
    flex-basis: 46rem;
  }
}
.pinned{
  margin: 0px 0px 0px 1rem;
  border-bottom: 1px solid #f0f4f5;
  padding: 1.2rem 0;
  font-size: initial;
}
</style>
