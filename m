From: Alexander Duyck <alexander.h.duyck@redhat.com>
Date: Thu, 09 Apr 2015 15:45:01 -0700
Subject: [Intel-wired-lan] [net-next v2] e1000e: fix call to do_div() to
 use u64 arg
In-Reply-To: <20150409214405.27465.51380.stgit@gmw-smvitp108.amr.corp.intel.com>
References: <20150409214405.27465.51380.stgit@gmw-smvitp108.amr.corp.intel.com>
Message-ID: <552700ED.3030009@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



On 04/09/2015 02:45 PM, Jeff Kirsher wrote:
> We were using s64 for lat_ns (latency nano-second value) since in
> our calculations a negative value could be a resultant.  For negative
> values, we then assign lat_ns to be zero, so the value passed to
> do_div() was never negative, but do_div() expects the argument type
> to be u64, so do a cast to resolve a compile warning seen on
> PowerPC.
>
> CC: Yanjiang Jin <yanjiang.jin@windriver.com>
> CC: Yanir Lubetkin <yanirx.lubetkin@intel.com>
> Reported-by: Yanjiang Jin <yanjiang.jin@windriver.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> ---
> v2: fixed the patch to not use a cast to resolve the PowerPC compile
>      warning
> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c |   13 +++++++------
>   1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index 9d81c03..7053863 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1015,7 +1015,7 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   		u16 max_snoop, max_nosnoop;
>   		u16 max_ltr_enc;	/* max LTR latency encoded */
>   		s64 lat_ns;	/* latency (ns) */
> -		s64 value;
> +		u64 value;
>   		u32 rxa;
>
>   		if (!hw->adapter->max_frame_size) {
> @@ -1042,12 +1042,13 @@ static s32 e1000_platform_pm_pch_lpt(struct e1000_hw *hw, bool link)
>   		 */
>   		lat_ns = ((s64)rxa * 1024 -
>   			  (2 * (s64)hw->adapter->max_frame_size)) * 8 * 1000;
> -		if (lat_ns < 0)
> -			lat_ns = 0;
> -		else
> -			do_div(lat_ns, speed);
> +		if (lat_ns < 0) {
> +			value = 0;
> +		} else {
> +			value = lat_ns;
> +			do_div(value, speed);
> +		}
>
> -		value = lat_ns;
>   		while (value > PCI_LTR_VALUE_MASK) {
>   			scale++;
>   			value = DIV_ROUND_UP(value, (1 << 5));


Honestly the whole signed/unsigned thing is kind of a waste anyway.  You 
could probably rewrite it to something like this and drop lat_ns entirely.

rxa *= 512;
value = (rxa > hw->adapter->max_frame_size) ?
	(rxa - hw->adapter->max_frame_size) * (16000 / speed) : 0;

That should give you the same result without any need for the do_div or 
the signed values.

- Alex
