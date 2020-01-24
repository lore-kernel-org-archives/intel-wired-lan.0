From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Jan 2020 23:17:07 +0000
Subject: [Intel-wired-lan] [PATCH S37 01/15] ice: Fix DCB rebuild after
 reset
In-Reply-To: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
References: <20200122152041.41498-1-anthony.l.nguyen@intel.com>
Message-ID: <5178da759ae04c7ea329b81db8f47abf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, January 22, 2020 7:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S37 01/15] ice: Fix DCB rebuild after reset
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
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c | 82 ++++++++------------
>  drivers/net/ethernet/intel/ice/ice_main.c    |  1 +
>  2 files changed, 35 insertions(+), 48 deletions(-)


Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


