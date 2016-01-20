From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 19:17:36 +0000
Subject: [Intel-wired-lan] [v2 next PATCH S27 14/15] i40e: properly
	show	packet split status in debugfs
In-Reply-To: <1452732712-12248-15-git-send-email-joshua.a.hay@intel.com>
References: <1452732712-12248-1-git-send-email-joshua.a.hay@intel.com>
 <1452732712-12248-15-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988B74@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Wednesday, January 13, 2016 4:52 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [v2 next PATCH S27 14/15] i40e: properly show
> packet split status in debugfs
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Get rid of the unused hsplit field in the ring struct and use the existing macro
> to detect packet split enablement. This allows debugfs dumps of the VSI to
> properly show which rx routine is in use.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ic4e9589e6a788ab196ed0850703f704e30c03781
> ---
> Testing Hints: Enable/disable  packet split and dump the VSI through
> debugfs. Note the output.
> 
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    | 1 -
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h  | 1 -
>  3 files changed, 3 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, packet split shown correctly in debugfs output
