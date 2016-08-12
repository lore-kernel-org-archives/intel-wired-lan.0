From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Aug 2016 22:47:24 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Force VLNCTRL.VFE to be set in
 all	VMDq paths
In-Reply-To: <147095231662.4841.672399088639313718.stgit@ahduyck-desk.amr.corp.intel.com>
References: <147095231662.4841.672399088639313718.stgit@ahduyck-desk.amr.corp.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8B99@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, August 11, 2016 2:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Force VLNCTRL.VFE to be set in all
> VMDq paths
> 
> When I was adding the code for enabling VLAN promiscuous mode with SR-
> IOV enabled I had inadvertently left the VLNCTRL.VFE bit unchanged as I has
> assumed there was code in another path that was setting it when we
> enabled SR-IOV.  This wasn't the case and as a result we were just disabling
> VLAN filtering for all the VFs apparently.
> 
> Also the previous patches were always clearing CFIEN which was always set
> to 0 by the hardware anyway so I am dropping the redundant bit clearing.
> 
> Fixes: 16369564915a ("ixgbe: Add support for VLAN promiscuous with SR-
> IOV")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   18 ++++++++++++------
>  1 file changed, 12 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
