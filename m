From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Fri, 15 Oct 2021 02:30:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next] net: intel: igc_ptp: fix
 build for UML
In-Reply-To: <20211014050516.6846-1-rdunlap@infradead.org>
References: <20211014050516.6846-1-rdunlap@infradead.org>
Message-ID: <163426500834.31820.14758482906938638216.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Oct 2021 22:05:16 -0700 you wrote:
> On a UML build, the igc_ptp driver uses CONFIG_X86_TSC for timestamp
> conversion. The function that is used is not available on UML builds,
> so have the function use the default system_counterval_t timestamp
> instead for UML builds.
> 
> Prevents this build error on UML:
> 
> [...]

Here is the summary with links:
  - [net-next] net: intel: igc_ptp: fix build for UML
    https://git.kernel.org/netdev/net-next/c/523994ba3ad1

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


