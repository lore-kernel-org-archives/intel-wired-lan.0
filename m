From: Jani Nikula <jani.nikula@linux.intel.com>
Date: Mon, 25 Jun 2018 15:24:09 +0300
Subject: [Intel-wired-lan] [Intel-gfx] [BUG] cc5b114dcf bpf,
 i40e: add meta data support
In-Reply-To: <dc3176ae-5b16-ffa8-c8c8-595a0ede57f4@iogearbox.net>
References: <20180612161739.GA3303@localhost.localdomain>
 <dc3176ae-5b16-ffa8-c8c8-595a0ede57f4@iogearbox.net>
Message-ID: <878t73uk9i.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


FYI, the list you're looking for is likely intel-wired-lan (added), not
intel-gfx (removed).

BR,
Jani.


On Tue, 12 Jun 2018, Daniel Borkmann <daniel@iogearbox.net> wrote:
> On 06/12/2018 06:17 PM, Keith Busch wrote:
>> My server's i40e no longer obtains an IP address on linux
>> mainline. Bisected to the following:
>> 
>> commit cc5b114dcf986bfd8e4c37bf65d1b7b1e5290ac6
>> Author: Daniel Borkmann <daniel@iogearbox.net>
>> Date:   Mon May 28 11:07:20 2018 +0200
>> 
>>     bpf, i40e: add meta data support
>> 
>> Reverting on mainline resolves the issue.
>> 
>> Is there something wrong with my i40e adapter, or is the patch possibly
>> doing something wrong? Or any other information I can get to help
>> understand why it's stopped working with this feature?
>> 
>> An excert from "journalctl -xe" on on the failing network adapter
>> is below.
>
> Thanks for the report & sorry for the issue, Keith! Instead of revert,
> could you give the below fix a try?
>
> diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> index 8ffb745..ed6dbcf 100644
> --- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> +++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
> @@ -2103,9 +2103,8 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  	unsigned int truesize = i40e_rx_pg_size(rx_ring) / 2;
>  #else
>  	unsigned int truesize = SKB_DATA_ALIGN(sizeof(struct skb_shared_info)) +
> -				SKB_DATA_ALIGN(I40E_SKB_PAD +
> -					       (xdp->data_end -
> -						xdp->data_hard_start));
> +				SKB_DATA_ALIGN(xdp->data_end -
> +					       xdp->data_hard_start);
>  #endif
>  	struct sk_buff *skb;
>
> @@ -2124,7 +2123,7 @@ static struct sk_buff *i40e_build_skb(struct i40e_ring *rx_ring,
>  		return NULL;
>
>  	/* update pointers within the skb to store the data */
> -	skb_reserve(skb, I40E_SKB_PAD + (xdp->data - xdp->data_hard_start));
> +	skb_reserve(skb, xdp->data - xdp->data_hard_start);
>  	__skb_put(skb, xdp->data_end - xdp->data);
>  	if (metasize)
>  		skb_metadata_set(skb, metasize);
>
> Thanks,
> Daniel
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Jani Nikula, Intel Open Source Graphics Center
