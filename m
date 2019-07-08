From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:45:34 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 02/17] RDMA/irdma: Implement
 device initialization definitions
In-Reply-To: <20190629185405.1601-3-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-3-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D405631@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 02/17] RDMA/irdma:
> Implement device initialization definitions
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Implement device initialization routines, interrupt set-up,
> and allocate object bit-map tracking structures.
> Also, add device specific attributes and register definitions.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/hw.c        | 2563
> +++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/i40iw_hw.c  |  210 +++
>  drivers/infiniband/hw/irdma/i40iw_hw.h  |  163 ++
>  drivers/infiniband/hw/irdma/icrdma_hw.c |   75 +
>  drivers/infiniband/hw/irdma/icrdma_hw.h |   63 +
>  5 files changed, 3074 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/hw.c
>  create mode 100644 drivers/infiniband/hw/irdma/i40iw_hw.c
>  create mode 100644 drivers/infiniband/hw/irdma/i40iw_hw.h
>  create mode 100644 drivers/infiniband/hw/irdma/icrdma_hw.c
>  create mode 100644 drivers/infiniband/hw/irdma/icrdma_hw.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


