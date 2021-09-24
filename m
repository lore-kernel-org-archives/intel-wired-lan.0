From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Fri, 24 Sep 2021 13:20:08 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/6] Batch of devlink related
 fixes
In-Reply-To: <cover.1632420430.git.leonro@nvidia.com>
References: <cover.1632420430.git.leonro@nvidia.com>
Message-ID: <163248960857.28971.5549585387092198522.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Thu, 23 Sep 2021 21:12:47 +0300 you wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Hi,
> 
> I'm asking to apply this batch of devlink fixes to net-next and not to
> net, because most if not all fixes are for old code or/and can be considered
> as cleanup.
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] bnxt_en: Check devlink allocation and registration status
    https://git.kernel.org/netdev/net-next/c/e624c70e1131
  - [net-next,2/6] bnxt_en: Properly remove port parameter support
    https://git.kernel.org/netdev/net-next/c/61415c3db3d9
  - [net-next,3/6] devlink: Delete not used port parameters APIs
    https://git.kernel.org/netdev/net-next/c/42ded61aa75e
  - [net-next,4/6] devlink: Remove single line function obfuscations
    https://git.kernel.org/netdev/net-next/c/8ba024dfaf61
  - [net-next,5/6] ice: Delete always true check of PF pointer
    https://git.kernel.org/netdev/net-next/c/2ff04286a956
  - [net-next,6/6] qed: Don't ignore devlink allocation failures
    https://git.kernel.org/netdev/net-next/c/e6a54d6f2213

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


