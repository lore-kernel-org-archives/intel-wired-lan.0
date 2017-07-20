From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Jul 2017 18:13:27 +0000
Subject: [Intel-wired-lan] [next PATCH S76-V2 09/13] i40e: Fix
 unqualified	module message while bringing link up
In-Reply-To: <20170714131019.52530-9-alice.michael@intel.com>
References: <20170714131019.52530-1-alice.michael@intel.com>
 <20170714131019.52530-9-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB25F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, July 14, 2017 6:10 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S76-V2 09/13] i40e: Fix unqualified
> module message while bringing link up
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> In current driver, when ifconfig ethx up is done, the link state doesn't
> transition to UP inside i40e_open(). It changes after AQ command response
> is handled in i40e_handle_link_event().
> 
> When pf->hw.phy.link_info.link_info is DOWN inside i40e_open(), The state
> is transient and invalid. So log message gets printed based on incorrect info
> (i.e link_info and an_info).
> 
> This commit removes check for unqualified module inside
> i40e_up_complete(). The existing check in i40e_handle_link_event() logs the
> error message based on correct link state information.
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 ---------
>  1 file changed, 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


