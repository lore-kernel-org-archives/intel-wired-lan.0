From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 18 Feb 2016 17:18:32 +0000
Subject: [Intel-wired-lan] [next PATCH S29 01/14] i40e: Add functions
	to	blink led on 10GBaseT PHY
In-Reply-To: <1455754344-6372-2-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-2-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F1DD@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S29 01/14] i40e: Add functions to blink
> led on 10GBaseT PHY
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> This patch adds functions to blink led on devices using 10GBaseT PHY since
> MAC registers used in other designs do not work in this device configuration.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Change-ID: Id4b88c93c649fd2b88073a00b42867a77c761ca3
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 329
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h   |  13 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |  16 +
>  drivers/net/ethernet/intel/i40evf/i40e_prototype.h |   7 +
>  4 files changed, 365 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Adaptor LED blink functionality works properly on 10GBaseT PHY
