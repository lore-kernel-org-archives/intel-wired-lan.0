From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 19 Jan 2021 23:40:09 +0000
Subject: [Intel-wired-lan] [PATCH net-next 0/6] net: support SCTP CRC
 csum offload for tunneling packets in some drivers
In-Reply-To: <cover.1610777159.git.lucien.xin@gmail.com>
References: <cover.1610777159.git.lucien.xin@gmail.com>
Message-ID: <161109960900.4067.12876636834749313206.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Sat, 16 Jan 2021 14:13:36 +0800 you wrote:
> This patchset introduces inline function skb_csum_is_sctp(), and uses it
> to validate it's a sctp CRC csum offload packet, to make SCTP CRC csum
> offload for tunneling packets supported in some HW drivers.
> 
> Xin Long (6):
>   net: add inline function skb_csum_is_sctp
>   net: igb: use skb_csum_is_sctp instead of protocol check
>   net: igbvf: use skb_csum_is_sctp instead of protocol check
>   net: igc: use skb_csum_is_sctp instead of protocol check
>   net: ixgbe: use skb_csum_is_sctp instead of protocol check
>   net: ixgbevf: use skb_csum_is_sctp instead of protocol check
> 
> [...]

Here is the summary with links:
  - [net-next,1/6] net: add inline function skb_csum_is_sctp
    https://git.kernel.org/netdev/net-next/c/fa8211701043
  - [net-next,2/6] net: igb: use skb_csum_is_sctp instead of protocol check
    https://git.kernel.org/netdev/net-next/c/8bcf02035bd5
  - [net-next,3/6] net: igbvf: use skb_csum_is_sctp instead of protocol check
    https://git.kernel.org/netdev/net-next/c/d2de44443caf
  - [net-next,4/6] net: igc: use skb_csum_is_sctp instead of protocol check
    https://git.kernel.org/netdev/net-next/c/609d29a9d242
  - [net-next,5/6] net: ixgbe: use skb_csum_is_sctp instead of protocol check
    https://git.kernel.org/netdev/net-next/c/f8c4b01d3a68
  - [net-next,6/6] net: ixgbevf: use skb_csum_is_sctp instead of protocol check
    https://git.kernel.org/netdev/net-next/c/fc186d0a4ef8

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


