From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Fri, 14 May 2021 22:30:10 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/3] net: use XDP helpers
In-Reply-To: <20210514183954.7129-1-mcroce@linux.microsoft.com>
References: <20210514183954.7129-1-mcroce@linux.microsoft.com>
Message-ID: <162103141048.10202.7043185141593053010.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Fri, 14 May 2021 20:39:51 +0200 you wrote:
> From: Matteo Croce <mcroce@microsoft.com>
> 
> The commit 43b5169d8355 ("net, xdp: Introduce xdp_init_buff utility
> routine") and commit be9df4aff65f ("net, xdp: Introduce xdp_prepare_buff
> utility routine") introduces two useful helpers to populate xdp_buff.
> Use it in drivers which still open codes that routines.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] stmmac: use XDP helpers
    https://git.kernel.org/netdev/net-next/c/d172268f93cf
  - [net-next,2/3] igc: use XDP helpers
    https://git.kernel.org/netdev/net-next/c/082294f294f6
  - [net-next,3/3] vhost_net: use XDP helpers
    https://git.kernel.org/netdev/net-next/c/224bf7db5518

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


