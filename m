From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 5 Mar 2020 22:35:25 +0000
Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Register a virtbus device
 to provide RDMA
In-Reply-To: <20200302165154.1098-2-shiraz.saleem@intel.com>
References: <20200302165154.1098-1-shiraz.saleem@intel.com>
 <20200302165154.1098-2-shiraz.saleem@intel.com>
Message-ID: <1af6ad8f2d2a4b9f8041989f805a910b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Shiraz Saleem
> Sent: Monday, March 2, 2020 8:52 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Saleem, Shiraz <shiraz.saleem@intel.com>
> Subject: [Intel-wired-lan] [PATCH 2/2] i40e: Register a virtbus device to
> provide RDMA
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
>  drivers/net/ethernet/intel/Kconfig            |   1 +
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 131
> ++++++++++++++++++++++----
>  include/linux/net/intel/i40e_client.h         |  15 +++
>  3 files changed, 127 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
