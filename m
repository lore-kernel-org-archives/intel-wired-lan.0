From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 28 Dec 2015 17:55:40 +0000
Subject: [Intel-wired-lan] [next PATCH S25 12/16] i40evf: enable bus
 master	after reset
In-Reply-To: <1450901156-30904-13-git-send-email-deepthi.kavalur@intel.com>
References: <1450901156-30904-1-git-send-email-deepthi.kavalur@intel.com>
 <1450901156-30904-13-git-send-email-deepthi.kavalur@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F97B5A8@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Deepthi Kavalur
> Sent: Wednesday, December 23, 2015 12:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S25 12/16] i40evf: enable bus master
> after reset
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the VF is reset via VFLR, the device will be knocked out of bus master
> mode, and the driver will fail to recover from the reset. Fix this by enabling
> bus mastering after every reset. In a non-VFLR case, the bus master bit will
> not be disabled, and this call will have no effect.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Id515859ac7a691db478222228add6d149e96801a
> ---
> Testing-Hints:
> Initiate a VFLR using "setpci -s <pci location of VF> CAP_EXP+8.W=8000"
> 
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, driver properly recovers from reset
