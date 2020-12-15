From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 15 Dec 2020 02:00:08 +0000
Subject: [Intel-wired-lan] [PATCH v2 net-next] ice,
 xsk: Move Rx allocation out of while-loop
In-Reply-To: <20201211085410.59350-1-bjorn.topel@gmail.com>
References: <20201211085410.59350-1-bjorn.topel@gmail.com>
Message-ID: <160799760821.15807.11906942397903153665.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (refs/heads/master):

On Fri, 11 Dec 2020 09:54:10 +0100 you wrote:
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> Instead doing the check for allocation in each loop, move it outside
> the while loop and do it every NAPI loop.
> 
> This change boosts the xdpsock rxdrop scenario with 15% more
> packets-per-second.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] ice, xsk: Move Rx allocation out of while-loop
    https://git.kernel.org/netdev/net-next/c/5bb0c4b5eb61

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


