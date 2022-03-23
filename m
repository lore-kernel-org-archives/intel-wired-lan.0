From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Wed, 23 Mar 2022 17:50:11 +0000
Subject: [Intel-wired-lan] [PATCH net 0/2] ice: avoid
 sleeping/scheduling in atomic contexts
In-Reply-To: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
References: <20220323124353.2762181-1-alexandr.lobakin@intel.com>
Message-ID: <164805781118.23946.739203139839506306.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net.git (master)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 23 Mar 2022 13:43:51 +0100 you wrote:
> The `ice_misc_intr() + ice_send_event_to_aux()` infamous pair failed
> once again.
> Fix yet another (hopefully last one) 'scheduling while atomic' splat
> and finally plug the hole to gracefully return prematurely when
> invoked in wrong context instead of panicking.
> 
> Alexander Lobakin (2):
>   ice: fix 'scheduling while atomic' on aux critical err interrupt
>   ice: don't allow to run ice_send_event_to_aux() in atomic ctx
> 
> [...]

Here is the summary with links:
  - [net,1/2] ice: fix 'scheduling while atomic' on aux critical err interrupt
    https://git.kernel.org/netdev/net/c/32d53c0aa3a7
  - [net,2/2] ice: don't allow to run ice_send_event_to_aux() in atomic ctx
    https://git.kernel.org/netdev/net/c/5a3156932da0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


