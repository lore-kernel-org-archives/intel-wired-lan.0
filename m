From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Apr 2018 20:57:09 +0000
Subject: [Intel-wired-lan] [next PATCH S90 4/8] i40evf: Fix turning TSO,
 GSO and GRO on after
In-Reply-To: <20180420084140.8081-4-alice.michael@intel.com>
References: <20180420084140.8081-1-alice.michael@intel.com>
 <20180420084140.8081-4-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A97696A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, April 20, 2018 1:42 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Jablonski, Pawel <pawel.jablonski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S90 4/8] i40evf: Fix turning TSO, GSO
> and GRO on after
> 
> From: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> 
> This patch fixes the problem where each MTU change turns TSO, GSO and
> GRO on from off state.
> 
> Now when TSO, GSO or GRO is turned off, MTU change does not turn them
> on.
> 
> Signed-off-by: Pawe? Jab?o?ski <pawel.jablonski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 18
> ++++++++++++++++++
>  1 file changed, 18 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


