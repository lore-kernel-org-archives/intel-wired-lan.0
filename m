From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 17:19:35 +0000
Subject: [Intel-wired-lan] [next PATCH S29 02/14] i40e: Fix led
	blink	capability for 10GBaseT PHY
In-Reply-To: <1455754344-6372-3-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-3-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F1EE@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S29 02/14] i40e: Fix led blink capability
> for 10GBaseT PHY
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch fixes a problem where the ethtool identify adapter functionality
> did not work for some copper PHY's.  Without this patch, the blink led
> functionality fails on some parts.  This patch adds PHY write code to blink led's
> on parts where this functionality is contained in the PHY rather than the
> MAC.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Iee7b3453f61d5ffd0b3d03f720ee4f17f919fcc2
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  3 +++
>  drivers/net/ethernet/intel/i40e/i40e_common.c  | 26
> +++++++++++++++++++  drivers/net/ethernet/intel/i40e/i40e_ethtool.c |
> 36 +++++++++++++++++++++-----
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 +++
>  4 files changed, 63 insertions(+), 6 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Adaptor LED blink functionality works properly on 10GBaseT PHY
