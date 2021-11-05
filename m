From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 5 Nov 2021 09:10:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 1/4] ice: update to newer
 kernel API
In-Reply-To: <20211026000826.156803-2-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
 <20211026000826.156803-2-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB336780E7D3A912DF308F48E5FC8E9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Jesse
> Brandeburg
> Sent: Tuesday, October 26, 2021 5:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v1 1/4] ice: update to newer kernel
> API
> 
> Use the netif_tx_* API from netdevice.h which has simpler parameters.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> Testing Hints: test transmit performance and queue start/stop tests which
> increment tx_restart counter.
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
