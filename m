From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:49:35 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 12/17] RDMA/irdma: Add
 miscellaneous utility definitions
In-Reply-To: <20190629185405.1601-13-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-13-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4056C0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 12/17] RDMA/irdma: Add
> miscellaneous utility definitions
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Add miscellaneous utility functions and headers.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/osdep.h  |  108 ++
>  drivers/infiniband/hw/irdma/protos.h |   96 ++
>  drivers/infiniband/hw/irdma/status.h |   70 +
>  drivers/infiniband/hw/irdma/utils.c  | 2333
> ++++++++++++++++++++++++++++++++++
>  4 files changed, 2607 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/osdep.h
>  create mode 100644 drivers/infiniband/hw/irdma/protos.h
>  create mode 100644 drivers/infiniband/hw/irdma/status.h
>  create mode 100644 drivers/infiniband/hw/irdma/utils.c

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
