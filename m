From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 19 Oct 2021 11:50:10 +0000
Subject: [Intel-wired-lan] [PATCH linux-next] e1000e: Remove redundant
 statement
In-Reply-To: <20211018085154.853744-1-luo.penghao@zte.com.cn>
References: <20211018085154.853744-1-luo.penghao@zte.com.cn>
Message-ID: <163464421089.25315.8858510384823584691.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net-next.git (master)
by David S. Miller <davem@davemloft.net>:

On Mon, 18 Oct 2021 08:51:54 +0000 you wrote:
> This assignment statement is meaningless, because the statement
> will execute to the tag "set_itr_now".
> 
> The clang_analyzer complains as follows:
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:2552:3 warning:
> 
> [...]

Here is the summary with links:
  - [linux-next] e1000e: Remove redundant statement
    https://git.kernel.org/netdev/net-next/c/1bd297988b75

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


