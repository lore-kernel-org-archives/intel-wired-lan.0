From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Tue, 25 Aug 2020 19:40:18 +0200
Subject: [Intel-wired-lan] [PATCH net v3 0/3] Avoid premature Rx buffer
 reuse for XDP_REDIRECT
In-Reply-To: <20200825172736.27318-1-bjorn.topel@gmail.com>
References: <20200825172736.27318-1-bjorn.topel@gmail.com>
Message-ID: <20200825174018.GA41513@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, Aug 25, 2020 at 07:27:33PM +0200, Bj?rn T?pel wrote:

[...]

> 
> v2->v3: Fixed kdoc for i40e/ice. (Jakub)
> v1->v2: Removed page count function into get Rx buffer function, and
>         changed scope of automatic variable. (Maciej)
> 

For the series:
Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

> 
> Bj?rn T?pel (3):
>   i40e: avoid premature Rx buffer reuse
>   ixgbe: avoid premature Rx buffer reuse
>   ice: avoid premature Rx buffer reuse
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 27 ++++++++++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.c     | 30 +++++++++++++------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 24 ++++++++++-----
>  3 files changed, 58 insertions(+), 23 deletions(-)
> 
> 
> base-commit: 99408c422d336db32bfab5cbebc10038a70cf7d2
> -- 
> 2.25.1
> 
