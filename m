From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Tue, 2 Nov 2021 00:34:54 +0000
Subject: [Intel-wired-lan] [PATCH net-next 10/15] iavf: Add change MTU
 message
In-Reply-To: <20210604165335.33329-10-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-10-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB5144913F23811391A0665C82E28B9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Nguyen,
> Anthony L
> Sent: Friday, June 4, 2021 9:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 10/15] iavf: Add change MTU message
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> Add a netdev_info log entry in case of a change of MTU so that user is notified
> about this change in the same manner as in case of pf driver.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 2 ++
>  1 file changed, 2 insertions(+)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
