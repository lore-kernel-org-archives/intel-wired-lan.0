From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 5 Nov 2021 09:11:31 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1 4/4] ice: use modern
 kernel API for kick
In-Reply-To: <20211026000826.156803-5-jesse.brandeburg@intel.com>
References: <20211026000826.156803-1-jesse.brandeburg@intel.com>
 <20211026000826.156803-5-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB336751D3BAA06092C2487B70FC8E9@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next v1 4/4] ice: use modern kernel API
> for kick
> 
> The kernel gained a new interface for drivers to use to combine tail bump
> (doorbell) and BQL updates, attempt to use those new interfaces.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_txrx.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
