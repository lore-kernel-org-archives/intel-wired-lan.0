From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Mar 2016 16:14:48 +0000
Subject: [Intel-wired-lan] [next PATCH S30 v3 01/13] i40e/i40evf:
	Fix	casting in transmit code
In-Reply-To: <1457650791-100229-2-git-send-email-avinash.dayanand@intel.com>
References: <1457650791-100229-1-git-send-email-avinash.dayanand@intel.com>
 <1457650791-100229-2-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99D2F6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of ajdayana
> Sent: Thursday, March 10, 2016 3:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S30 v3 01/13] i40e/i40evf: Fix casting
> in transmit code
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
>     Simple cast to fix a sparse warning.
> 
>     Testing Hints: Test with sparse compile (make
>     sparse)
> 
> Fixes: commit 5453205cd097 ("i40e/i40evf: Enable support for
> SKB_GSO_UDP_TUNNEL_CSUM")
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 5 +++--
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 5 +++--
>  2 files changed, 6 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
No errors from Sparse when compiling i40e code
