From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:47:52 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 07/17] RDMA/irdma: Add
 connection manager
In-Reply-To: <20190629185405.1601-8-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-8-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40567A@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 07/17] RDMA/irdma: Add
> connection manager
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Add connection management (CM) implementation for
> iWARP including accept, reject, connect, create_listen,
> destroy_listen and CM utility functions
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/cm.c | 4514
> ++++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/cm.h |  415 ++++
>  2 files changed, 4929 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/cm.c
>  create mode 100644 drivers/infiniband/hw/irdma/cm.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


