From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 9 Aug 2017 17:46:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next] i40e: limit lan queue count
 in	large cpu count machine
In-Reply-To: <1500945462-33176-1-git-send-email-shannon.nelson@oracle.com>
References: <1500945462-33176-1-git-send-email-shannon.nelson@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10E8EC44@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shannon Nelson
> Sent: Monday, July 24, 2017 6:18 PM
> To: davem at davemloft.net; netdev at vger.kernel.org
> Cc: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] i40e: limit lan queue count in
> large cpu count machine
> 
> When a machine has more cpus than queuepairs, e.g. 512 cores, the counting
> gets a little funky and turns off Flow Director with the
> message:
>   not enough queues for Flow Director. Flow Director feature is disabled
> 
> This patch limits the number of lan queues initially allocated to be sure we
> have some left for FD and other features.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
