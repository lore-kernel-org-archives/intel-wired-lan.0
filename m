From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 18:13:55 +0000
Subject: [Intel-wired-lan] [PATCH S23 v2 06/15] ice: Set WB_ON_ITR when
 we don't re-enable interrupts
In-Reply-To: <20190628150332.59155-6-anthony.l.nguyen@intel.com>
References: <20190628150332.59155-1-anthony.l.nguyen@intel.com>
 <20190628150332.59155-6-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD133@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Friday, June 28, 2019 8:03 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S23 v2 06/15] ice: Set WB_ON_ITR when
> we don't re-enable interrupts
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently when busy polling is enabled we aren't setting/enabling
> WB_ON_ITR in the driver. This doesn't break the driver, but it does cause
> issues. If we don't enable WB_ON_ITR mode we will still get write-backs
> from hardware during polling when a cache line has been filled, but if a cache
> line is not filled we will not get the write-back because WB_ON_ITR is not set.
> Fix this by enabling WB_ON_ITR in the driver when interrupts are disabled.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  3 ++
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 54 +++++++++++++++++++
>  drivers/net/ethernet/intel/ice/ice_txrx.h     | 13 +++++
>  3 files changed, 70 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


