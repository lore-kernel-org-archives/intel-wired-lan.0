From: Paul Menzel <pmenzel@molgen.mpg.de>
Date: Wed, 6 Apr 2022 07:34:37 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] e1000e: Fix possible overflow
 in LTR decoding
In-Reply-To: <20220405155601.1443799-1-sasha.neftin@intel.com>
References: <20220405155601.1443799-1-sasha.neftin@intel.com>
Message-ID: <f0402937-8594-6ecb-c4f9-c6605dd73d77@molgen.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Dear Sasha,


Thank you for your patch.

Am 05.04.22 um 17:56 schrieb Sasha Neftin:
> When we decode the latency and the max_latency u16 value does not fill
> the required size

Do you mean ?fit into? or ?is too small for the required size??

> and could lead to the wrong LTR representation.

Maybe give an example of values leading to incorrect behavior?

> Replace the u16 type with the u32 type and allow corrected LTR
> representation.

Maybe: Increase the variable size from u16 to u32, so the decoded 
latency can be represented. Why are 32 bit enough? Why not 64 bit?

Please use 75 characters per line.

> Fixes: 44a13a5d99c7 ("e1000e: Fix the max snoop/no-snoop latency for 10M")
> Reported-by: James Hutchinson <jahutchinson99@googlemail.com>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=215689
> Suggested-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
> Signed-off-by: Sasha Neftin <sasha.neftin@intel.com>

Add

Tested-by: James Hutchinson <jahutchinson99@googlemail.com> (I219-V (rev 
30))

> ---
> v2: added link tag
> 
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index d60e2016d03c..e6c8e6d5234f 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1009,8 +1009,8 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   {
>   	u32 reg = link << (E1000_LTRV_REQ_SHIFT + E1000_LTRV_NOSNOOP_SHIFT) |
>   	    link << E1000_LTRV_REQ_SHIFT | E1000_LTRV_SEND;
> -	u16 max_ltr_enc_d = 0;	/* maximum LTR decoded by platform */
> -	u16 lat_enc_d = 0;	/* latency decoded */
> +	u32 max_ltr_enc_d = 0;	/* maximum LTR decoded by platform */
> +	u32 lat_enc_d = 0;	/* latency decoded */
>   	u16 lat_enc = 0;	/* latency encoded */
>   
>   	if (link) {

The diff looks good.


Kind regards,

Paul
