From: Young, James M <james.m.young@intel.com>
Date: Fri, 5 Jun 2015 00:02:38 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: Make sure to be in VEB mode
 if	SRIOV is enabled at probe
In-Reply-To: <1432742774-69564-1-git-send-email-catherine.sullivan@intel.com>
References: <1432742774-69564-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA09FF5@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, May 27, 2015 9:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [net PATCH] i40e: Make sure to be in VEB mode if
> SRIOV is enabled at probe
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> If SRIOV is enabled we need to be in VEB mode not VEPA mode at probe.
> This fixes an NPAR bug when SRIOV is enabled in the BIOS.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ibf006abafd9a0ca3698ec24848cd771cf345cbbc
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

Tested with sriov turned off, bridging works, there is a DMESG notification that the driver came up in VEPA mode.  Pings outward over bridge do not cause messages in DMESG. 

