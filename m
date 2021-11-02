From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 2 Nov 2021 00:21:40 +0000
Subject: [Intel-wired-lan] [PATCH net-next 11/15] iavf: Prevent changing
 static ITR values if adaptive moderation is on
In-Reply-To: <20210604165335.33329-11-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-11-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB5144CB199B7CCAB42FA9085CE28B9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, June 4, 2021 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 11/15] iavf: Prevent changing static
> ITR values if adaptive moderation is on
> 
> From: Nitesh B Venkatesh <nitesh.b.venkatesh@intel.com>
> 
> Resolve being able to change static values on VF when adaptive interrupt
> moderation is enabled.
> 
> This problem is fixed by checking the interrupt settings is not a combination of
> change of static value while adaptive interrupt moderation is turned on.
> 
> Without this fix, the user would be able to change static values on VF with
> adaptive moderation enabled.
> 
> Signed-off-by: Nitesh B Venkatesh <nitesh.b.venkatesh@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 30 ++++++++++++++++---
>  1 file changed, 26 insertions(+), 4 deletions(-)

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  

