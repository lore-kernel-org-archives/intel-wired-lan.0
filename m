From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 23 Jun 2021 19:58:12 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix PTP on 5Gb links
In-Reply-To: <20210507185625.2651538-1-jesse.brandeburg@intel.com>
References: <20210507185625.2651538-1-jesse.brandeburg@intel.com>
Message-ID: <SJ0PR11MB56627F70A024E933DCAE0EAFFA089@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Friday, May 7, 2021 11:56 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: fix PTP on 5Gb links
> 
> As reported by Alex Sergeev, the i40e driver is incremening the PTP clock at
> 10Gb speeds when linked at 5Gb. Fix this bug by making sure that the right
> multiplier is selected when linked at 5Gb.
> 
> Fixes: 3dbdd6c2f70a ("i40e: Add support for 5Gbps cards")
> Reported-by: Alex Sergeev <asergeev@carbonrobotics.com>
> Suggested-by: Alex Sergeev <asergeev@carbonrobotics.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


