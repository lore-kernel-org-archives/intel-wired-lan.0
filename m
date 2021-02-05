From: patchwork-bot+netdevbpf@kernel.org <patchwork-bot+netdevbpf@kernel.org>
Date: Fri, 05 Feb 2021 02:40:07 +0000
Subject: [Intel-wired-lan] [PATCH RESEND v3 net-next 0/5] net:
 consolidate page_is_pfmemalloc() usage
In-Reply-To: <20210202133030.5760-1-alobakin@pm.me>
References: <20210202133030.5760-1-alobakin@pm.me>
Message-ID: <161249280746.9463.15568343687164067943.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello:

This series was applied to netdev/net-next.git (refs/heads/master):

On Tue, 02 Feb 2021 13:30:43 +0000 you wrote:
> page_is_pfmemalloc() is used mostly by networking drivers to test
> if a page can be considered for reusing/recycling.
> It doesn't write anything to the struct page itself, so its sole
> argument can be constified, as well as the first argument of
> skb_propagate_pfmemalloc().
> In Page Pool core code, it can be simply inlined instead.
> Most of the callers from NIC drivers were just doppelgangers of
> the same condition tests. Derive them into a new common function
> do deduplicate the code.
> 
> [...]

Here is the summary with links:
  - [RESEND,v3,net-next,1/5] mm: constify page_is_pfmemalloc() argument
    https://git.kernel.org/netdev/net-next/c/1d7bab6a9445
  - [RESEND,v3,net-next,2/5] skbuff: constify skb_propagate_pfmemalloc() "page" argument
    https://git.kernel.org/netdev/net-next/c/48f971c9c80a
  - [RESEND,v3,net-next,3/5] net: introduce common dev_page_is_reusable()
    https://git.kernel.org/netdev/net-next/c/bc38f30f8dbc
  - [RESEND,v3,net-next,4/5] net: use the new dev_page_is_reusable() instead of private versions
    https://git.kernel.org/netdev/net-next/c/a79afa78e625
  - [RESEND,v3,net-next,5/5] net: page_pool: simplify page recycling condition tests
    https://git.kernel.org/netdev/net-next/c/05656132a874

You are awesome, thank you!
--
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


