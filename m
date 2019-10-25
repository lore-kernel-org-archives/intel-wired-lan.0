From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 25 Oct 2019 23:39:36 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Register multi-function device
 to provide RDMA
In-Reply-To: <20191017164004.1645-1-shiraz.saleem@intel.com>
References: <20191017164004.1645-1-shiraz.saleem@intel.com>
Message-ID: <039c341de6644fea8a20fe59d41831f1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shiraz Saleem
> Sent: Thursday, October 17, 2019 9:40 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Saleem, Shiraz
> <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Register multi-function device to
> provide RDMA
> 
> From: Mustafa Ismail <mustafa.ismail@intel.com>
> 
> Register multi-function devices (MFD) for the RDMA platform function
> (irdma) driver to bind to. It realizes a single RDMA driver capable of working
> with multiple LAN drivers over multi-generation Intel HW supporting RDMA.
> There is also no load ordering dependencies between i40e and irdma.
> 
> Summary of changes:
> * Support to add/remove MFD devices
> * Add 2 new client ops.
> 	* i40e_client_device_register() which is called during RDMA
> 	  probe() per PF. Validate client drv OPs and schedule service
> 	  task to call open()
> 	* i40e_client_device_unregister() called during RDMA remove()
> 	  per PF. Call client close() and release_qvlist.
> * The global register/unregister calls exported for i40iw are retained
>   until i40iw is removed from the kernel.
> 
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> ---
>  drivers/infiniband/hw/i40iw/Makefile          |   1 -
>  drivers/infiniband/hw/i40iw/i40iw.h           |   2 +-
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/i40e/i40e.h        |   3 +-
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 138 ++++++++++++++--
> drivers/net/ethernet/intel/i40e/i40e_client.h | 203 -----------------------
>  include/linux/net/intel/i40e_client.h         | 224
> ++++++++++++++++++++++++++
>  7 files changed, 350 insertions(+), 222 deletions(-)  delete mode 100644
> drivers/net/ethernet/intel/i40e/i40e_client.h
>  create mode 100644 include/linux/net/intel/i40e_client.h

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


