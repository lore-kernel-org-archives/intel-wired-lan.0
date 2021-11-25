From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 25 Nov 2021 15:50:09 +0000
Subject: [Intel-wired-lan] [PATCH net v2] igb: fix netpoll exit with
 traffic
In-Reply-To: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
References: <20211123204000.1597971-1-jesse.brandeburg@intel.com>
Message-ID: <163785540977.3411.335611194750877222.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Nov 2021 12:40:00 -0800 you wrote:
> Oleksandr brought a bug report where netpoll causes trace
> messages in the log on igb.
> 
> Danielle brought this back up as still occuring, so we'll try
> again.
> 
> [22038.710800] ------------[ cut here ]------------
> [22038.710801] igb_poll+0x0/0x1440 [igb] exceeded budget in poll
> [22038.710802] WARNING: CPU: 12 PID: 40362 at net/core/netpoll.c:155 netpoll_poll_dev+0x18a/0x1a0
> 
> [...]

Here is the summary with links:
  - [net,v2] igb: fix netpoll exit with traffic
    https://git.kernel.org/netdev/net/c/eaeace60778e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


