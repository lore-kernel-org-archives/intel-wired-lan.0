From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:29:03 +0000
Subject: [Intel-wired-lan] [next PATCH S9 6/7] i40e: Fix message for
 other card without FEC.
In-Reply-To: <20190826181655.15106-6-alice.michael@intel.com>
References: <20190826181655.15106-1-alice.michael@intel.com>
 <20190826181655.15106-6-alice.michael@intel.com>
Message-ID: <8dd0a8d99bd04090b97cc3bd8191d460@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Monday, August 26, 2019 11:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Zagorski, CzeslawX <czeslawx.zagorski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S9 6/7] i40e: Fix message for other
> card without FEC.
> 
> From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> 
> When variable "req_fec, fec, an" are empty, dmesg shows log with
> "Requested FEC: , Negotiated FEC: , Autoneg:".
> Add link dmesg log for cards without FEC.
> 
> Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


