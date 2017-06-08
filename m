From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Jun 2017 18:24:04 +0000
Subject: [Intel-wired-lan] [next PATCH S72-V3 03/13] i40e: use
	dev_dbg	instead of dev_info when warning about missing routine
In-Reply-To: <20170607094313.32060-3-alice.michael@intel.com>
References: <20170607094313.32060-1-alice.michael@intel.com>
 <20170607094313.32060-3-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DAA8CE@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Wednesday, June 7, 2017 2:43 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S72-V3 03/13] i40e: use dev_dbg
> instead of dev_info when warning about missing routine
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> When searching for the vf_capability client routine, dev_info() was used,
> instead of the normal dev_dbg(). This causes the message to be displayed at
> standard log levels which can cause administrators to worry. Avoid this by
> using dev_dbg instead.
> 
> Copyright updated to 2017.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


