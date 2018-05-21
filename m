From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 May 2018 18:27:20 +0000
Subject: [Intel-wired-lan] [PATCH] i40iw: Remove link dependency on i40e
In-Reply-To: <20180521170345.21706-1-sindhu.devale@intel.com>
References: <20180521170345.21706-1-sindhu.devale@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1B771CB9@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Devale Sindhu
> Sent: Monday, May 21, 2018 10:04 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Devale, Sindhu <sindhu.devale@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40iw: Remove link dependency on i40e
> 
> From: Sindhu Devale <sindhu.devale@intel.com>
> 
> Currently i40iw is dependent on i40e symbols i40e_register_client and
> i40e_unregister_client due to which i40iw cannot be loaded without i40e
> being loaded.
> 
> This patch allows rdma driver to build and load without linking to LAN driver
> and without LAN driver being loaded first. Once the LAN driver is loaded, the
> rdma driver is notified through the netdevice notifiers to register as client to
> the LAN driver. Add function pointers to IDC register/unregister in the
> private VSI structure. This allows a RDMA driver to build without linking to
> I40E.
> 
> Signed-off-by: Devale Sindhu <sindhu.devale@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/i40iw.h           |  24 +++
>  drivers/infiniband/hw/i40iw/i40iw_main.c      | 141 ++++++++++++++++--
>  drivers/infiniband/hw/i40iw/i40iw_utils.c     |   5 +-
>  drivers/net/ethernet/intel/i40e/i40e.h        |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_client.h |   9 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |   6 +
>  6 files changed, 173 insertions(+), 13 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


