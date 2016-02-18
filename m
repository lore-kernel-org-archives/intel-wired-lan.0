From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 18:22:18 +0000
Subject: [Intel-wired-lan] [next PATCH S29 03/14] i40e: Increase
	timeout	when checking GLGEN_RSTAT_DEVSTATE bit
In-Reply-To: <1455754344-6372-4-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-4-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F216@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Wednesday, February 17, 2016 4:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S29 03/14] i40e: Increase timeout
> when checking GLGEN_RSTAT_DEVSTATE bit
> 
> From: Kevin Scott <kevin.c.scott@intel.com>
> 
> When linking with particular PHY types (ex: copper PHY), the amount of time
> it takes for the GLGEN_RSTAT_DEVSTATE to be set increases greatly, which
> can lead to a timeout and failure to load the driver.
> 
> Signed-off-by: Kevin Scott <kevin.c.scott@intel.com>
> Change-ID: If02be0dfcd7c57fdde2d5c81cd63651260cd2029
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver loads correctly, driver and device properly recover from resets with link
