From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 26 Oct 2015 16:03:02 +0000
Subject: [Intel-wired-lan] [next PATCH S19 01/15] i40e/i40evf: remove
 unused	tunnel parameter
In-Reply-To: <1445471236-35918-2-git-send-email-catherine.sullivan@intel.com>
References: <1445471236-35918-1-git-send-email-catherine.sullivan@intel.com>
 <1445471236-35918-2-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D3E32@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, October 21, 2015 4:47 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S19 01/15] i40e/i40evf: remove
> unused tunnel parameter
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Code was moved into a separate function some time ago.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: Icabbe71ce05cf5d716d3e1152cdd9cd41d11bcb5
> 
> ---
> Testing-hints: Internal code change, check that the patch was applied and
> compiled correctly.
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 11 ++++-------
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c |  8 +++-----
>  2 files changed, 7 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
