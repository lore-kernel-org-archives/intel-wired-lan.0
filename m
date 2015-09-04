From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 4 Sep 2015 21:45:08 +0000
Subject: [Intel-wired-lan] [next PATCH S11 02/15] i40e: enable WoL
 operation	if config bit show WoL capable
In-Reply-To: <1440616461-110869-3-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A58C5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 02/15] i40e: enable WoL operation
> if config bit show WoL capable
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> The driver was disabling Wake-on-LAN by default and waiting for the user to
> expressly turn it on.  This patch has the driver turning on WoL from the start if
> enabled in the hardware config, which matches the behavior of our other
> drivers.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I43faedb907f8ba4d1a61b72a7c86072b97af12b1
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
WoL shows "g" in ethtool on initial setup, old driver showed "d" unless it was specifically enabled with ethtool. Code changes present in tree.

