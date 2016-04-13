From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:59:19 +0000
Subject: [Intel-wired-lan] [next PATCH S33 08/13] i40e: Add DeviceID
	for	X722 QSFP+
In-Reply-To: <1460475052-6348-9-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-9-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0760@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Krawczyk, Kamil <kamil.krawczyk@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S33 08/13] i40e: Add DeviceID for X722
> QSFP+
> 
> From: Kamil Krawczyk <kamil.krawczyk@intel.com>
> 
> Signed-off-by: Kamil Krawczyk <kamil.krawczyk@intel.com>
> Change-ID: I1370fbc7774e815ac1ad56561e97488e829592fc
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
> drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 +
>  4 files changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes applied, driver compiles correctly, hardware not available until WW24+
