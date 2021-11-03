From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Wed, 3 Nov 2021 19:45:15 +0000
Subject: [Intel-wired-lan] [PATCH net-next 15/15] iavf: don't be so
 alarming
In-Reply-To: <20210604165335.33329-15-anthony.l.nguyen@intel.com>
References: <20210604165335.33329-1-anthony.l.nguyen@intel.com>
 <20210604165335.33329-15-anthony.l.nguyen@intel.com>
Message-ID: <PH0PR11MB51444B9CC8BF88F0FD0F1E94E28C9@PH0PR11MB5144.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH net-next 15/15] iavf: don't be so alarming
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Reduce the log level of a couple of messages. These can appear during normal
> reset and rmmod processing, and the driver recovers just fine. Debug level is fine
> for these.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c     | 2 +-
>  drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>  
