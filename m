From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 26 Aug 2016 16:23:15 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: Fix kernel panic
	on	enable/disable lldp
In-Reply-To: <1472116559-93975-1-git-send-email-david.m.ertman@intel.com>
References: <1472116559-93975-1-git-send-email-david.m.ertman@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FACDD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Dave Ertman
> Sent: Thursday, August 25, 2016 2:16 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] i40e: Fix kernel panic on
> enable/disable lldp
> 
> If DCB is configured on the link partner switch with an unsupported traffic
> class configuration (e.g. non-contiguous TCs), the driver is flagging DCB as
> disabled.  But, for future DCB LLDPDUs, the driver was checking if the
> interface was DCB capable instead of enabled.  This was causing a kernel
> panic when lldp was enabled/disabled on the link partner switch.
> 
> This patch corrects the situation by having the lldp event handler check the
> correct flag in the pf structure.  It also cleans up the setting and clearing of
> the enabled flag for other checks.
> 
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Base driver builds, compiles, and passes traffic, patch applied correctly


