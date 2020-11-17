From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Tue, 17 Nov 2020 21:20:06 +0000
Subject: [Intel-wired-lan] [PATCH bpf-next v3 0/5] xsk: i40e: Tx
 performance improvements
In-Reply-To: <1605525167-14450-1-git-send-email-magnus.karlsson@gmail.com>
References: <1605525167-14450-1-git-send-email-magnus.karlsson@gmail.com>
Message-ID: <160564800642.24253.1580711036123652762.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to bpf/bpf-next.git (refs/heads/master):

On Mon, 16 Nov 2020 12:12:42 +0100 you wrote:
> This patch set improves the performance of mainly the Tx processing of
> AF_XDP sockets. Though, patch 3 also improves the Rx path. All in all,
> this patch set improves the throughput of the l2fwd xdpsock
> application by around 11%. If we just take a look at Tx processing part,
> it is improved by 35% to 40%.
> 
> Hopefully the new batched Tx interfaces should be of value to other
> drivers implementing AF_XDP zero-copy support. But patch #3 is generic
> and will improve performance of all drivers when using AF_XDP sockets
> (under the premises explained in that patch).
> 
> [...]

Here is the summary with links:
  - [bpf-next,v3,1/5] samples/bpf: increment Tx stats at sending
    https://git.kernel.org/bpf/bpf-next/c/90da4b3208d3
  - [bpf-next,v3,2/5] i40e: remove unnecessary sw_ring access from xsk Tx
    https://git.kernel.org/bpf/bpf-next/c/f320460b9489
  - [bpf-next,v3,3/5] xsk: introduce padding between more ring pointers
    https://git.kernel.org/bpf/bpf-next/c/b8c7aece29bc
  - [bpf-next,v3,4/5] xsk: introduce batched Tx descriptor interfaces
    https://git.kernel.org/bpf/bpf-next/c/9349eb3a9d2a
  - [bpf-next,v3,5/5] i40e: use batched xsk Tx interfaces to increase performance
    https://git.kernel.org/bpf/bpf-next/c/3106c580fb7c

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


