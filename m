From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 25 Jun 2020 17:03:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] i40e: optimize AF_XDP
 Tx completion path
In-Reply-To: <1592905458-850-2-git-send-email-magnus.karlsson@intel.com>
References: <1592905458-850-1-git-send-email-magnus.karlsson@intel.com>
 <1592905458-850-2-git-send-email-magnus.karlsson@intel.com>
Message-ID: <BN6PR1101MB2145362BD20CD9EDEA37E6A18C920@BN6PR1101MB2145.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Tuesday, June 23, 2020 2:44 AM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; Samudrala, Sridhar
> <sridhar.samudrala@intel.com>
> Cc: maciejromanfijalkowski at gmail.com; Fijalkowski, Maciej
> <maciej.fijalkowski@intel.com>; netdev at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH net-next v2 1/3] i40e: optimize AF_XDP Tx
> completion path
> 
> Improve the performance of the AF_XDP zero-copy Tx completion path.
> When there are no XDP buffers being sent using XDP_TX or XDP_REDIRECT,
> we do not have go through the SW ring to clean up any entries since the
> AF_XDP path does not use these. In these cases, just fast forward the next-
> to-use counter and skip going through the SW ring. The limit on the
> maximum number of entries to complete is also removed since the algorithm
> is now O(1). To simplify the code path, the maximum number of entries to
> complete for the XDP path is therefore also increased from 256 to 512 (the
> default number of Tx HW descriptors). This should be fine since the
> completion in the XDP path is faster than in the SKB path that has 256 as the
> maximum number.
> 
> This patch provides around 4% throughput improvement for the l2fwd
> application in xdpsock on my machine.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c |  3 +-
> drivers/net/ethernet/intel/i40e/i40e_txrx.h |  1 +
> drivers/net/ethernet/intel/i40e/i40e_xsk.c  | 43 +++++++++++++++----------
> ----  drivers/net/ethernet/intel/i40e/i40e_xsk.h  |  3 +-
>  4 files changed, 27 insertions(+), 23 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


