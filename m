From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 17 Mar 2021 18:50:09 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 00/10] ethtool: Factor out
 common code related to writing ethtool strings
In-Reply-To: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
References: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
Message-ID: <161600700946.1265.8041343414246655720.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 16 Mar 2021 17:30:26 -0700 you wrote:
> This patch set is meant to be a cleanup and refactoring of common code bits
> from several drivers. Specificlly a number of drivers engage in a pattern
> where they will use some variant on an sprintf or memcpy to write a string
> into the ethtool string array and then they will increment their pointer by
> ETH_GSTRING_LEN.
> 
> Instead of having each driver implement this independently I am refactoring
> the code so that we have one central function, ethtool_sprintf that does
> all this and takes a double pointer to access the data, a formatted string
> to print, and the variable arguments that are associated with the string.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/10] ethtool: Add common function for filling out strings
    https://git.kernel.org/netdev/net-next/c/7888fe53b706
  - [net-next,v2,02/10] intel: Update drivers to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/c8d4725e985d
  - [net-next,v2,03/10] nfp: Replace nfp_pr_et with ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/6a143a7cf947
  - [net-next,v2,04/10] hisilicon: Update drivers to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/83cd23974a73
  - [net-next,v2,05/10] ena: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/efbbe4fb5976
  - [net-next,v2,06/10] netvsc: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/3ae0ed376d1c
  - [net-next,v2,07/10] virtio_net: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/d7a9a01b4e21
  - [net-next,v2,08/10] vmxnet3: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/3b78b3067f38
  - [net-next,v2,09/10] bna: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/b82e8118c540
  - [net-next,v2,10/10] ionic: Update driver to use ethtool_sprintf
    https://git.kernel.org/netdev/net-next/c/acebe5b6107c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


