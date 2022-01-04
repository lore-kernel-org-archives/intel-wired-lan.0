From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 04 Jan 2022 12:40:11 +0000
Subject: [Intel-wired-lan] [PATCH net-next] net: fixup build after bpf
 header changes
In-Reply-To: <20220104034827.1564167-1-kuba@kernel.org>
References: <20220104034827.1564167-1-kuba@kernel.org>
Message-ID: <164130001127.24992.5502128028484482791.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon,  3 Jan 2022 19:48:27 -0800 you wrote:
> Recent bpf-next merge brought in header changes which uncovered
> includes missing in net-next which were not present in bpf-next.
> Build problems happen only on less-popular arches like hppa,
> sparc, alpha etc.
> 
> I could repro the build problem with ice but not the mlx5 problem
> Abdul was reporting. mlx5 does look like it should include filter.h,
> anyway.
> 
> [...]

Here is the summary with links:
  - [net-next] net: fixup build after bpf header changes
    https://git.kernel.org/netdev/net-next/c/7d714ff14d64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


