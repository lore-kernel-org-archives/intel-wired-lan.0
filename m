From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 26 Nov 2019 19:43:21 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Register a virtbus device to
 provide RDMA
In-Reply-To: <20191120170150.36240-1-mustafa.ismail@intel.com>
References: <20191120170150.36240-1-mustafa.ismail@intel.com>
Message-ID: <ce6645da6a1f4608ad95ab824edc71bd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Mustafa Ismail
> Sent: Wednesday, November 20, 2019 9:02 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Ismail, Mustafa <mustafa.ismail@intel.com>; Devale, Sindhu
> <sindhu.devale@intel.com>; Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Register a virtbus device to provide
> RDMA
> 
> From: "Shiraz Saleem" <shiraz.saleem@intel.com>
> 
> Register client virtbus device on the virtbus for the RDMA virtbus driver
> (irdma) to bind to. It allows to realize a single RDMA driver capable of working
> with multiple netdev drivers over multi-generation Intel HW supporting
> RDMA.
> There is also no load ordering dependencies between i40e and irdma.
> 
> Summary of changes:
> * Support to add/remove virtbus devices
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
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 109 +++++++++++--
> drivers/net/ethernet/intel/i40e/i40e_client.h | 203 ------------------------
>  include/linux/net/intel/i40e_client.h         | 213
> ++++++++++++++++++++++++++
>  7 files changed, 310 insertions(+), 222 deletions(-)  delete mode 100644

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
