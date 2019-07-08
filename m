From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:46:14 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 03/17] RDMA/irdma: Implement
 HW Admin Queue OPs
In-Reply-To: <20190629185405.1601-4-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-4-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D405642@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 03/17] RDMA/irdma:
> Implement HW Admin Queue OPs
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> The driver posts privileged commands to the HW
> Admin Queue (Control QP or CQP) to request administrative
> actions from the HW. Implement create/destroy of CQP
> and the supporting functions, data structures and headers
> to handle the different CQP commands
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ctrl.c  | 5958
> +++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/defs.h  | 2126 +++++++++++++
>  drivers/infiniband/hw/irdma/irdma.h |  191 ++
>  drivers/infiniband/hw/irdma/type.h  | 1701 ++++++++++
>  4 files changed, 9976 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/ctrl.c
>  create mode 100644 drivers/infiniband/hw/irdma/defs.h
>  create mode 100644 drivers/infiniband/hw/irdma/irdma.h
>  create mode 100644 drivers/infiniband/hw/irdma/type.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


