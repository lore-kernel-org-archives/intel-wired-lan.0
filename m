From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 24 Nov 2015 22:55:07 +0000
Subject: [Intel-wired-lan] [V3: next PATCH S22 06/12] i40e: use
	explicit	cast from u16 to u8
In-Reply-To: <1447961665-12344-7-git-send-email-deepthi.kavalur@intel.com>
References: <1447961665-12344-1-git-send-email-deepthi.kavalur@intel.com>
 <1447961665-12344-7-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F8929C3@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Thursday, November 19, 2015 11:34 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Krawczyk, Kamil <kamil.krawczyk@intel.com>
> Subject: [Intel-wired-lan] [V3: next PATCH S22 06/12] i40e: use explicit cast
> from u16 to u8
> 
> From: Kamil Krawczyk <kamil.krawczyk@intel.com>
> 
> Current implementation generates compilation warnings.
> 
> Signed-off-by: Kamil Krawczyk <kamil.krawczyk@intel.com>
> Acked-by: Shannon Nelson <shannon.nelson@intel.com>
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Change-ID: Icceefb50fe62aefaf90a64afb7192e08355a4ec5
> ---
>  drivers/net/ethernet/intel/i40e/i40e_lan_hmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied
