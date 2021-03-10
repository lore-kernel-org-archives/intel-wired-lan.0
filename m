From: Jambekar, Vishakha <vishakha.jambekar@intel.com>
Date: Wed, 10 Mar 2021 04:19:01 +0000
Subject: [Intel-wired-lan] [PATCH net-next 2/3] ixgbe: optimize for
 XDP_REDIRECT in xsk path
In-Reply-To: <20201202150724.31439-3-magnus.karlsson@gmail.com>
References: <20201202150724.31439-1-magnus.karlsson@gmail.com>
 <20201202150724.31439-3-magnus.karlsson@gmail.com>
Message-ID: <SA2PR11MB49408999700F78B1B3844A14FF919@SA2PR11MB4940.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Magnus Karlsson
> Sent: Wednesday, December 2, 2020 8:37 PM
> To: Karlsson, Magnus <magnus.karlsson@intel.com>; Topel, Bjorn
> <bjorn.topel@intel.com>; intel-wired-lan at lists.osuosl.org; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>
> Cc: netdev at vger.kernel.org; maciejromanfijalkowski at gmail.com
> Subject: [Intel-wired-lan] [PATCH net-next 2/3] ixgbe: optimize for
> XDP_REDIRECT in xsk path
> 
> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Optimize ixgbe_run_xdp_zc() for the XDP program verdict being XDP_REDIRECT
> in the zsk zero-copy path. This path is only used when having AF_XDP zero-copy
> on and in that case most packets will be directed to user space. This provides a
> little under 100k extra packets in throughput on my server when running l2fwd in
> xdpsock.
> 
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
Tested-by: Vishakha Jambekar <vishakha.jambekar@intel.com>
