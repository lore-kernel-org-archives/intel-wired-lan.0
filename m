From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:49:08 +0000
Subject: [Intel-wired-lan] [PATCH S22 03/16] ice: Move vector base setup
 to PF VSI
In-Reply-To: <20190626092027.52845-3-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-3-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBDD2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, June 26, 2019 2:20 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S22 03/16] ice: Move vector base setup to
> PF VSI
> 
> When interrupt tracking was refactored, during rebuild, the call to
> ice_vsi_setup_vector_base() was inadvertently removed from the PF VSI
> instead of being removed from the VF VSI. During reset, the failure to
> properly setup the vector base generates a call trace. Correct this so that
> resets/rebuilds properly complete.
> 
> Fixes: cbe66bfee6a0 ("ice: Refactor interrupt tracking")
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


