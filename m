From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:11:25 +0000
Subject: [Intel-wired-lan] [PATCH S27 07/15] ice: Only disable VLAN
 pruning for the VF when all VLANs are removed
In-Reply-To: <20190808143938.4968-7-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-7-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D41164A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 07/15] ice: Only disable VLAN pruning
> for the VF when all VLANs are removed
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the VF adds a VLAN, VLAN pruning will be enabled for that VSI.
> Also, when a VLAN gets deleted it will disable VLAN pruning even if other
> VLAN(s) exists for the VF. Fix this by only disabling VLAN pruning on the VF
> VSI when removing the last VF (i.e. vf->num_vlan == 0).
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


