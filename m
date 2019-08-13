From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Aug 2019 17:08:21 +0000
Subject: [Intel-wired-lan] [PATCH S27 04/15] ice: Rebuild VSI while
 changing queues
In-Reply-To: <20190808143938.4968-4-anthony.l.nguyen@intel.com>
References: <20190808143938.4968-1-anthony.l.nguyen@intel.com>
 <20190808143938.4968-4-anthony.l.nguyen@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D411612@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Thursday, August 8, 2019 7:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S27 04/15] ice: Rebuild VSI while changing
> queues
> 
> From: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> 
> Currently, while the queues are being changed, the driver rebuilds the VSI
> only when the netdev is running. However, the driver needs to rebuild the
> VSI irrespective of the state of netdev. In this way, alloc_txq / alloc_rxq fields
> of the VSI would be updated correctly.
> 
> Signed-off-by: Md Fahad Iqbal Polash <md.fahad.iqbal.polash@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_main.c | 19 ++++++-------------
>  1 file changed, 6 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


