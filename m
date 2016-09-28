From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Sep 2016 19:05:23 +0000
Subject: [Intel-wired-lan] [next PATCH S48 4/7] i40e: Correctly restore
 LED	status after ethtool identify
In-Reply-To: <1475000934-27335-5-git-send-email-bimmy.pujari@intel.com>
References: <1475000934-27335-1-git-send-email-bimmy.pujari@intel.com>
 <1475000934-27335-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA0F025@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, September 27, 2016 11:29 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S48 4/7] i40e: Correctly restore LED
> status after ethtool identify
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Restore the activity LED status after using "ethtool -p device".
> 
> A previous commit incorrectly swapped the parameters for i40e_led_set().
> This results in a failure to restore the LED status properly after using "ethtool
> -p" and the activity LED will remain off until a reset occurs.
> 
> Fix the parameter ordering to restore the LED status after the ethtool
> identify operation.
> 
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I3fc9ac419e67a53e401d8a70fb20fd6cff3af82c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Status LEDs return to normal functions after ethtool identify


