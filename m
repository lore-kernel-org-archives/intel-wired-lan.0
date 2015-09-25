From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Sep 2015 22:32:47 +0000
Subject: [Intel-wired-lan] [net-next PATCH v2 2/3] i40e/i40evf: Drop
 useless	"IN_NETPOLL" flag
In-Reply-To: <20150924160432.22015.84967.stgit@ahduyck-vm-fedora22>
References: <20150924160027.22015.15754.stgit@ahduyck-vm-fedora22>
 <20150924160432.22015.84967.stgit@ahduyck-vm-fedora22>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1AC8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, September 24, 2015 9:05 AM
> To: netdev at vger.kernel.org; intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next PATCH v2 2/3] i40e/i40evf: Drop useless
> "IN_NETPOLL" flag
> 
> The code in i40e and i40evf is using an "IN_NETPOLL" flag that has never
> added any value due to the fact that the Rx clean-up is handled in NAPI.
> As such the flag was set, the queue was scheduled via NAPI, and then polled
> from the netpoll controller and if any Rx packets were processed the were
> processed in the wrong context.
> 
> In addition the flag itself just added an unneeded conditional to the hot-path
> so it can safely be dropped and save us a few instructions.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |    1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |    2 --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   |    7 +------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |    7 +------
>  drivers/net/ethernet/intel/i40evf/i40evf.h    |    2 --
>  5 files changed, 2 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
