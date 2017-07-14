From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Jul 2017 21:20:55 +0000
Subject: [Intel-wired-lan] [next PATCH S75-V3 01/11] i40evf: use
	netdev	variable in reset task
In-Reply-To: <20170712094614.76501-1-alice.michael@intel.com>
References: <20170712094614.76501-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB1B63@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, July 12, 2017 2:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S75-V3 01/11] i40evf: use netdev
> variable in reset task
> 
> From: Alan Brady <alan.brady@intel.com>
> 
> If we're going to bother initializing a variable to reference it we might as well
> use it.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


