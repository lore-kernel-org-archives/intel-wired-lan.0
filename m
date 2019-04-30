From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 30 Apr 2019 23:20:00 +0000
Subject: [Intel-wired-lan] [PATCH S19 08/15] ice: Gracefully handle
 reset failure in ice_alloc_vfs()
In-Reply-To: <20190416172439.27908-9-anirudh.venkataramanan@intel.com>
References: <20190416172439.27908-1-anirudh.venkataramanan@intel.com>
 <20190416172439.27908-9-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D39B06D@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Tuesday, April 16, 2019 10:25 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S19 08/15] ice: Gracefully handle reset
> failure in ice_alloc_vfs()
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if ice_reset_all_vfs() fails in ice_alloc_vfs() we fail to free some
> resources, reset variables, and return an error value.
> Fix this by adding another unroll case to free the pf->vf array, set the pf-
> >num_alloc_vfs to 0, and return an error code.
> 
> Without this, if ice_reset_all_vfs() fails in ice_alloc_vfs() we will not be able
> to do SRIOV without hard rebooting the system because rmmoding the
> driver does not work.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


