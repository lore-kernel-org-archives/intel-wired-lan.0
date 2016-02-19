From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Feb 2016 00:39:54 +0000
Subject: [Intel-wired-lan] [next PATCH S29 09/14] i40e: add adminq
 commands	for rx ctl registers
In-Reply-To: <1455754344-6372-10-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-10-git-send-email-avinash.dayanand@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F98F411@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S29 09/14] i40e: add adminq
> commands for rx ctl registers
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add the new opcodes and struct used for asking the firmware to update Rx
> control registers that need extra care when being accessed while under
> heavy traffic - e.g. sustained 64byte packets at line rate on all ports.
> The firmware will take extra steps to be sure the register accesses are
> successful.
> 
> The registers involved are:
> 	PFQF_CTL_0
> 	PFQF_HENA
> 	PFQF_FDALLOC
> 	PFQF_HREGION
> 	PFLAN_QALLOC
> 	VPQF_CTL
> 	VFQF_HENA
> 	VFQF_HREGION
> 	VSIQF_CTL
> 	VSILAN_QBASE
> 	VSILAN_QTABLE
> 	VSIQF_TCREGION
> 	PFQF_HKEY
> 	VFQF_HKEY
> 	PRTQF_CTL_0
> 	GLFCOE_RCTL
> 	GLFCOE_RSOF
> 	GLQF_CTL
> 	GLQF_SWAP
> 	GLQF_HASH_MSK
> 	GLQF_HASH_INSET
> 	GLQF_HSYM
> 	GLQF_FC_MSK
> 	GLQF_FC_INSET
> 	GLQF_FD_MSK
> 	PRTQF_FD_INSET
> 	PRTQF_FD_FLXINSET
> 	PRTQF_FD_MSK
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I56c8144000da66ad99f68948d8a184b2ec2aeb3e
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h   | 16
> ++++++++++++++++
>  drivers/net/ethernet/intel/i40evf/i40e_adminq_cmd.h | 16
> ++++++++++++++++
>  2 files changed, 32 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
AQ-RSS functions work properly and change under load without error
