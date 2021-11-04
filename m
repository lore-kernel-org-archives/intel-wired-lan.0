From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Thu, 4 Nov 2021 18:36:53 +0000
Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor text of
 informational message
In-Reply-To: <20210831101202.3532-1-karen.sornek@intel.com>
References: <20210831101202.3532-1-karen.sornek@intel.com>
Message-ID: <PH0PR11MB51449532535F0A45DF55FC89E28D9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karen
> Sornek
> Sent: Tuesday, August 31, 2021 3:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bruce Allan <bruce.w.allan@intel.com>; Sornek, Karen
> <karen.sornek@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next v1] iavf: Refactor text of informational
> message
> 
> This message is intended to be informational to indicate a reset is about to
> happen, but the use of "warning" in the message text can cause concern with
> users.  Reword the message to make it less alarming.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Karen Sornek <karen.sornek@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
