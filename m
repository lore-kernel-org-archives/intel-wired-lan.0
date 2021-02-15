From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Mon, 15 Feb 2021 23:20:09 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix incorrect use of ip6src due
 to copy-paste coding error
In-Reply-To: <20210215161923.83682-1-colin.king@canonical.com>
References: <20210215161923.83682-1-colin.king@canonical.com>
Message-ID: <161343120902.10830.1258291646017278044.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Mon, 15 Feb 2021 16:19:23 +0000 you wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> It appears that the call of ipv6_add_any for the destination address
> is using ip6src instead of ip6dst, this looks like a copy-paste
> coding error. Fix this by replacing ip6src with ip6dst.
> 
> Addresses-Coverity: ("Copy-paste error")
> Fixes: efca91e89b67 ("i40e: Add flow director support for IPv6")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> 
> [...]

Here is the summary with links:
  - i40e: Fix incorrect use of ip6src due to copy-paste coding error
    https://git.kernel.org/netdev/net-next/c/7f76963b692d

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


