From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 20:22:17 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Protect
 ixgbevf_reset_subtask	from remove event
In-Reply-To: <1468363658-29163-1-git-send-email-donald.c.skidmore@intel.com>
References: <1468363658-29163-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF31@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Tuesday, July 12, 2016 3:48 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Protect ixgbevf_reset_subtask
> from remove event
> 
> In ixgbevf_reset_subtask We weren't verifying that the port haven't been
> removed, we are with this patch.
> 
> Signed-off-by: Don Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
