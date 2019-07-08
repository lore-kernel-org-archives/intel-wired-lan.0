From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:49:50 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 13/17] RDMA/irdma: Add
 dynamic tracing for CM
In-Reply-To: <20190629185405.1601-14-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-14-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D4056C7@ORSMSX104.amr.corp.intel.com>
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
> Cc: Ruhl, Michael J <michael.j.ruhl@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH rdma-next 13/17] RDMA/irdma: Add
> dynamic tracing for CM
> 
> From: "Michael J. Ruhl" <michael.j.ruhl@intel.com>
> 
> Add dynamic tracing functionality to debug connection management issues.
> 
> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/trace.c    | 113 ++++++++
>  drivers/infiniband/hw/irdma/trace.h    |   4 +
>  drivers/infiniband/hw/irdma/trace_cm.h | 459
> +++++++++++++++++++++++++++++++++
>  3 files changed, 576 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/trace.c
>  create mode 100644 drivers/infiniband/hw/irdma/trace.h
>  create mode 100644 drivers/infiniband/hw/irdma/trace_cm.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
