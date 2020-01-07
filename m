From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Jan 2020 23:28:16 +0000
Subject: [Intel-wired-lan] [net-next v3] i40e: remove unused defines
In-Reply-To: <20200107000933.906614-1-jeffrey.t.kirsher@intel.com>
References: <20200107000933.906614-1-jeffrey.t.kirsher@intel.com>
Message-ID: <d7126a86c6a5427db7d68d5ca97ab9d0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, January 6, 2020 4:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net-next v3] i40e: remove unused defines
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Remove all the unused defines as they are just dead weight.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: fix patch to apply to current dev-queue branch (where i40e_client.h
>     has moved to include/linux/net/intel/)
> v3: add back 2 defines that were still in use
> 
>  drivers/net/ethernet/intel/i40e/i40e.h        |   20 -
>  .../net/ethernet/intel/i40e/i40e_adminq_cmd.h |  482 +-
>  drivers/net/ethernet/intel/i40e/i40e_common.c |    4 -
>  drivers/net/ethernet/intel/i40e/i40e_dcb.h    |    5 -
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |    1 -
>  drivers/net/ethernet/intel/i40e/i40e_devids.h |    3 -
>  drivers/net/ethernet/intel/i40e/i40e_hmc.h    |    1 -
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |    3 -
>  drivers/net/ethernet/intel/i40e/i40e_osdep.h  |    1 -
>  .../net/ethernet/intel/i40e/i40e_register.h   | 4664 -----------------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |   25 -
>  drivers/net/ethernet/intel/i40e/i40e_type.h   |   81 -
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.h    |    1 -
>  include/linux/net/intel/i40e_client.h         |    5 -
>  14 files changed, 1 insertion(+), 5295 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


