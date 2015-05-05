From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Tue, 05 May 2015 09:55:39 -0700
Subject: [Intel-wired-lan] [net-next S4 13/15] i40e/i40evf: force inline
 transmit functions
In-Reply-To: <1429229172-143692-14-git-send-email-catherine.sullivan@intel.com>
References: <1429229172-143692-1-git-send-email-catherine.sullivan@intel.com>
 <1429229172-143692-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <5548F60B.3000209@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 04/16/2015 05:06 PM, Catherine Sullivan wrote:
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
>
> Inlining these functions gives us about 15% more 64 byte packets per
> second when using pktgen. 13.3 million to 15 million with a single
> queue.
>
> Also fix the function names in i40evf to i40evf not i40e while we are
> touching the function header.
>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I3294ae9b085cf438672b6db5f9af122490ead9d0
> ---

The code below is ugly.  If you are going to inline it anyway you might 
as well just move the inline functions to a header file so that they can 
all be static inline.  Also what is the difference in size between the 
before/after with FCoE for this part enabled?  It would be useful to 
have that info in the patch description.  I suspect the change is fairly 
significant since you are doubling the map function which is fairly sizable.

I suspect most of these changes are only showing gains in the FCoE 
case.  Really you guys should look at reachitecting things rather than 
bloating the driver by doubling up the xmit path.  You could probably do 
a quick check against the netdev and then just call some FCoE specific 
offload path before getting back to i40e_tx_map.

Comments inline below.

- Alex

>   drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 32 ++++++++++++------------
>   drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 36 ++++++++++++---------------
>   2 files changed, 32 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index d6ad42b..ca21f9a 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2065,13 +2065,13 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
>    * otherwise  returns 0 to indicate the flags has been set properly.
>    **/
>   #ifdef I40E_FCOE
> -int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
> -			       struct i40e_ring *tx_ring,
> -			       u32 *flags)
> -#else
> -static int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
> +inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
>   				      struct i40e_ring *tx_ring,
>   				      u32 *flags)
> +#else
> +static inline int i40e_tx_prepare_vlan_flags(struct sk_buff *skb,
> +					     struct i40e_ring *tx_ring,
> +					     u32 *flags)
>   #endif
>   {
>   	__be16 protocol = skb->protocol;
> @@ -2414,9 +2414,9 @@ static inline int __i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
>    * Returns 0 if stop is not needed
>    **/
>   #ifdef I40E_FCOE
> -int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
> +inline int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
>   #else
> -static int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
> +static inline int i40e_maybe_stop_tx(struct i40e_ring *tx_ring, int size)
>   #endif
>   {
>   	if (likely(I40E_DESC_UNUSED(tx_ring) >= size))
> @@ -2496,13 +2496,13 @@ linearize_chk_done:
>    * @td_offset: offset for checksum or crc
>    **/
>   #ifdef I40E_FCOE
> -void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
> -		 struct i40e_tx_buffer *first, u32 tx_flags,
> -		 const u8 hdr_len, u32 td_cmd, u32 td_offset)
> -#else
> -static void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
> +inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
>   			struct i40e_tx_buffer *first, u32 tx_flags,
>   			const u8 hdr_len, u32 td_cmd, u32 td_offset)
> +#else
> +static inline void i40e_tx_map(struct i40e_ring *tx_ring, struct sk_buff *skb,
> +			       struct i40e_tx_buffer *first, u32 tx_flags,
> +			       const u8 hdr_len, u32 td_cmd, u32 td_offset)
>   #endif
>   {
>   	unsigned int data_len = skb->data_len;

Inlining i40e_tx_map is kind of overkill isn't it?  Isn't this most of 
the code for the xmit path?

> @@ -2663,11 +2663,11 @@ dma_error:
>    * one descriptor.
>    **/
>   #ifdef I40E_FCOE
> -int i40e_xmit_descriptor_count(struct sk_buff *skb,
> -			       struct i40e_ring *tx_ring)
> -#else
> -static int i40e_xmit_descriptor_count(struct sk_buff *skb,
> +inline int i40e_xmit_descriptor_count(struct sk_buff *skb,
>   				      struct i40e_ring *tx_ring)
> +#else
> +static inline int i40e_xmit_descriptor_count(struct sk_buff *skb,
> +					     struct i40e_ring *tx_ring)
>   #endif
>   {
>   	unsigned int f;

So the VF code is just a copy of this w/ some renaming so I dropped it.  
I'm assuming the actual gains are none for this patch on the VF, do I 
have that correct?  I'm assuming the compiler is smart enough to realize 
it can inline static functions that are only called once.
