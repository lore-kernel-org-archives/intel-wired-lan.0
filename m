From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 14 Mar 2018 23:31:31 +0000
Subject: [Intel-wired-lan] [PATCH S88 6/8] i40e: Prevent setting link
 speed on I40E_DEV_ID_25G_B
In-Reply-To: <20180314181918.21582-6-jeffrey.t.kirsher@intel.com>
References: <20180314181918.21582-1-jeffrey.t.kirsher@intel.com>
 <20180314181918.21582-6-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C2FD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 14, 2018 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S88 6/8] i40e: Prevent setting link speed on
> I40E_DEV_ID_25G_B
> 
> From: Patryk Ma?ek <patryk.malek@intel.com>
> 
> Setting link settings on backplane devices shouldn't be allowed.
> This patch adds one more device id to the list which we check that against.
> 
> Signed-off-by: Patryk Ma?ek <patryk.malek@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


