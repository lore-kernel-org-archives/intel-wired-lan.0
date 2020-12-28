From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Mon, 28 Dec 2020 14:03:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add info trace at loading xdp
 program
In-Reply-To: <20200918160927.11265-1-arkadiusz.kubalewski@intel.com>
References: <20200918160927.11265-1-arkadiusz.kubalewski@intel.com>
Message-ID: <SN6PR11MB300833ADECF9F90681344630E2D90@SN6PR11MB3008.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Arkadiusz Kubalewski
> Sent: Friday, September 18, 2020 9:39 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Add info trace at loading xdp program
> 
> New trace indicates that the XDP program was loaded.
> The trace has a note that in case of using XDP_REDIRECT, number of queues on
> both interfaces shall be the same.
> This is required for optimal performance of XDP_REDIRECT, if interface used for
> TX has lower number of queues than a RX interface, the packets may be dropped
> (depending on RSS queue assignment).
> 
> Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>

