From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 18 Jul 2017 23:09:48 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename
 vf_offload_flags	to vf_cap_flags in struct virtchnl_vf_resource
In-Reply-To: <20170629131225.9251-2-sassmann@kpanic.de>
References: <20170629131225.9251-1-sassmann@kpanic.de>
 <20170629131225.9251-2-sassmann@kpanic.de>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10DB2317@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Stefan Assmann
> Sent: Thursday, June 29, 2017 6:12 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; davem at davemloft.net; sassmann at kpanic.de
> Subject: [Intel-wired-lan] [PATCH 1/2] i40e/i40evf: rename vf_offload_flags
> to vf_cap_flags in struct virtchnl_vf_resource
> 
> The current name of vf_offload_flags indicates that the bitmap is limited to
> offload related features. Make this more generic by renaming it to
> vf_cap_flags, which allows for other capabilities besides offloading to be
> added.
> 
> Signed-off-by: Stefan Assmann <sassmann@kpanic.de>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 22 +++++++++++--------
> ---
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |  2 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         | 10 +++++-----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 12 ++++++------
>  include/linux/avf/virtchnl.h                       |  4 ++--
>  5 files changed, 25 insertions(+), 25 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


