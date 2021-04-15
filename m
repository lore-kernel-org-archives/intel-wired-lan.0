From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 15 Apr 2021 21:40:09 +0000
Subject: [Intel-wired-lan] [PATCH net v3] i40e: fix the panic when
 running bpf in xdpdrv mode
In-Reply-To: <20210414023428.10121-1-kerneljasonxing@gmail.com>
References: <20210414023428.10121-1-kerneljasonxing@gmail.com>
Message-ID: <161852280945.6246.15751888474800396126.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Wed, 14 Apr 2021 10:34:28 +0800 you wrote:
> From: Jason Xing <xingwanli@kuaishou.com>
> 
> Fix this panic by adding more rules to calculate the value of @rss_size_max
> which could be used in allocating the queues when bpf is loaded, which,
> however, could cause the failure and then trigger the NULL pointer of
> vsi->rx_rings. Prio to this fix, the machine doesn't care about how many
> cpus are online and then allocates 256 queues on the machine with 32 cpus
> online actually.
> 
> [...]

Here is the summary with links:
  - [net,v3] i40e: fix the panic when running bpf in xdpdrv mode
    https://git.kernel.org/netdev/net/c/4e39a072a6a0

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


