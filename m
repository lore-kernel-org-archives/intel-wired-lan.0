From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 28 Jul 2015 21:22:43 +0000
Subject: [Intel-wired-lan] [next PATCH S9 12/15] i40e: refactor
 interrupt	enable
In-Reply-To: <1437684884-222825-13-git-send-email-catherine.sullivan@intel.com>
References: <1437684884-222825-1-git-send-email-catherine.sullivan@intel.com>
 <1437684884-222825-13-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A016BE557@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, July 23, 2015 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S9 12/15] i40e: refactor interrupt
> enable
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The interrupt enable function was always making the caller add the
> base_vector from the vsi struct which is already passed to the function. Just
> collapse the math into the helper function.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: I54ef33aa7ceebc3231c3cc48f7b39fd0c3ff5806
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 10 ++++------
> drivers/net/ethernet/intel/i40e/i40e_txrx.c |  6 ++----
>  2 files changed, 6 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Present in git log, code changes present in tree.
