From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 21 Apr 2017 18:08:09 +0000
Subject: [Intel-wired-lan] [next PATCH S71 04/10] i40e: remove
 unnecessary	msleep() delay in i40e_free_vfs
In-Reply-To: <20170419132559.20459-4-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1277@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 04/10] i40e: remove unnecessary
> msleep() delay in i40e_free_vfs
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The delay was added because of a desire to ensure that the VF driver can
> finish up removing. However, pci_disable_sriov already has its own
> ssleep() call that will sleep for an entire second, so there is no reason to add
> extra delay on top of this by using msleep here. In practice, an msleep()
> won't have a huge impact on timing but there is no real value in keeping it, so
> lets just simplify the code and remove it.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 2 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 2 --
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 2 +-
>  3 files changed, 2 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


