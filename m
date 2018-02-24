From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Sat, 24 Feb 2018 06:43:36 +0000
Subject: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
 return value with autoneg off.
In-Reply-To: <20180220061200.17708-1-bpoirier@suse.com>
References: <20180220061200.17708-1-bpoirier@suse.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B8C7FA12E@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Benjamin Poirier
> Sent: Monday, February 19, 2018 10:12 PM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org; linux-
> kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-queue] e1000e: Fix check_for_link
> return value with autoneg off.
> 
> When autoneg is off, the .check_for_link callback functions clear the
> get_link_status flag and systematically return a "pseudo-error". This means
> that the link is not detected as up until the next execution of the
> e1000_watchdog_task() 2 seconds later.
> 
> Fixes: 19110cfbb34d ("e1000e: Separate signaling for link check/link up")
> Signed-off-by: Benjamin Poirier <bpoirier@suse.com>
> ---
>  drivers/net/ethernet/intel/e1000e/ich8lan.c | 2 +-
>  drivers/net/ethernet/intel/e1000e/mac.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
