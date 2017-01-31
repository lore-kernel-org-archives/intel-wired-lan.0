From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:27:50 +0000
Subject: [Intel-wired-lan] [next PATCH S58-V3 2/4] i40evf: add
	client	interface
In-Reply-To: <1485282241-3579-2-git-send-email-bimmy.pujari@intel.com>
References: <1485282241-3579-1-git-send-email-bimmy.pujari@intel.com>
 <1485282241-3579-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D75D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, January 24, 2017 10:24 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S58-V3 2/4] i40evf: add client
> interface
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> In preparation for upcoming RDMA-capable hardware, add a client interface
> to the VF driver. This is a slightly-simplified version of the PF client interface,
> with the names changed to protect the innocent.
> 
> Due to the nature of the VF<->PF interactions, the client interface
> sometimes needs to call back into itself to pass messages. Because of this,
> we can't use the coarse-grained locking like the PF's client interface uses.
> Instead, we handle all client interactions in a separate thread so the
> watchdog can still run and process virtual channel messages.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> ---
>  drivers/net/ethernet/intel/i40evf/Makefile         |   2 +-
>  drivers/net/ethernet/intel/i40evf/i40e_virtchnl.h  |  33 ++
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  24 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_client.c  | 563
> +++++++++++++++++++++
> drivers/net/ethernet/intel/i40evf/i40evf_client.h  | 166 ++++++
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    |  83 ++-
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  13 +-
>  7 files changed, 873 insertions(+), 11 deletions(-)  create mode 100644

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


