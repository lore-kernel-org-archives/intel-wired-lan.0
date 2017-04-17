From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 17 Apr 2017 17:25:49 +0000
Subject: [Intel-wired-lan] [next PATCH S70 07/12] i40e:
	remove	I40E_FLAG_IN_NETPOLL entirely
In-Reply-To: <20170413084555.6962-7-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-7-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BEE4@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 07/12] i40e: remove
> I40E_FLAG_IN_NETPOLL entirely
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> This flag was originally intended to be used to let some driver code know
> when we were running from netpoll.
> Ultimately this was not necessary and we never used it.
> Let's remove it
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I43b72483d91c1638071d2a7f389ab171ec5b796a
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h | 2 --
>  1 file changed, 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
