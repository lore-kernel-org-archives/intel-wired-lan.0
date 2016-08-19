From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Aug 2016 21:52:25 +0000
Subject: [Intel-wired-lan] [dev-queue PATCH v2 3/3] i40e: Introduce
 devlink	interface.
In-Reply-To: <1471542901-13405-4-git-send-email-sridhar.samudrala@intel.com>
References: <1471542901-13405-1-git-send-email-sridhar.samudrala@intel.com>
 <1471542901-13405-4-git-send-email-sridhar.samudrala@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F9439@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Sridhar Samudrala
> Sent: Thursday, August 18, 2016 10:55 AM
> To: intel-wired-lan at lists.osuosl.org; Singhai, Anjali
> <anjali.singhai@intel.com>; Fastabend, John R
> <john.r.fastabend@intel.com>; Nambiar, Amritha
> <amritha.nambiar@intel.com>; Duyck, Alexander H
> <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] [dev-queue PATCH v2 3/3] i40e: Introduce devlink
> interface.
> 
> Add initial devlink support to set/get the mode of SRIOV switch.
> By default the switch mode is set to 'switchdev' as VF Port representors are
> created by default.
> This patch allows the mode to be set to 'legacy' to disable creation of VF Port
> representor netdevs.
> 
> With smode support in iproute2 'devlink' utility, switch mode can be set and
> get via following commands.
> 
>     # devlink dev smode pci/0000:05:00.0
>     mode: switchdev
>     # devlink dev set pci/0000:05:00.0 smode legacy
>     # devlink dev smode pci/0000:05:00.0
>     mode: legacy
> 
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>  drivers/net/ethernet/intel/Kconfig                 |  1 +
>  drivers/net/ethernet/intel/i40e/i40e.h             |  3 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 91
> ++++++++++++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  6 +-
>  4 files changed, 91 insertions(+), 10 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Works as expected
