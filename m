From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Mon, 09 Aug 2021 09:30:05 +0000
Subject: [Intel-wired-lan] [PATCH net-next] devlink: Set device as early
 as possible
In-Reply-To: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
References: <6859503f7e3e6cd706bf01ef06f1cae8c0b0970b.1628449004.git.leonro@nvidia.com>
Message-ID: <162850140527.16932.1083737685938240617.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Sun,  8 Aug 2021 21:57:43 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> All kernel devlink implementations call to devlink_alloc() during
> initialization routine for specific device which is used later as
> a parent device for devlink_register().
> 
> Such late device assignment causes to the situation which requires us to
> call to device_register() before setting other parameters, but that call
> opens devlink to the world and makes accessible for the netlink users.
> 
> [...]

Here is the summary with links:
  - [net-next] devlink: Set device as early as possible
    https://git.kernel.org/netdev/net-next/c/919d13a7e455

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


