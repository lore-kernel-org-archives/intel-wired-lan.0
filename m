From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 4 Aug 2016 19:30:42 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] e1000e: factor out
 systim	sanitization
In-Reply-To: <1469557535-63429-2-git-send-email-jarod@redhat.com>
References: <1469292274-59237-1-git-send-email-jarod@redhat.com>
 <1469557535-63429-1-git-send-email-jarod@redhat.com>
 <1469557535-63429-2-git-send-email-jarod@redhat.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81F6BB67@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jarod Wilson
> Sent: Tuesday, July 26, 2016 11:26 AM
> To: linux-kernel at vger.kernel.org
> Cc: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 1/2] e1000e: factor out systim
> sanitization
> 
> This is prepatory work for an expanding list of adapter families that have
> occasional ~10 hour clock jumps when being used for PTP. Factor out the
> sanitization function and convert to using a feature (bug) flag, per
> suggestion from Jesse Brandeburg.
> 
> Littering functional code with device-specific checks is much messier than
> simply checking a flag, and having device-specific init set flags as needed.
> There are probably a number of other cases in the e1000e code that
> could/should be converted similarly.
> 
> Suggested-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Jesse Brandeburg <jesse.brandeburg@intel.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: netdev at vger.kernel.org
> Signed-off-by: Jarod Wilson <jarod@redhat.com>
> ---
>  drivers/net/ethernet/intel/e1000e/82571.c  |  6 ++-
>  drivers/net/ethernet/intel/e1000e/e1000.h  |  1 +
>  drivers/net/ethernet/intel/e1000e/netdev.c | 66 ++++++++++++++++++-------
> -----
>  3 files changed, 44 insertions(+), 29 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
