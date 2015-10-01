From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 17:51:55 +0000
Subject: [Intel-wired-lan] [next PATCH S16 09/15] i40e/i40evf: grab the
 AQ	spinlocks before clearing registers
In-Reply-To: <1443463964-148204-10-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2C52@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 09/15] i40e/i40evf: grab the AQ
> spinlocks before clearing registers
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Make sure we have the spinlocks before we clear the ARQ and ASQ
> management registers.  Also, widen the locked portion and make a sanity
> check earlier in the send function to be sure we're working with safe register
> values.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I34b56044b33461ed780f3d2de8d62826cdf933f9
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq.c   | 45 +++++++++++++-------
> -----
>  drivers/net/ethernet/intel/i40evf/i40e_adminq.c | 45 +++++++++++++------
> ------
>  2 files changed, 46 insertions(+), 44 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
