From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Sun, 19 Sep 2021 11:30:06 +0000
Subject: [Intel-wired-lan] [PATCH -net] igc: fix build errors for PTP
In-Reply-To: <20210917210547.12578-1-rdunlap@infradead.org>
References: <20210917210547.12578-1-rdunlap@infradead.org>
Message-ID: <163205100656.18169.172670291108556041.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Fri, 17 Sep 2021 14:05:47 -0700 you wrote:
> When IGC=y and PTP_1588_CLOCK=m, the ptp_*() interface family is
> not available to the igc driver. Make this driver depend on
> PTP_1588_CLOCK_OPTIONAL so that it will build without errors.
> 
> Various igc commits have used ptp_*() functions without checking
> that PTP_1588_CLOCK is enabled. Fix all of these here.
> 
> [...]

Here is the summary with links:
  - [-net] igc: fix build errors for PTP
    https://git.kernel.org/netdev/net/c/87758511075e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


