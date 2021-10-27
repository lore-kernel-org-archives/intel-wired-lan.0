From: Brelinski, Tony <tony.brelinski@intel.com>
Date: Wed, 27 Oct 2021 20:54:02 +0000
Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix creation of first
 queue by omitting it if is not power of two
In-Reply-To: <1624264651-10706-1-git-send-email-jedrzej.jagielski@intel.com>
References: <1624264651-10706-1-git-send-email-jedrzej.jagielski@intel.com>
Message-ID: <MN2PR11MB4224F75E84E4AA5BD4EE84AE82859@MN2PR11MB4224.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jagielski, Jedrzej
> Sent: Monday, June 21, 2021 1:38 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Jagielski, Jedrzej <jedrzej.jagielski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net v1] i40e: Fix creation of first queue by
> omitting it if is not power of two
> 
> Reject TCs creation with proper message if the first queue assignment is not
> equal to the power of two.
> The first queue number was checked too late in the second queue iteration,
> if second queue was configured at all. Now if first queue value is not a power
> of two, then trying to create qdisc will be rejected.
> 
> Fixes: 8f88b3034db3 ("i40e: Add infrastructure for queue channel support")
> Signed-off-by: Grzegorz Szczurek <grzegorzx.szczurek@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 59 ++++++++++----------------
> ---
>  1 file changed, 19 insertions(+), 40 deletions(-)

Tested-by: Tony Brelinski <tony.brelinski@intel.com>



