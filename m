From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 8 Jul 2020 20:43:50 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/4] i40e: use 16B HW
 descriptors instead of 32B
In-Reply-To: <20200702153730.575738-3-bjorn.topel@gmail.com>
References: <20200702153730.575738-1-bjorn.topel@gmail.com>
 <20200702153730.575738-3-bjorn.topel@gmail.com>
Message-ID: <BN6PR1101MB2145C9D8E5348A0B38B332F48C670@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Bj?rn T?pel
> Sent: Thursday, July 2, 2020 8:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; bpf at vger.kernel.org; Topel, Bjorn
> <bjorn.topel@intel.com>; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH net-next 2/4] i40e: use 16B HW descriptors
> instead of 32B
> 
> From: Bj?rn T?pel <bjorn.topel@intel.com>
> 
> The i40e NIC supports two flavors of HW descriptors, 16 and 32 byte. The
> latter has, obviously, room for more offloading information. However, the
> only fields of the 32B HW descriptor that is being used by the driver, is also
> available in the 16B descriptor.
> 
> In other words; Reading and writing 32 bytes instead of 16 byte is a waste of
> bus bandwidth.
> 
> This commit starts using 16 byte descriptors instead of 32 byte descriptors.
> 
> For AF_XDP the rx_drop benchmark was improved by 2%.
> 
> Signed-off-by: Bj?rn T?pel <bjorn.topel@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c | 10 ++++------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_trace.h   |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  6 +++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h    |  5 ++++-
>  7 files changed, 18 insertions(+), 17 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


