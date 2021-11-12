<template>
  <div v-if="isMine">
    <div
      class="conversation"
      :class="{
        active: isActiveChat,
        'unread-chat': hasUnread,
        'has-inbox-name': showInboxName,
      }"
      @click="cardClick(chat)" v-if="!isPinned"
    >
      <thumbnail
        v-if="!hideThumbnail"
        :src="currentContact.thumbnail"
        :badge="inboxBadge"
        class="columns"
        :username="currentContact.name"
        :status="currentContact.availability_status"
        size="40px"
      />
      <div class="conversation--details columns">
        <div class="conversation--metadata">
          <inbox-name v-if="showInboxName" :inbox="inbox" />
          <span
            v-if="showAssignee && assignee.name"
            class="label assignee-label text-truncate"
          >
            <i class="ion-person" />
            {{ assignee.name }}
          </span>
        </div>
        <h4 class="conversation--user">
          {{ aditionalAttributeConversation }}
        </h4>
        <h5 class="conversation--user conversation--user--with-pin">
          {{ currentContact.name }}
          <span v-if="isPinned" class="pin-chat" @click="unpinConverstation($event, chat.id)" >

            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="256" height="256" viewBox="0 0 256 256" xml:space="preserve">
              <desc>Created with Fabric.js 1.7.22</desc>
              <defs>
              </defs>
              <g transform="translate(128 128) scale(0.72 0.72)" style="">
                <g style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: none; fill-rule: nonzero; opacity: 1;" transform="translate(-175.05 -175.05000000000004) scale(3.89 3.89)" >
                <path d="M 89.011 87.739 c -0.599 -1.371 -1.294 -2.652 -1.968 -3.891 l -0.186 -0.343 l -15.853 -15.91 c -0.371 -0.375 -0.746 -0.748 -1.12 -1.12 c -0.671 -0.667 -1.342 -1.335 -1.997 -2.018 l -1.459 -1.437 l 23.316 -23.317 l -1.704 -1.704 c -9.111 -9.112 -22.925 -12.518 -35.353 -8.759 l -6.36 -6.359 c 0.769 -7.805 -2.017 -15.69 -7.503 -21.175 L 37.123 0 L 0 37.122 l 1.706 1.704 c 5.487 5.487 13.368 8.271 21.176 7.503 l 6.36 6.36 C 25.484 65.115 28.889 78.93 38 88.041 l 1.703 1.704 l 23.316 -23.316 l 1.438 1.458 c 0.679 0.653 1.344 1.321 2.009 1.989 c 0.373 0.374 0.745 0.748 1.117 1.116 l 15.699 15.7 l 0.566 0.352 c 1.239 0.673 2.52 1.369 3.891 1.968 L 90 90 L 89.011 87.739 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                </g>
              </g>
            </svg>
          </span>
          <span v-else class="pin-chat" @click="pinConverstation($event, chat.id)">
            <svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" version="1.1" width="256" height="256" viewBox="0 0 256 256" xml:space="preserve">
              <desc>Created with Fabric.js 1.7.22</desc>
              <defs>
              </defs>
              <g transform="translate(128 128) scale(0.72 0.72)" style="">
                <g style="stroke: none; stroke-width: 0; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: none; fill-rule: nonzero; opacity: 1;" transform="translate(-175.05 -175.05000000000004) scale(3.89 3.89)" >
                <path d="M 84.303 82.191 l -6.492 -6.492 l -6.492 -6.492 c -1.077 -1.087 -2.175 -2.153 -3.235 -3.257 c -0.016 -0.009 -0.031 -0.017 -0.047 -0.025 l -2.154 -2.154 L 90 39.653 l -1.056 -1.056 c -9.367 -9.368 -23.457 -12.705 -36.139 -8.632 l -7.345 -7.344 c 0.929 -7.947 -1.815 -15.958 -7.422 -21.565 L 36.983 0 L 0 36.982 l 1.057 1.056 c 5.606 5.606 13.614 8.353 21.565 7.422 l 7.345 7.345 c -4.073 12.681 -0.737 26.772 8.631 36.139 L 39.653 90 l 24.117 -24.117 l 2.155 2.155 c 0.008 0.015 0.016 0.031 0.025 0.046 c 1.1 1.058 2.164 2.152 3.247 3.226 l 8.081 8.081 l 0 0 l 4.912 4.912 l 3.246 3.246 c 1.403 0.761 2.796 1.532 4.302 2.19 c -0.658 -1.506 -1.429 -2.899 -2.19 -4.302 L 84.303 82.191 z M 33.086 52.897 l 0.311 -0.886 l -9.714 -9.714 l -0.742 0.108 c -6.763 0.987 -13.633 -1.042 -18.681 -5.459 L 36.948 4.26 c 4.415 5.047 6.447 11.92 5.458 18.68 l -0.108 0.742 l 9.714 9.714 l 0.886 -0.311 c 11.361 -3.984 24.084 -1.387 32.853 6.593 L 39.678 85.75 C 31.698 76.981 29.102 64.254 33.086 52.897 z" style="stroke: none; stroke-width: 1; stroke-dasharray: none; stroke-linecap: butt; stroke-linejoin: miter; stroke-miterlimit: 10; fill: rgb(0,0,0); fill-rule: nonzero; opacity: 1;" transform=" matrix(1 0 0 1 0 0) " stroke-linecap="round" />
                </g>
              </g>
            </svg>
          </span>
        </h5>

        <p v-if="lastMessageInChat" class="conversation--message">
          <i v-if="isMessagePrivate" class="ion-locked last-message-icon" />
          <i v-else-if="messageByAgent" class="ion-ios-undo last-message-icon" />
          <i
            v-else-if="isMessageAnActivity"
            class="ion-information-circled last-message-icon"
          />
          <span v-if="lastMessageInChat.content">
            {{ parsedLastMessage }}
          </span>
          <span v-else-if="lastMessageInChat.attachments">
            <i :class="`small-icon ${this.$t(`${attachmentIconKey}.ICON`)}`"></i>
            {{ this.$t(`${attachmentIconKey}.CONTENT`) }}
          </span>
          <span v-else>
            {{ $t('CHAT_LIST.NO_CONTENT') }}
          </span>
        </p>
        <p v-else class="conversation--message">
          <i class="ion-android-alert"></i>
          <span>
            {{ this.$t(`CHAT_LIST.NO_MESSAGES`) }}
          </span>
        </p>
        <div class="conversation--meta">
          <span class="timestamp">
            {{ dynamicTime(chat.timestamp) }}
          </span>
          <span class="unread">{{ unreadCount > 9 ? '9+' : unreadCount }}</span>
        </div>
      </div>
    </div>
  </div>
  <div
    class="conversation"
    :class="{
      active: isActiveChat,
      'unread-chat': hasUnread,
      'has-inbox-name': showInboxName,
    }"
    @click="cardClick(chat)" v-else
  >
    <thumbnail
      v-if="!hideThumbnail"
      :src="currentContact.thumbnail"
      :badge="inboxBadge"
      class="columns"
      :username="currentContact.name"
      :status="currentContact.availability_status"
      size="40px"
    />
    <div class="conversation--details columns">
      <div class="conversation--metadata">
        <inbox-name v-if="showInboxName" :inbox="inbox" />
        <span
          v-if="showAssignee && assignee.name"
          class="label assignee-label text-truncate"
        >
          <i class="ion-person" />
          {{ assignee.name }}
        </span>
      </div>
      <h4 class="conversation--user">
        {{ aditionalAttributeConversation }}
      </h4>
      <h5 class="conversation--user conversation--user--with-pin">
        {{ currentContact.name }}
      </h5>

      <p v-if="lastMessageInChat" class="conversation--message">
        <i v-if="isMessagePrivate" class="ion-locked last-message-icon" />
        <i v-else-if="messageByAgent" class="ion-ios-undo last-message-icon" />
        <i
          v-else-if="isMessageAnActivity"
          class="ion-information-circled last-message-icon"
        />
        <span v-if="lastMessageInChat.content">
          {{ parsedLastMessage }}
        </span>
        <span v-else-if="lastMessageInChat.attachments">
          <i :class="`small-icon ${this.$t(`${attachmentIconKey}.ICON`)}`"></i>
          {{ this.$t(`${attachmentIconKey}.CONTENT`) }}
        </span>
        <span v-else>
          {{ $t('CHAT_LIST.NO_CONTENT') }}
        </span>
      </p>
      <p v-else class="conversation--message">
        <i class="ion-android-alert"></i>
        <span>
          {{ this.$t(`CHAT_LIST.NO_MESSAGES`) }}
        </span>
      </p>
      <div class="conversation--meta">
        <span class="timestamp">
          {{ dynamicTime(chat.timestamp) }}
        </span>
        <span class="unread">{{ unreadCount > 9 ? '9+' : unreadCount }}</span>
      </div>
    </div>
  </div>
</template>
<script>
import { mapGetters } from 'vuex';
import { MESSAGE_TYPE } from 'widget/helpers/constants';
import messageFormatterMixin from 'shared/mixins/messageFormatterMixin';
import Thumbnail from '../Thumbnail';
import conversationMixin from '../../../mixins/conversations';
import timeMixin from '../../../mixins/time';
import router from '../../../routes';
import { frontendURL, conversationUrl } from '../../../helper/URLHelper';
import InboxName from '../InboxName';
import inboxMixin from 'shared/mixins/inboxMixin';
import ConversationAPI from '../../../api/conversations'

export default {
  components: {
    InboxName,
    Thumbnail,
  },

  mixins: [inboxMixin, timeMixin, conversationMixin, messageFormatterMixin],
  props: {
    activeLabel: {
      type: String,
      default: '',
    },
    chat: {
      type: Object,
      default: () => {},
    },
    hideInboxName: {
      type: Boolean,
      default: false,
    },
    hideThumbnail: {
      type: Boolean,
      default: false,
    },
    teamId: {
      type: [String, Number],
      default: 0,
    },
    showAssignee: {
      type: Boolean,
      default: false,
    },
    isPinned: {
      type: Boolean,
      default: false,
      require: false
    },
    isMine: {
      type: Boolean,
      default: false,
    },
  },

  computed: {
    ...mapGetters({
      currentChat: 'getSelectedChat',
      inboxesList: 'inboxes/getInboxes',
      activeInbox: 'getSelectedInbox',
      currentUser: 'getCurrentUser',
      accountId: 'getCurrentAccountId',
    }),

    chatMetadata() {
      return this.chat.meta || {};
    },

    assignee() {
      return this.chatMetadata.assignee || {};
    },

    currentContact() {
      return this.$store.getters['contacts/getContact'](
        this.chatMetadata.sender.id
      );
    },

    attachmentIconKey() {
      const lastMessage = this.lastMessageInChat;
      const [{ file_type: fileType } = {}] = lastMessage.attachments;
      return `CHAT_LIST.ATTACHMENTS.${fileType}`;
    },

    isActiveChat() {
      return this.currentChat.id === this.chat.id;
    },

    unreadCount() {
      return this.unreadMessagesCount(this.chat);
    },

    hasUnread() {
      return this.unreadCount > 0;
    },

    isInboxNameVisible() {
      return !this.activeInbox;
    },

    lastMessageInChat() {
      return this.lastMessage(this.chat);
    },

    messageByAgent() {
      const lastMessage = this.lastMessageInChat;
      const { message_type: messageType } = lastMessage;
      return messageType === MESSAGE_TYPE.OUTGOING;
    },

    isMessageAnActivity() {
      const lastMessage = this.lastMessageInChat;
      const { message_type: messageType } = lastMessage;
      return messageType === MESSAGE_TYPE.ACTIVITY;
    },

    isMessagePrivate() {
      const lastMessage = this.lastMessageInChat;
      const { private: isPrivate } = lastMessage;
      return isPrivate;
    },

    parsedLastMessage() {
      const { content_attributes: contentAttributes } = this.lastMessageInChat;
      const { email: { subject } = {} } = contentAttributes || {};
      return this.getPlainText(subject || this.lastMessageInChat.content);
    },

    inbox() {
      const { inbox_id: inboxId } = this.chat;
      const stateInbox = this.$store.getters['inboxes/getInbox'](inboxId);
      return stateInbox;
    },

    showInboxName() {
      return (
        !this.hideInboxName &&
        this.isInboxNameVisible &&
        this.inboxesList.length > 1
      );
    },
    inboxName() {
      const stateInbox = this.inbox;
      return stateInbox.name || '';
    },
    aditionalAttributeConversation() {
      return this.chat.additional_attributes.asunto
    },
  },
  methods: {
    cardClick(chat) {
      const { activeInbox } = this;
      const path = conversationUrl({
        accountId: this.accountId,
        activeInbox,
        id: chat.id,
        label: this.activeLabel,
        teamId: this.teamId,
      });
      router.push({ path: frontendURL(path) });
    },
    pinConverstation (event, converstationId) {
      console.log('pincmnt')
      event.stopImmediatePropagation()
      console.log(ConversationAPI, 'apicall')
      ConversationAPI.pinConverstation(converstationId).then((res)=> {
        //alert('conversation pinned successfully')
        this.$router.push(this.$router.currentRoute)
      }).catch((err)=> {
        console.log(err)
      });

    },
    unpinConverstation (event, converstationId) {
      event.stopImmediatePropagation()
      ConversationAPI.unpinConverstation(converstationId).then((res)=> {
        //alert('conversation unpin successfully')
        this.$router.push(this.$router.currentRoute)
      }).catch((err)=> {
        console.log(err)
      });

    },
  },
};
</script>
<style lang="scss" scoped>
.conversation {
  align-items: center;

  &:hover {
    background: var(--color-background-light);
  }
}

.has-inbox-name {
  &::v-deep .user-thumbnail-box {
    margin-top: var(--space-normal);
    align-items: flex-start;
  }
  .conversation--meta {
    margin-top: var(--space-normal);
  }
}

.conversation--details {
  .conversation--user {
    padding-top: var(--space-micro);
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
    width: 60%;
  }
  .ion-earth {
    font-size: var(--font-size-mini);
  }
}

.last-message-icon {
  color: var(--s-600);
  font-size: var(--font-size-mini);
}

.conversation--metadata {
  display: flex;
  justify-content: space-between;
  padding-right: var(--space-normal);

  .label {
    padding: var(--space-micro) 0 var(--space-micro) 0;
    line-height: var(--space-slab);
    font-weight: var(--font-weight-medium);
    background: none;
    color: var(--s-500);
    font-size: var(--font-size-mini);
  }

  .assignee-label {
    max-width: 50%;
  }
}

.pin-chat {
  margin-left:5px;
}

.pin-chat svg {
  width: 15px;
  height: 15px;
}

.conversation--user--with-pin{
  display:flex;
  flex-direction:row;
}
</style>
