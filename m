From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Dec 2017 16:47:56 +0000
Subject: [Intel-wired-lan] [next PATCH S83-V5 9/9] i40e: Disable iWARP
 VSI PETCP_ENA flag on netdev down events
In-Reply-To: <20171218101822.76016-1-alice.michael@intel.com>
References: <20171218101822.76016-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8CAB71@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, December 18, 2017 2:18 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S83-V5 9/9] i40e: Disable iWARP VSI
> PETCP_ENA flag on netdev down events
> 
> From: Shiraz Saleem <shiraz.saleem@intel.com>
> 
> Client close is overloaded to handle both un-registration and netdev down
> event. On netdev down, i40iw client close is called which unregisters the
> RDMA dev and and this is too destructive since the netdev is still registered.
> 
> Do not call client close/open on netdev down/up events. Instead disable the
> PE TCP_ENA flag during a netdev down event. This blocks all TCP traffic to the
> RDMA Protocol Engine. On netdev up, re-enable the flag.
> 
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 36 ++++++++++++++---------
> ----  drivers/net/ethernet/intel/i40e/i40e_client.h |  2 +-
>  2 files changed, 20 insertions(+), 18 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


