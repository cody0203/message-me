import consumer from "./consumer";

consumer.subscriptions.create("AppearanceChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const { users } = data;
    users.map((user) => {
      const { id, online, username } = user || {};
      const currentItem = $(`#user-item[data-user-id="${id}"]`);
      const item = `<p class="item" id="user-item" data-user-id="${id}">
                        ${username}
                    </p>`;
      const onlineFlag = `<a class="ui mini green empty circular label" id="online-flag" />`;
      const currentOnlineFlag = $(
        `#user-item[data-user-id="${id}"] > a#online-flag`
      );

      if (!online && currentItem.length < 1) {
        $("#user-container").append(item);
      }

      if (online && currentItem.length < 1) {
        $("#user-container").append($(item).append(onlineFlag));
      }

      if (online && currentItem.length > 0 && currentOnlineFlag.length < 1) {
        $(currentItem).append(onlineFlag);
      }

      if (!online) {
        $(currentOnlineFlag).remove();
      }
    });
  },
});
