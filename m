From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:45:14 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 01/17] RDMA/irdma: Add
 driver framework definitions
In-Reply-To: <20190629185405.1601-2-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-2-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D404623@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shiraz Saleem
> Sent: Saturday, June 29, 2019 11:54 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH rdma-next 01/17] RDMA/irdma: Add driver
> framework definitions
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Register irdma as a platform driver capable of supporting platform
> devices from multi-generation RDMA capable Intel HW. Establish the
> interface with all supported netdev peer devices and initialize HW.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/i40iw_if.c | 256 +++++++++++++
>  drivers/infiniband/hw/irdma/irdma_if.c | 426 ++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/main.c     | 531
> +++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/main.h     | 639
> +++++++++++++++++++++++++++++++++
>  4 files changed, 1852 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/i40iw_if.c
>  create mode 100644 drivers/infiniband/hw/irdma/irdma_if.c
>  create mode 100644 drivers/infiniband/hw/irdma/main.c
>  create mode 100644 drivers/infiniband/hw/irdma/main.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


