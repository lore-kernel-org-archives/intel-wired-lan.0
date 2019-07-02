From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 2 Jul 2019 22:58:27 +0000
Subject: [Intel-wired-lan] [PATCH S22 12/16] ice: Remove duplicate code
 in ice_alloc_rx_bufs
In-Reply-To: <20190626092027.52845-12-anthony.l.nguyen@intel.com>
References: <20190626092027.52845-1-anthony.l.nguyen@intel.com>
 <20190626092027.52845-12-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FBE68@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH S22 12/16] ice: Remove duplicate code in
> ice_alloc_rx_bufs
> 
> From: Brett Creeley <brett.creeley@intel.com>
> 
> Currently if the call to ice_alloc_mapped_page() fails we jump to the no_buf
> label, possibly call ice_release_rx_desc(), and return true indicating that
> there is more work to do. In the success case we just fall out of the while
> loop, possibly call ice_alloc_mapped_page(), and return false saying we
> exhausted cleaned_count. This flow can be improved by breaking if
> ice_alloc_mapped_page() fails and then the flow outside of the while loop is
> the same for the failure and success case.
> 
> Signed-off-by: Brett Creeley <brett.creeley@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


