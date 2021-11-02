From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Tue, 2 Nov 2021 23:03:20 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add ensurance of
 MacVlan resources for every trusted VF
In-Reply-To: <20210617071926.256183-1-karen.sornek@intel.com>
References: <20210617071926.256183-1-karen.sornek@intel.com>
Message-ID: <MN2PR11MB42247CC4F3287AFB46D05B07828B9@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Sornek, Karen
> Sent: Thursday, June 17, 2021 12:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Patynowski, PrzemyslawX <przemyslawx.patynowski@intel.com>;
> Sornek, Karen <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] i40e: Add ensurance of
> MacVlan resources for every trusted VF
> 
> Trusted VF can use up every resource available, leaving nothing to other
> trusted VFs.
> Introduce define, which calculates MacVlan resources available based on
> maximum available MacVlan resources, bare minimum for each VF and
> number of currently allocated VFs.
> 
> Signed-off-by: Przemyslaw Patynowski
> <przemyslawx.patynowski@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 34 ++++++++++++++++---
>  1 file changed, 29 insertions(+), 5 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>


