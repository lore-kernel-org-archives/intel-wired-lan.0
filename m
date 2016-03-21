From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Mar 2016 22:38:54 +0000
Subject: [Intel-wired-lan] [next PATCH S31 v4 04/12] i40e: Add new
 device ID	for X722
In-Reply-To: <1458328696-135941-5-git-send-email-avinash.dayanand@intel.com>
References: <1458328696-135941-1-git-send-email-avinash.dayanand@intel.com>
 <1458328696-135941-5-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99EC98@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Avinash Dayanand
> Sent: Friday, March 18, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S31 v4 04/12] i40e: Add new device ID
> for X722
> 
> From: Catherine Sullivan 1452637417 -0500 <catherine.sullivan@intel.com>
> 
> The new device ID is 0x37D3 and it should follow the same flows and
> branding string as for 0x37D0.
> 
> Testing Hints: Make sure the device loads.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Ia5ad4a1910268c4666a3fd46a7afffbec55b4fc2
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_devids.h   | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c     | 1 +
>  drivers/net/ethernet/intel/i40evf/i40e_common.c | 1 +
> drivers/net/ethernet/intel/i40evf/i40e_devids.h | 1 +
>  5 files changed, 5 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes correctly applied, device is correctly recognized with patch applied
