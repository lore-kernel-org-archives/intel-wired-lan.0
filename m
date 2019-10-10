From: Josh Hunt <johunt@akamai.com>
Date: Wed, 9 Oct 2019 18:06:45 -0700
Subject: [Intel-wired-lan] [PATCH 2/3] ixgbe: Add UDP segmentation
 offload support
In-Reply-To: <1570658777-13459-3-git-send-email-johunt@akamai.com>
References: <1570658777-13459-1-git-send-email-johunt@akamai.com>
 <1570658777-13459-3-git-send-email-johunt@akamai.com>
Message-ID: <22506786-c429-df87-54cb-c1c83b1b445b@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 10/9/19 3:06 PM, Josh Hunt wrote:
> Repost from a series by Alexander Duyck to add UDP segmentation offload
> support to the igb driver:
> https://lore.kernel.org/netdev/20180504003916.4769.66271.stgit at localhost.localdomain/
> 
> CC: Alexander Duyck <alexander.h.duyck@intel.com>
> CC: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Josh Hunt <johunt@akamai.com>
> ---
>   drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 24 +++++++++++++++++++-----
>   1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> index 1ce2397306b9..2b01d264e5ce 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
> @@ -7946,6 +7946,7 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>   	} ip;
>   	union {
>   		struct tcphdr *tcp;
> +		struct udphdr *udp;
>   		unsigned char *hdr;
>   	} l4;
>   	u32 paylen, l4_offset;
> @@ -7969,6 +7970,9 @@ static int ixgbe_tso(struct ixgbe_ring *tx_ring,
>   	l4.hdr = skb_checksum_start(skb);
>   
>   	/* ADV DTYP TUCMD MKRLOC/ISCSIHEDLEN */
> +	type_tucmd = (skb->csum_offset == offsetof(struct tcphdr, check)) ?
> +		      IXGBE_ADVTXD_TUCMD_L4T_TCP : IXGBE_ADVTXD_TUCMD_L4T_UDP;
> +
>   	type_tucmd = IXGBE_ADVTXD_TUCMD_L4T_TCP;

Copy/paste bug ^^. Will fix in v2.

Josh
