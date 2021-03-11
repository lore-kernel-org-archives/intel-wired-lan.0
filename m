From: Bhandare, KiranX <kiranx.bhandare@intel.com>
Date: Thu, 11 Mar 2021 12:06:36 +0000
Subject: [Intel-wired-lan] [PATCH intel-net] ice: fix napi work done
 reporting in xsk path
In-Reply-To: <20210205090904.20794-1-magnus.karlsson@gmail.com>
References: <20210205090904.20794-1-magnus.karlsson@gmail.com>
Message-ID: <DM6PR11MB3292201BF7BF036D5A55D9AAF1909@DM6PR11MB3292.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Friday, February 5, 2021 2:39 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Nguyen, Anthony
> L <anthony.l.nguyen@intel.com>; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; maciejromanfijalkowski at gmail.com
> Cc: netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH intel-net] ice: fix napi work done reporting
> in xsk path
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Fix the wrong napi work done reporting in the xsk path of the ice driver. The
> code in the main Rx processing loop was written to assume that the buffer
> allocation code returns true if all allocations where successful and false if
> not. In contrast with all other Intel NIC xsk drivers, the ice_alloc_rx_bufs_zc()
> has the inverted logic messing up the work done reporting in the napi loop.
> 
> This can be fixed either by inverting the return value from
> ice_alloc_rx_bufs_zc() in the function that uses this in an incorrect way, or by
> changing the return value of ice_alloc_rx_bufs_zc(). We chose the latter as it
> makes all the xsk allocation functions for Intel NICs behave in the same way.
> My guess is that it was this unexpected discrepancy that gave rise to this bug
> in the first place.
> 
> Fixes: 5bb0c4b5eb61 ("ice, xsk: Move Rx allocation out of while-loop")
> Reported-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c |  6 ++++--
> drivers/net/ethernet/intel/ice/ice_xsk.c  | 10 +++++-----
>  2 files changed, 9 insertions(+), 7 deletions(-)
> 

Tested-by: Kiran Bhandare <kiranx.bhandare@intel.com>  A Contingent Worker at Intel
