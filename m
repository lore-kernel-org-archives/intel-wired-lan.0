From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 4 Jan 2018 21:47:18 +0000
Subject: [Intel-wired-lan] [next PATCH S84-V2 02/13] i40e: Fix for
 adding multiple ethtool filters on the same location
In-Reply-To: <20171227123242.22356-2-alice.michael@intel.com>
References: <20171227123242.22356-1-alice.michael@intel.com>
 <20171227123242.22356-2-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D6FDB@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, December 27, 2017 4:33 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S84-V2 02/13] i40e: Fix for adding
> multiple ethtool filters on the same location
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> This patch reorders i40e_add_del_fdir and i40e_update_ethtool_fdir_entry
> calls so that we first remove an already existing filter (inside
> i40e_update_ethtool_fdir_entry using i40e_add_del_fdir) and then we add
> a new one with i40e_add_del_fdir.
> After applying this patch, creating multiple identical filters (with the same
> location) one after another doesn't revert their behavior but behaves
> correctly.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


