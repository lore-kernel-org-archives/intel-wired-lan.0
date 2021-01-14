From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Thu, 14 Jan 2021 03:40:08 +0000
Subject: [Intel-wired-lan] [PATCH net] i40e: fix potential NULL pointer
 dereferencing
In-Reply-To: <20210111181138.49757-1-cristian.dumitrescu@intel.com>
References: <20210111181138.49757-1-cristian.dumitrescu@intel.com>
Message-ID: <161059560818.8885.13113581154759603172.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This patch was applied to netdev/net.git (refs/heads/master):

On Mon, 11 Jan 2021 18:11:38 +0000 you wrote:
> Currently, the function i40e_construct_skb_zc only frees the input xdp
> buffer when the output skb is successfully built. On error, the
> function i40e_clean_rx_irq_zc does not commit anything for the current
> packet descriptor and simply exits the packet descriptor processing
> loop, with the plan to restart the processing of this descriptor on
> the next invocation. Therefore, on error the ring next-to-clean
> pointer should not advance, the xdp i.e. *bi buffer should not be
> freed and the current buffer info should not be invalidated by setting
> *bi to NULL. Therefore, the *bi should only be set to NULL when the
> function i40e_construct_skb_zc is successful, otherwise a NULL *bi
> will be dereferenced when the work for the current descriptor is
> eventually restarted.
> 
> [...]

Here is the summary with links:
  - [net] i40e: fix potential NULL pointer dereferencing
    https://git.kernel.org/netdev/net/c/7128c834d30e

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


