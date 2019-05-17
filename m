From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 17 May 2019 22:28:42 +0000
Subject: [Intel-wired-lan] [next PATCH S5 iavf 10/11] iavf: add call to
 iavf_[add|del]_cloud_filter
In-Reply-To: <20190514173709.62431-10-alice.michael@intel.com>
References: <20190514173709.62431-1-alice.michael@intel.com>
 <20190514173709.62431-10-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DB787@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 14, 2019 10:37 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S5 iavf 10/11] iavf: add call to
> iavf_[add|del]_cloud_filter
> 
> From: Paul Greenwalt <paul.greenwalt@intel.com>
> 
> Add call to iavf_add_cloud_filter and iavf_del_cloud_filter from
> iavf_process_aq_command to clear aq_required
> IAVF_FLAG_AQ_ADD_CLOUD_FILTER and
> IAVF_FLAG_AQ_DEL_CLOUD_FILTER bits.
> 
> aq_required IAVF_FLAG_AQ_DEL_CLOUD_FILTER bit is being set in
> iavf_down and iavf_delete_clsflower, and are never cleared.
> 
> aq_required IAVF_FLAG_AQ_ADD_CLOUD_FILTER bit is being set in
> iavf_handle_reset and iavf_configure_clsflower, and are never cleared.
> 
> Since the aq_required is not zero, iavf_watchdog_task is setting the
> queue_delayed_work to 20 msec instead of the longer delay.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


