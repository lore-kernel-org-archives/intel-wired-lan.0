From: Jankowski, Konrad0 <konrad0.jankowski@intel.com>
Date: Tue, 24 May 2022 15:52:26 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3] drivers,
 ixgbe: export vf statistics
In-Reply-To: <20220509110340.100814-1-mheyne@amazon.de>
References: <20220509110340.100814-1-mheyne@amazon.de>
Message-ID: <DM8PR11MB562165BE16503138D1100255ABD79@DM8PR11MB5621.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Maximilian Heyne <mheyne@amazon.de>
> Sent: Monday, May 9, 2022 1:04 PM
> Cc: Maximilian Heyne <mheyne@amazon.de>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; Nguyen, Anthony L
> <anthony.l.nguyen@intel.com>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [PATCH net-next v3] drivers, ixgbe: export vf statistics
> 
> This change retrieves network metrics for virtual functions from the device
> and exports them via the iproute2 interface.
> 
> The code for retrieving the statistics from the device is taken from the out-of-
> tree driver.  The feature was introduced with version 2.0.75.7, so the diff
> between this version and the previous version 2.0.72.4 was used to identify
> required changes. The export via ethtool is omitted in favor of using the
> standard ndo_get_vf_stats interface.
> 
> Per-VF statistics can now be printed, for instance, via
> 
>   ip --statistics link show dev eth0
> 
> Signed-off-by: Maximilian Heyne <mheyne@amazon.de>
> ---
> v2: implemented the ndo_get_vf_stats callback
> v3: as per discussion, removed the ethtool changes
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      | 34 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 86 +++++++++++++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |  7 ++
>  3 files changed, 127 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 921a4d977d65..48444ab9e0b1 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> 

Tested-by: Konrad Jankowski <konrad0.jankowski@intel.com>
