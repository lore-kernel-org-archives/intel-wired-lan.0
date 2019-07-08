From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:48:34 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 09/17] RDMA/irdma: Implement
 device supported verb APIs
In-Reply-To: <20190629185405.1601-10-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-10-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D405695@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 09/17] RDMA/irdma:
> Implement device supported verb APIs
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Implement device supported verb APIs. The supported APIs
> vary based on the underlying transport the ibdev is
> registered as (i.e. iWARP or RoCEv2).
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/verbs.c      | 4347
> ++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/verbs.h      |  199 ++
>  include/uapi/rdma/rdma_user_ioctl_cmds.h |    1 +
>  3 files changed, 4547 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/verbs.c
>  create mode 100644 drivers/infiniband/hw/irdma/verbs.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
