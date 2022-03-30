From: Nagaraju, Shwetha <shwetha.nagaraju@intel.com>
Date: Wed, 30 Mar 2022 10:20:07 +0000
Subject: [Intel-wired-lan] [PATCH intel-net 2/3] ice: xsk: fix VSI state
 check in ice_xsk_wakeup()
In-Reply-To: <20220317183629.340350-3-maciej.fijalkowski@intel.com>
References: <20220317183629.340350-1-maciej.fijalkowski@intel.com>
 <20220317183629.340350-3-maciej.fijalkowski@intel.com>
Message-ID: <MW4PR11MB5822077DEE9490C0874EF2D4901F9@MW4PR11MB5822.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Friday, March 18, 2022 12:06 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org; kuba at kernel.org; bpf at vger.kernel.org;
> davem at davemloft.net; Karlsson, Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-net 2/3] ice: xsk: fix VSI state check in
> ice_xsk_wakeup()
> 
> ICE_DOWN is dedicated for pf->state. Check for ICE_VSI_DOWN being set on
> vsi->state in ice_xsk_wakeup().
> 
> Fixes: 2d4238f55697 ("ice: Add support for AF_XDP")
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_xsk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Tested-by: Shwetha Nagaraju <Shwetha.nagaraju@intel.com> 

