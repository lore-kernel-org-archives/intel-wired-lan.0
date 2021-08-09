From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 9 Aug 2021 10:08:47 +0000
Subject: [Intel-wired-lan] [PATCH net-next 7/7] ice: Fix macro name for
 IPv4 fragment flag
In-Reply-To: <20210716221644.45946-8-anthony.l.nguyen@intel.com>
References: <20210716221644.45946-1-anthony.l.nguyen@intel.com>
 <20210716221644.45946-8-anthony.l.nguyen@intel.com>
Message-ID: <BYAPR11MB33673D166DD721B3F127A2BBFCF69@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Saturday, July 17, 2021 3:47 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next 7/7] ice: Fix macro name for IPv4
> fragment flag
> 
> From: Jeff Guo <jia.guo@intel.com>
> 
> In IPv4 header, fragment flags indicate whether the packet needs to be
> fragmented or not. The value 0x20 represents MF (More Fragment); fix the
> macro name to match this.
> 
> Signed-off-by: Ting Xu <ting.xu@intel.com>
> Signed-off-by: Jeff Guo <jia.guo@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_fdir.c | 2 +-
> drivers/net/ethernet/intel/ice/ice_fdir.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
