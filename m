From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 30 Oct 2017 19:01:17 +0000
Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 5/6] i40e:
 Clean up	of cloud filters
In-Reply-To: <150909695619.48377.144660296731703103.stgit@anamdev.jf.intel.com>
References: <150909628755.48377.16561267691881106259.stgit@anamdev.jf.intel.com>
 <150909695619.48377.144660296731703103.stgit@anamdev.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EADBAC@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [jkirsher/next-queue PATCH v5 5/6] i40e: Clean up
> of cloud filters
> 
> Introduce the cloud filter datastructure and cleanup of cloud filters
> associated with the device.
> 
> v5: Fixed a typo.
> v2: Moved field comments in struct i40e_cloud_filter to the right.
> Removed hlist_empty check from i40e_cloud_filter_exit()
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |    9 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c |   24
> ++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


