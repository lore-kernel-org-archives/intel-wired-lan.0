From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 20:40:47 +0000
Subject: [Intel-wired-lan] [next PATCH S17 03/11] i40e/i40evf: fix bug
 in	throttle rate math
In-Reply-To: <1443464220-148318-4-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-4-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2D4D@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S17 03/11] i40e/i40evf: fix bug in
> throttle rate math
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was using a value expressed in 2us increments for the divisor to
> figure out our bytes/usec values.
> 
> Fix the usecs variable to contain a value in microseconds.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I5c20493103c295d6f201947bb908add7040b7c41
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 9 ++++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 9 ++++++++-
>  2 files changed, 16 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
