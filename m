From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 17 Mar 2022 17:30:10 +0000
Subject: [Intel-wired-lan] [PATCH] iavf: Fix hang during reboot/shutdown
In-Reply-To: <20220317104524.2802848-1-ivecera@redhat.com>
References: <20220317104524.2802848-1-ivecera@redhat.com>
Message-ID: <164753821041.18148.18371834724218825935.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Mar 2022 11:45:24 +0100 you wrote:
> Recent commit 974578017fc1 ("iavf: Add waiting so the port is
> initialized in remove") adds a wait-loop at the beginning of
> iavf_remove() to ensure that port initialization is finished
> prior unregistering net device. This causes a regression
> in reboot/shutdown scenario because in this case callback
> iavf_shutdown() is called and this callback detaches the device,
> makes it down if it is running and sets its state to __IAVF_REMOVE.
> Later shutdown callback of associated PF driver (e.g. ice_shutdown)
> is called. That callback calls among other things sriov_disable()
> that calls indirectly iavf_remove() (see stack trace below).
> As the adapter state is already __IAVF_REMOVE then the mentioned
> loop is end-less and shutdown process hangs.
> 
> [...]

Here is the summary with links:
  - iavf: Fix hang during reboot/shutdown
    https://git.kernel.org/netdev/net/c/b04683ff8f08

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


