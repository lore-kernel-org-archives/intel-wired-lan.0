From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 20:00:26 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 14/15] i40e: Blink LED on
 1G	BaseT boards
In-Reply-To: <1478639119-14656-15-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-15-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA384C4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S52-V2 14/15] i40e: Blink LED on 1G
> BaseT boards
> 
> From: Henry Tieman <henry.w.tieman@intel.com>
> 
> Before this patch "ethtool -p" was not blinking the LEDs on boards with 1G
> BaseT PHYs.
> 
> This commit identifies 1G BaseT boards as having the LEDs connected to the
> MAC. Also, renamed the flag to be more descriptive of usage.
> The flag is now I40E_FLAG_PHY_CONTROLS_LEDS.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Change-ID: I4eb741da9780da7849ddf2dc4c0cb27ffa42a801
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 +++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 ++--
>  3 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


