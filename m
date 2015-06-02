From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Tue, 2 Jun 2015 23:36:31 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: Make sure to be in VEB mode
 if	SRIOV is enabled at probe
Message-ID: <253CF818969A9240AB2054BF91F2C2BC300B819D@ORSMSX114.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [net PATCH] i40e: Make sure to be in VEB mode
> if SRIOV is enabled at probe
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> If SRIOV is enabled we need to be in VEB mode not VEPA mode at probe.
> This fixes an NPAR bug when SRIOV is enabled in the BIOS.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Change-ID: Ibf006abafd9a0ca3698ec24848cd771cf345cbbc

Jeff please prioritize this patch, as we have distros waiting for it.  I've asked Jim to test it ASAP.  I would like it to be sent to davem no later than Friday AM, if at all possible.




