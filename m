From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Jan 2017 21:33:16 +0000
Subject: [Intel-wired-lan] [next-queue v5 PATCH 1/7] i40e: Introduce
 devlink	interface
In-Reply-To: <1485392057-3261-2-git-send-email-sridhar.samudrala@intel.com>
References: <1485392057-3261-1-git-send-email-sridhar.samudrala@intel.com>
 <1485392057-3261-2-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D49C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Wednesday, January 25, 2017 4:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next-queue v5 PATCH 1/7] i40e: Introduce devlink
> interface
> 
> Add initial devlink support to get/set the mode of SRIOV switch.
> This patch sets the default mode as 'legacy' and enables getting the mode
> and and setting it to 'legacy'.
> 
> The switch mode can be get/set via following 'devlink' commands.
> 
> # devlink dev eswitch show pci/0000:05:00.0
> pci/0000:05:00.0: mode legacy
> # devlink dev eswitch set pci/0000:05:00.0 mode switchdev devlink answers:
> Operation not supported # devlink dev eswitch set pci/0000:05:00.0 mode
> legacy # devlink dev eswitch show pci/0000:05:00.0
> pci/0000:05:00.0: mode legacy
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Signed-off-by: Anjali Singhai <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig          |  1 +
>  drivers/net/ethernet/intel/i40e/i40e.h      |  3 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 80
> ++++++++++++++++++++++++++---
>  3 files changed, 76 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


