From: Young, James M <james.m.young@intel.com>
Date: Thu, 2 Jul 2015 20:50:27 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 v2
 05/10]	i40e/i40evf: RSS changes for X722
In-Reply-To: <1435100404-14660-1-git-send-email-catherine.sullivan@intel.com>
References: <1435100404-14660-1-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C4A2@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Tuesday, June 23, 2015 4:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Singhai, Anjali
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH S07 v2 05/10]
> i40e/i40evf: RSS changes for X722
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> X722 uses the admin queue to configure RSS. This patch adds the necessary
> flow changes to configure RSS through AQ. It also adds the separate VMDQ2
> lookup tables and hash key programming for X722.
> 
> X722 also exposes a different set of PCTYPES for RSS, this patch
> accommodates those changes.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
> v2: Use adapter->num_active_queues instead of adapter->vsi_res-
> >num_queue_pairs
>     in i40evf.
> 
>  drivers/net/ethernet/intel/i40e/i40e.h             |   7 +-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 156 ++++++++++++++----
> -
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  12 ++
>  drivers/net/ethernet/intel/i40e/i40e_type.h        |  15 +-
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  11 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  12 ++
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      |  15 +-
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 166
> ++++++++++++++++-----
>  9 files changed, 307 insertions(+), 89 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>

