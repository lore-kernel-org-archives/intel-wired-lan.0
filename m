From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 18 Dec 2019 22:16:52 +0000
Subject: [Intel-wired-lan] [PATCH S35 03/15] ice: Add code to keep track
 of current dflt_vsi
In-Reply-To: <20191212111307.33566-3-anthony.l.nguyen@intel.com>
References: <20191212111307.33566-1-anthony.l.nguyen@intel.com>
 <20191212111307.33566-3-anthony.l.nguyen@intel.com>
Message-ID: <4c8bb0a4622f4944b9503f3ea7220a17@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, December 12, 2019 3:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S35 03/15] ice: Add code to keep track of
> current dflt_vsi
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> We can't have more than one default VSI so prevent another VSI from
> overwriting the current dflt_vsi. This was achieved by adding the following
> functions:
> 
> ice_is_dflt_vsi_in_use()
> - Used to check if the default VSI is already being used.
> 
> ice_is_vsi_dflt_vsi()
> - Used to check if VSI passed in is in fact the default VSI.
> 
> ice_set_dflt_vsi()
> - Used to set the default VSI via a switch rule
> 
> ice_clear_dflt_vsi()
> - Used to clear the default VSI via a switch rule.
> 
> Also, there was no need to introduce any locking because all mailbox events
> and synchronization of switch filters for the PF happen in the service task.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |   2 +
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 118 ++++++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_lib.h  |   4 +
>  drivers/net/ethernet/intel/ice/ice_main.c |  43 +++++---
>  4 files changed, 151 insertions(+), 16 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


