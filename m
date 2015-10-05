From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 21:21:53 +0000
Subject: [Intel-wired-lan] [next PATCH S17 02/11] i40e/i40evf: refactor
 irq	enable function
In-Reply-To: <1443464220-148318-3-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B3617@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 02/11] i40e/i40evf: refactor irq
> enable function
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> This change moves a multi-line register setting into a function which
> simplifies reading the flow of the enable function.
> 
> This also fixes a bug where the enable function was enabling the interrupt
> twice while trying to update the two interrupt throttle rate thresholds for rx
> and tx.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ie308f9d0d48540204590cb9d7a5a7b1196f959bb
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 112 +++++++++++++++-------
> ----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 108 ++++++++++++++-------
> ----
>  2 files changed, 128 insertions(+), 92 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, does not break base driver functionality/compile
