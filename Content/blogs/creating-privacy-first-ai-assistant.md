---
title: Creating a Privacy-First AI Assistant
date: 2025-07-27 12:00 
tags: AI, LLM, Privacy, Automation
description: Learn how I created a privacy-first AI assistant using Open WebUI, TailScale, and CloudFlare.

---

#### Introduction

As I increasingly rely on Large Language Models (LLMs) in my daily life, I've become concerned about privacy. I want to integrate LLMs with my automation system and access private data, but I need to ensure my data remains secure. To achieve this, I've set up a privacy-first AI assistant using various tools and technologies.

#### The Journey Begins

I started by experimenting with LLMs using Ollama, but soon switched to the MLX framework due to its better performance on my hardware. However, I eventually moved to LMStudio to easily test different models. My goal was to run LLMs locally and access them from my phone, watch, or other devices.

#### Finding the Right Tools

After searching for open-source SwiftUI solutions, I found that most results were not promising. Instead, I discovered Open WebUI, a web-based solution that supports API, MCP, functions, knowledge datasets, and more. I decided to deploy Open WebUI on my cloud server, which is the heart of my automation system.

#### Connecting to My Mac

The challenge was getting Open WebUI to access my Mac. I had previously used Wireguard, but switched to TailScale for its simplicity and additional features. With TailScale, I could connect my devices and access my server without custom DNS entries.

#### Overcoming Connection Issues

After deploying Open WebUI, I added my Mac using TailScale's domain. However, I encountered connection issues due to the Open WebUI container not being part of the TailScale network. Despite searching for solutions, I couldn't find a straightforward answer.

#### CloudFlare to the Rescue

I visit to CloudFlare, which I'm already using to serve my blog and restrict access to my cloud servers. I created a CloudFlare tunnel, allowing only my cloud server's IP to access the AI models. This solved the connection issue and allowed Open WebUI to access my Mac.

#### The Result

Everything works as expected! I can now easily connect to my Mac using Open WebUI and access various AI models, including those from CloudFlare. This is just the beginning of my AI journey, and I'm excited to learn more and share my experiences.

#### Conclusion

My goal is to understand how AI works and create my own solutions. I'm currently learning about MCP servers and building my own internal automation service using Open WebUI. If you're interested in following my journey, feel free to reach out via the contact form on my website: https://yusufozgul.com/contact/.
