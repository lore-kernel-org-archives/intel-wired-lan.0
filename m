From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat, 16 May 2015 03:57:04 -0700
Subject: [Intel-wired-lan] [net PATCH 1/2] i40e/i40evf: Fix mixed size
 frags and linearization
In-Reply-To: <20150508223552.26673.5631.stgit@jbrandeb-cp2.jf.intel.com>
References: <20150508223552.26673.5631.stgit@jbrandeb-cp2.jf.intel.com>
Message-ID: <1431773824.32618.77.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-05-08 at 15:35 -0700, Jesse Brandeburg wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> This patch fixes a bug where the i40e tx queue will hang if this
> skb is passed to the driver.
> 
> With mixed size fragments while using TSO there was a corner case
> where we needed to linearize but we were not. This was seen with
> iSCSI traffic and could be reproduced with a frag list that looks
> like this:
> 
> num_frags = 17, gso_segs = 17, hdr_len = 66,
> skb_shinfo(skb)->gso_size = 1448
> size = 3002, j = 1, frag_size = 2936, num_frags = 17
> size = 4268, j = 1, frag_size = 4096, num_frags = 16
> size = 5534, j = 1, frag_size = 4096, num_frags = 15
> size = 5352, j = 1, frag_size = 4096, num_frags = 14
> size = 5170, j = 1, frag_size = 4096, num_frags = 13
> size = 3468, j = 1, frag_size = 2576, num_frags = 12
> size = 750, j = 1, frag_size = 112, num_frags = 11
> size = 862, j = 2, frag_size = 112, num_frags = 10
> size = 974, j = 3, frag_size = 112, num_frags = 9
> size = 1126, j = 4, frag_size = 152, num_frags = 8
> size = 1330, j = 5, frag_size = 204, num_frags = 7
> size = 1534, j = 6, frag_size = 204, num_frags = 6
> size = 356, j = 1, frag_size = 204, num_frags = 5
> size = 560, j = 2, frag_size = 204, num_frags = 4
> size = 764, j = 3, frag_size = 204, num_frags = 3
> size = 968, j = 4, frag_size = 204, num_frags = 2
> size = 1140, j = 5, frag_size = 172, num_frags = 1
> result: linearize = 0, j = 6
> 
> Change-ID: I79bb1aeab0af255fe2ce28e93672a85d85bf47e8
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |   25
> ++++++++++---------------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |   25
> ++++++++++---------------
>  2 files changed, 20 insertions(+), 30 deletions(-)

Applied to my net-queue tree
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150516/49bd464b/attachment.asc>
