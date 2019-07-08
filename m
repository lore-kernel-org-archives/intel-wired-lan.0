From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 8 Jul 2019 17:47:28 +0000
Subject: [Intel-wired-lan] [PATCH rdma-next 06/17] RDMA/irdma: Add QoS
 definitions
In-Reply-To: <20190629185405.1601-7-shiraz.saleem@intel.com>
References: <20190629185405.1601-1-shiraz.saleem@intel.com>
 <20190629185405.1601-7-shiraz.saleem@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40566E@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH rdma-next 06/17] RDMA/irdma: Add QoS
> definitions
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Add definitions for managing the RDMA HW work scheduler (WS) tree.
> 
> A WS node is created via a control QP operation with the bandwidth
> allocation, arbitration scheme, and traffic class of the QP specified.
> The Qset handle returned associates the QoS parameters for the QP.
> The Qset is registered with the LAN and a equivalent node is created in the
> LAN packet scheduler tree.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/irdma/ws.c | 396
> +++++++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/irdma/ws.h |  40 ++++
>  2 files changed, 436 insertions(+)
>  create mode 100644 drivers/infiniband/hw/irdma/ws.c  create mode 100644
> drivers/infiniband/hw/irdma/ws.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


