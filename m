From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:48:57 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 10/17] RDMA/irdma: Add
 RoCEv2 UD OP support
In-Reply-To: <20190629185405.1601-11-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-11-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4056A5@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 10/17] RDMA/irdma: Add
> RoCEv2 UD OP support
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Add the header, data structures and functions to populate the WQE
> descriptors and issue the Control QP commands that support RoCEv2 UD
> operations.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/uda.c   | 391
> ++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/uda.h   |  65 ++++++
>  drivers/infiniband/hw/irdma/uda_d.h | 383
> +++++++++++++++++++++++++++++++++++
>  3 files changed, 839 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/uda.c  create mode
> 100644 drivers/infiniband/hw/irdma/uda.h  create mode 100644
> drivers/infiniband/hw/irdma/uda_d.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


