From: Daniel Borkmann <daniel@iogearbox.net>
Date: Mon, 28 Jun 2021 16:33:10 +0200
Subject: [Intel-wired-lan] [PATCH net v3] xdp,
 net: fix for construct skb by xdp inside xsk zc rx
In-Reply-To: <20210628114647.75449-1-xuanzhuo@linux.alibaba.com>
References: <20210628114647.75449-1-xuanzhuo@linux.alibaba.com>
Message-ID: <0a1614c4-19b7-2665-8eb9-7df776fa4c13@iogearbox.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Xuan,

On 6/28/21 1:46 PM, Xuan Zhuo wrote:
> When each driver supports xsk rx, if the received buff returns XDP_PASS
> after run xdp prog, it must construct skb based on xdp. This patch
> extracts this logic into a public function xdp_construct_skb().
> 
> There is a bug in the original logic. When constructing skb, we should
> copy the meta information to skb and then use __skb_pull() to correct
> the data.
> 
> Fixes: 0a714186d3c0f ("i40e: add AF_XDP zero-copy Rx support")
> Fixes: 2d4238f556972 ("ice: Add support for AF_XDP")
> Fixes: bba2556efad66 ("net: stmmac: Enable RX via AF_XDP zero-copy")
> Fixes: d0bcacd0a1309 ("ixgbe: add AF_XDP zero-copy Rx support")
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>

There was still an ongoing discussion on the v2 of your patch between
Maciej and Maxim (Cc). Before you submit a v3, please let the discussion
conclude first.

Thanks,
Daniel
