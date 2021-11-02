From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 2 Nov 2021 16:36:27 +0000
Subject: [Intel-wired-lan] [PATCH net-next 07/15] iavf: Restore non MAC
 filters after link down
In-Reply-To: <20210604165335.33329-7-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-7-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB51441320BF0B02BA7D4459A9E28B9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Nguyen, Anthony L
> Sent: Friday, June 4, 2021 9:53 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 07/15] iavf: Restore non MAC filters
> after link down
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> Restore VLAN filters after the link is brought down, and up - since all filters are
> deleted from HW during the netdev link down routine.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf.h      |  1 +
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 35 ++++++++++++++++++---
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
