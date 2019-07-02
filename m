From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:59:26 +0000
Subject: [Intel-wired-lan] [PATCH S22 14/16] ice: Remove unnecessary
 flag ICE_FLAG_MSIX_ENA
In-Reply-To: <20190626092027.52845-14-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-14-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE84@ORSMSX104.amr.corp.intel.com>
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
> Cc: Creeley, Brett <brett.creeley@intel.com>
> Subject: [Intel-wired-lan] [PATCH S22 14/16] ice: Remove unnecessary flag
> ICE_FLAG_MSIX_ENA
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> This flag is not needed and is called every time we re-enable interrupts in the
> hotpath so remove it. Also remove ice_vsi_req_irq() because it was a
> wrapper function for ice_vsi_req_irq_msix() whose sole purpose was
> checking the ICE_FLAG_MSIX_ENA flag.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 -
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 71 +++++++++-------------
> drivers/net/ethernet/intel/ice/ice_main.c | 74 ++++++-----------------
> drivers/net/ethernet/intel/ice/ice_txrx.c |  4 +-
>  4 files changed, 48 insertions(+), 102 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


