From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Fri, 05 Mar 2021 21:10:09 +0000
Subject: [Intel-wired-lan] [PATCH] net: intel: iavf: fix error return
 code of iavf_init_get_resources()
In-Reply-To: <20210305031010.5396-1-baijiaju1990@gmail.com>
References: <20210305031010.5396-1-baijiaju1990@gmail.com>
Message-ID: <161497860930.24588.6617205222590161114.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Thu,  4 Mar 2021 19:10:10 -0800 you wrote:
> When iavf_process_config() fails, no error return code of
> iavf_init_get_resources() is assigned.
> To fix this bug, err is assigned with the return value of
> iavf_process_config(), and then err is checked.
> 
> Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
> Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
> 
> [...]

Here is the summary with links:
  - net: intel: iavf: fix error return code of iavf_init_get_resources()
    https://git.kernel.org/netdev/net/c/6650d31f21b8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


