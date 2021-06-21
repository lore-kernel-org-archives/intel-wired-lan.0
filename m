From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Mon, 21 Jun 2021 22:02:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: remove the VSI info
 from previous agg
In-Reply-To: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
References: <20210614214607.41749-1-anthony.l.nguyen@intel.com>
Message-ID: <SJ0PR11MB5662462FAD6D49F28BF8D1A0FA0A9@SJ0PR11MB5662.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Monday, June 14, 2021 2:46 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 1/2] ice: remove the VSI info from
> previous agg
> 
> From: Victor Raj <victor.raj@intel.com>
> 
> Remove the VSI info from previous aggregator after moving the VSI to a new
> aggregator.
> 
> Signed-off-by: Victor Raj <victor.raj@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_sched.c | 24 ++++++++++++++++++++--
>  1 file changed, 22 insertions(+), 2 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> (A Contingent Worker at Intel)


