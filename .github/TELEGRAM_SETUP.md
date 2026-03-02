# Telegram Notification Setup Guide

This guide will help you set up Telegram notifications for GitHub events (push, pull requests, merges).

## 📱 Step 1: Create a Telegram Bot

1. **Open Telegram** and search for `@BotFather`

2. **Start a chat** with BotFather and send: `/newbot`

3. **Follow the prompts:**
   - Choose a name for your bot (e.g., "LuyPay GitHub Notifier")
   - Choose a username for your bot (must end in 'bot', e.g., "luypay_github_bot")

4. **Save the token** - BotFather will provide a token like:
   ```
   1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
   ```

## 💬 Step 2: Get Your Chat ID

### Option A: Using IDBot (Easiest)

1. Search for `@myidbot` in Telegram
2. Start a chat and send: `/getid`
3. The bot will reply with your chat ID (e.g., `123456789`)

### Option B: Manual Method

1. Send a message to your bot (the one you created)
2. Visit this URL in your browser (replace `YOUR_BOT_TOKEN`):
   ```
   https://api.telegram.org/botYOUR_BOT_TOKEN/getUpdates
   ```
3. Look for `"chat":{"id":123456789}` in the response
4. That number is your Chat ID

### Option C: For Group Notifications

1. Add your bot to a Telegram group
2. Send a message in the group mentioning the bot
3. Visit the getUpdates URL above
4. Look for a negative number like `-987654321` - that's your group Chat ID

## 🔐 Step 3: Add Secrets to GitHub

1. **Go to your GitHub repository:**
   ```
   https://github.com/chhembunheng/luypay-workspace
   ```

2. **Navigate to Settings:**
   - Click `Settings` tab
   - Click `Secrets and variables` → `Actions`

3. **Add the following secrets:**

   **Secret 1: TELEGRAM_BOT_TOKEN**
   - Click `New repository secret`
   - Name: `TELEGRAM_BOT_TOKEN`
   - Value: Your bot token (e.g., `1234567890:ABCdefGHIjklMNOpqrsTUVwxyz`)
   - Click `Add secret`

   **Secret 2: TELEGRAM_CHAT_ID**
   - Click `New repository secret`
   - Name: `TELEGRAM_CHAT_ID`
   - Value: Your chat ID (e.g., `123456789` or `-987654321` for groups)
   - Click `Add secret`

## ✅ Step 4: Test the Setup

1. **Push a commit** to your repository:
   ```bash
   git add .
   git commit -m "test: Telegram notification setup"
   git push origin master
   ```

2. **Check Telegram** - You should receive a notification! 🎉

3. **Create a Pull Request** to test PR notifications

## 🔔 What Notifications You'll Receive

Your bot will send notifications for:

✅ **Push Events:**
- Commit message
- Author
- Branch name
- Commit URL

✅ **Pull Request Events:**
- PR opened
- PR updated/synchronized
- PR merged
- PR closed without merge

✅ **Review Events:**
- PR reviews submitted

## 🎨 Customize Notifications (Optional)

To customize notification messages, edit:
```
.github/workflows/telegram-notify.yml
```

## 🛠️ Troubleshooting

### Bot not sending messages?
- Make sure you've started a chat with your bot (send `/start`)
- Verify the bot token and chat ID are correct
- Check GitHub Actions logs for errors

### Getting "Forbidden: bot was blocked by the user"?
- Unblock the bot in Telegram
- Send `/start` to your bot

### Want to add multiple recipients?
- Create a Telegram group
- Add the bot to the group
- Use the group's Chat ID (negative number)

## 📚 Additional Resources

- [Telegram Bot API Documentation](https://core.telegram.org/bots/api)
- [GitHub Actions Telegram Action](https://github.com/appleboy/telegram-action)

---

**Need help?** Open an issue in the repository!
