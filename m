From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Thu, 4 Nov 2021 20:26:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor string
 format to avoid static analysis warnings
In-Reply-To: <20210831113901.156388-1-karen.sornek@intel.com>
References: <20210831113901.156388-1-karen.sornek@intel.com>
Message-ID: <PH0PR11MB514407A7006B7A331C526BE4E28D9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen
> Sornek
> Sent: Tuesday, August 31, 2021 4:39 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Sornek, Karen <karen.sornek@intel.com>; Swiatkowski, Michal
> <michal.swiatkowski@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor string format to avoid
> static analysis warnings
> 
> Change format to match variable type that is used in string.
> 
> Use %u format for unsigned variable and %d format for signed variable to remove
> static analysis warnings.
> 
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 6 +++---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
