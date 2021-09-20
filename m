From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 20 Sep 2021 05:11:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 3/3] ice: fix software
 generating extra interrupts
In-Reply-To: <20210824011259.738307-4-jesse.brandeburg@intel.com>
References: <20210824011259.738307-1-jesse.brandeburg@intel.com>
 <20210824011259.738307-4-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB33673D57E74AAA0546CE2060FCA09@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Tuesday, August 24, 2021 6:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 3/3] ice: fix software
> generating extra interrupts
> 
> The driver tried to work around missing completion events that occurred
> while interrupts are disabled, by triggering a software interrupt whenever
> we exit polling (but we had to have polled at least once).
> 
> This was causing a *lot* of extra interrupts for some workloads like NVMe
> over TCP, which resulted in regressions in performance. It was also visible
> when polling didn't prevent interrupts when busy_poll was enabled.
> 
> Fix the extra interrupts by utilizing our previously unused 3rd ITR (interrupt
> throttle) index and set it to 20K interrupts per second, and then trigger a
> software interrupt within that rate limit.
> 
> While here, slightly refactor the code to avoid an overwrite of a local variable
> in the case of wb_en = true.
> 
> Fixes: b7306b42beaf ("ice: manage interrupts during poll exit")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  .../net/ethernet/intel/ice/ice_hw_autogen.h   |  1 +
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 26 +++++++++++--------
>  2 files changed, 16 insertions(+), 11 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
