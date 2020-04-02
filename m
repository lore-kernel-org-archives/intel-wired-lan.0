From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 2 Apr 2020 14:31:41 +0200
Subject: [Intel-wired-lan] [PATCH] e1000e: bump up timeout to wait when
 ME un-configure ULP mode
In-Reply-To: <20200323191639.48826-1-aaron.ma@canonical.com>
References: <20200323191639.48826-1-aaron.ma@canonical.com>
Message-ID: <4f9f1ad0-e66a-d3c8-b152-209e9595e5d7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi,

On 3/23/20 8:16 PM, Aaron Ma wrote:
> ME takes 2+ seconds to un-configure ULP mode done after resume
> from s2idle on some ThinkPad laptops.
> Without enough wait, reset and re-init will fail with error.
> 
> Fixes: f15bb6dde738cc8fa0 ("e1000e: Add support for S0ix")
> BugLink: https://bugs.launchpad.net/bugs/1865570
> Signed-off-by: Aaron Ma <aaron.ma@canonical.com>

I have been testing this bug because this is being reported against
Fedora 32 too:

https://bugzilla.redhat.com/show_bug.cgi?id=1816621

I can confirm that this patch fixes the problem of both
a X1 7th gen as a X1 8th gen no longer suspending after
a suspend resume cycle.

Not only does it fix that, before this patch the kernel
would regularly log the following error on these laptops
independent of suspend/resume activity:

e1000e 0000:00:1f.6 enp0s31f6: Hardware Error

These messages are now also gone. So it seems that the timeout
is really just too short.

I can agree that it would be good to better understand this;
and/or to get the ME firmware fixed to not take so long.

But in my experience when dealing with e.g. embedded-controller
in various laptops sometimes the firmware of these devives
simply just takes a long time for certain things.

This fix fixes a real problem, on a popular model laptop
and since it just extends a timeout it is a pretty harmless
(no chance of regressions) fix. As such since there seems
to be no other solution in sight, can we please move forward
with this fix for now ?

Regards,

Hans





> ---
>   drivers/net/ethernet/intel/e1000e/ich8lan.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/ich8lan.c b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> index b4135c50e905..147b15a2f8b3 100644
> --- a/drivers/net/ethernet/intel/e1000e/ich8lan.c
> +++ b/drivers/net/ethernet/intel/e1000e/ich8lan.c
> @@ -1240,9 +1240,9 @@ static s32 e1000_disable_ulp_lpt_lp(struct e1000_hw *hw, bool force)
>   			ew32(H2ME, mac_reg);
>   		}
>   
> -		/* Poll up to 300msec for ME to clear ULP_CFG_DONE. */
> +		/* Poll up to 2.5sec for ME to clear ULP_CFG_DONE. */
>   		while (er32(FWSM) & E1000_FWSM_ULP_CFG_DONE) {
> -			if (i++ == 30) {
> +			if (i++ == 250) {
>   				ret_val = -E1000_ERR_PHY;
>   				goto out;
>   			}
> 

