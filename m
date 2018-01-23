From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 23 Jan 2018 22:50:37 +0000
Subject: [Intel-wired-lan] [next PATCH S86-V2 4/8] i40e: refactor
 promisc_changed in i40e_sync_vsi_filters
In-Reply-To: <20180122170039.14144-4-alice.michael@intel.com>
References: <20180122170039.14144-1-alice.michael@intel.com>
 <20180122170039.14144-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A93A0F0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, January 22, 2018 9:01 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S86-V2 4/8] i40e: refactor
> promisc_changed in i40e_sync_vsi_filters
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> This code here is quite complex and easy to screw up.  Let's see if we can't
> improve the readability and maintainability a bit.  This refactors out
> promisc_changed into two variables 'old_overflow' and 'new_overflow'
> which makes it a bit clearer when we're concerned about when and how
> overflow promiscuous is changed.  This also makes so that we no longer need
> to pass a boolean pointer to i40e_aqc_add_filters.  Instead we can simply
> check if we changed the overflow promiscuous flag since the function start.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 42 ++++++++++++++----------
> -----
>  1 file changed, 20 insertions(+), 22 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


