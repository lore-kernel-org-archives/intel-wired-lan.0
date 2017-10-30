From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 19:00:10 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 3/6] i40e:
 Cloud filter mode for set_switch_config command
In-Reply-To: <150909694558.48377.8867082077822857739.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909694558.48377.8867082077822857739.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADB90@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Amritha Nambiar
> Sent: Friday, October 27, 2017 2:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Cc: jiri at resnulli.us; netdev at vger.kernel.org; jhs at mojatatu.com;
> xiyou.wangcong at gmail.com
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 3/6] i40e: Cloud
> filter mode for set_switch_config command
> 
> Add definitions for L4 filters and switch modes based on cloud filters modes
> and extend the set switch config command to include the additional cloud
> filter mode.
> 
> v5: Addressed Shannon's comments to format ':'s and changed names to
> I40E_CLOUD_FILTER_MODEx
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |   30
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c     |    4 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c       |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h  |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h       |    9 ++++++
>  6 files changed, 44 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


