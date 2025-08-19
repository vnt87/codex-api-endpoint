<div align="center">
  <h1>ChatMock</h1>
  <p><b>OpenAI & Ollama compatible API powered by your ChatGPT plan.</b></p>
  <p>Use your ChatGPT Plus/Pro account to call OpenAI models from code or alternate chat UIs.</p>
  <br>
</div>

## What It Does

ChatMock runs a local server that creates an OpenAI/Ollama compatible API, and requests are then fulfilled using your authenticated ChatGPT login with the oauth client of Codex, OpenAI's coding CLI tool. This allows you to use GPT-5 and other models right through your OpenAI account, without requiring an api key.
This does require a paid ChatGPT account.

## Quickstart

### Mac Users
If you use MacOS, you can use the GUI application in the Github releases. Unfortunately, due to not being part of the paid apple developer program, you will have to click "Open anyway" in security after trying to right click and open the app. If that doesn't work you will have to type this command in the terminal on Mac to ensure you can run the application: <br>
`xattr -dr com.apple.quarantine /Applications/ChatMock.app`<br>
*See more info [here](https://github.com/deskflow/deskflow/wiki/Running-on-macOS)*

### Windows Users
Simply download and run the app in the releases. As I do not own a windows computer I cannot fully bug test this, so please do report bugs in issues.

### Python
If you wish to just simply run this as a python flask server, you are also freely welcome too.

Clone or download this repository, then cd into the project directory. Then follow the instrunctions listed below.

1. Sign in with your ChatGPT account and follow the prompts
```bash
python chatmock.py login
```
You can make sure this worked by running `python chatmock.py info`

2. After the login completes successfully, you can just simply start the local server

```bash
python chatmock.py serve
```
Then, you can simply use the address and port as the baseURL as you require (http://127.0.0.1:8000 by default)

**Reminder:** When setting a baseURL, make you sure you include /v1/ at the end of the URL if you're using this as a OpenAI compatible endpoint (e.g http://127.0.0.1:8000/v1)

# Examples

### Python 

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://127.0.0.1:8000/v1",
    api_key="key"  # ignored
)

resp = client.chat.completions.create(
    model="gpt-5",
    messages=[{"role": "user", "content": "hello world"}]
)

print(resp.choices[0].message.content)
```

### curl

```bash
curl http://127.0.0.1:8000/v1/chat/completions \
  -H "Authorization: Bearer key" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-5",
    "messages": [{"role":"user","content":"hello world"}]
  }'
```

# What's supported

- Tool calling
- Vision/Image understanding
- Thinking summaries (through thinking tags)

## Notes & Limits

- Requires an active, paid ChatGPT account.
- Expect lower rate limits than what you may recieve in the ChatGPT app.
- Instrunctions in the system prompt (prompt.md) cannot be modified
- Use responsibly and at your own risk. This project is not affiliated with OpenAI, and is a educational exercise.

# Supported models
- `gpt-5`
- `codex-mini`

# Customisation / Configuration

### Thinking effort

- `--reasoning-effort` (choice of low,medium,high)<br>
GPT-5 has a configurable amount of "effort" it can put into thinking, which may cause it to take more time for a response to return, but may overall give a smarter answer. Applying this parameter after `serve` forces the server to use this reasoning effort by default, unless overrided by the API request with a different effort set. The default reasoning effort without setting this parameter is `medium`.

### Thinking summaries

- `--reasoning-summary` (choice of auto,concise,detailed,none)<br>
Models like GPT-5 do not return raw thinking content, but instead return thinking summaries. These can also be customised by you.

## Notes
If you wish to have the fastest responses, I'd recommend setting `--reasoning-effort` to low, and `--reasoning-summary` to none.
All parameters and choices can be seen by sending `python chatmock.py serve --h`<br>
The context size of this route is also larger than what you get access to in the regular ChatGPT app.

**When the model returns a thinking summary, the model will send back thinking tags to make it compatible with chat apps. If you don't like this behavior, you can instead set `--reasoning-compat` to legacy, and reasoning will be set in the reasoning tag instead of being returned in the actual response text.**

# TODO
- ~~Implement Ollama support~~ ✅
- Explore to see if we can make more model settings accessible
- Implement analytics (token counting, etc, to track usage)

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=RayBytes/ChatMock&type=Timeline)](https://www.star-history.com/#RayBytes/ChatMock&Timeline)

