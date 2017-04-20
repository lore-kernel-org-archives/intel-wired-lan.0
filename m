From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 20 Apr 2017 23:02:44 +0000
Subject: [Intel-wired-lan] [next PATCH S71 07/10] i40evf: remove
 needless	min_t() on num_online_cpus()*2
In-Reply-To: <20170419132559.20459-7-alice.michael@intel.com>
References: <20170419132559.20459-1-alice.michael@intel.com>
 <20170419132559.20459-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DA1181@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, April 19, 2017 6:26 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S71 07/10] i40evf: remove needless
> min_t() on num_online_cpus()*2
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> We already set pairs to the value of adapter->num_active_queues. This
> value is limited by vsi_res->num_queue_pairs and num_online_cpus(). This
> means that pairs by definition is already smaller than num_online_cpus()*2,
> so we don't even need to bother with this check.
> 
> Lets just remove it and update the comment.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


