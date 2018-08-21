From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Tue, 21 Aug 2018 21:09:14 +0000
Subject: [Intel-wired-lan] [PATCH v3 14/15] ice: Introduce SERVICE_DIS
 flag and service routine functions
In-Reply-To: <20180809132958.23036-15-anirudh.venkataramanan@intel.com>
References: <20180809132958.23036-1-anirudh.venkataramanan@intel.com>
 <20180809132958.23036-15-anirudh.venkataramanan@intel.com>
Message-ID: <C25D919FD1849B409D8D987DDC7FCD26195458DA@ORSMSX109.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Thursday, August 9, 2018 6:30 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 14/15] ice: Introduce SERVICE_DIS flag
> and service routine functions
> 
> From: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> 
> This patch introduces SERVICE_DIS flag to use for stopping service task.
> This flag will be checked before scheduling new tasks. Also add new
> functions ice_service_task_stop to stop service task.
> 
> Signed-off-by: Akeem G Abodunrin <akeem.g.abodunrin@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h      |  1 +
>  drivers/net/ethernet/intel/ice/ice_main.c | 34 ++++++++++++++++++-----
>  2 files changed, 28 insertions(+), 7 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com>


