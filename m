From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:17:01 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 3/9] i40evf: remove
 flush_scheduled_work call in i40evf_remove
In-Reply-To: <20171218101623.75729-1-alice.michael@intel.com>
References: <20171218101623.75729-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB0F@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:16 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S83-V5 3/9] i40evf: remove
> flush_scheduled_work call in i40evf_remove
> 
> From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> 
> flush_schedule_work blocks until completion of all scheduled work items in
> global work-queue. This can cause deadlock in some cases. i40evf_remove()
> cleans up necessary work items with cancel_delayed_work_sync and
> cancel_work_sync. This fix removes flush_schedule_work call inside
> i40evf_remove().
> 
> Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


