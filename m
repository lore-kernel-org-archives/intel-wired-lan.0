From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 7 Feb 2020 22:31:29 +0000
Subject: [Intel-wired-lan] [PATCH S37 v3 01/15] ice: Fix DCB rebuild
 after reset
In-Reply-To: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
References: <20200206092013.23388-1-anthony.l.nguyen@intel.com>
Message-ID: <b5f9eb9c83a14c7aabaa562ed097017e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, February 6, 2020 1:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 v3 01/15] ice: Fix DCB rebuild after
> reset
> 
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> The function ice_dcb_rebuild had some logic flaws in it, and also didn't
> differentiate between FW and SW modes needs.
> 
> For FW flow, the willing setting was being forced to OFF and left that way.
> Unwilling in DCB FW mode is not a supported model.
> 
> Leave the config alone and use the return value from the set command to
> determine if setting the config was successful.
> 
> The SW DCB flow does not need to need to register for MIB change events
> (as they are not used in SW mode).
> 
> Use !is_sw_lldp checks to only perform FW specific task while in FW mode.
> 
> Also adding a reapplication of the current DCB config after a link event.  Some
> NVMs are not maintaining their DCB configs across link events.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
> v3:
> - Use goto's for single exit/unlock path
> v2:
> - Add missing mutex_unlock() in error path
> ---
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 88 ++++++++------------
>  drivers/net/ethernet/intel/ice/ice_main.c    |  1 +
>  2 files changed, 36 insertions(+), 53 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


