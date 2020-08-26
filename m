From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Wed, 26 Aug 2020 23:22:44 +0000
Subject: [Intel-wired-lan] [PATCH -next v2] net: ice: Fix pointer cast
 warnings
In-Reply-To: <5af7c5af-c45d-2174-de89-8b89eddb4f4d@huawei.com>
References: <20200731105721.18511-1-cuibixuan@huawei.com>
 <5af7c5af-c45d-2174-de89-8b89eddb4f4d@huawei.com>
Message-ID: <DM6PR11MB289004F11B8936F7C421A863BC540@DM6PR11MB2890.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Bixuan Cui <cuibixuan@huawei.com>
> Sent: Friday, July 31, 2020 3:08 AM
> To: davem at davemloft.net; kuba at kernel.org
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org; linux-next at vger.kernel.org
> Subject: [PATCH -next v2] net: ice: Fix pointer cast warnings
> 
> pointers should be casted to unsigned long to avoid
> -Wpointer-to-int-cast warnings:
> 
> drivers/net/ethernet/intel/ice/ice_flow.h:197:33: warning:
>     cast from pointer to integer of different size
> drivers/net/ethernet/intel/ice/ice_flow.h:198:32: warning:
>     cast to pointer from integer of different size
> 
> Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
> ---
> v2->v1: add fix:
>  ice_flow.h:198:32: warning: cast to pointer from integer of different size [-
> Wint-to-pointer-cast]
>  #define ICE_FLOW_ENTRY_PTR(h) ((struct ice_flow_entry *)(h))
> 
>  drivers/net/ethernet/intel/ice/ice_flow.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
