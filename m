From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 28 Apr 2015 19:36:40 +0000
Subject: [Intel-wired-lan] [PATCH v4 1/3] ixgbe,
 ixgbevf: Add new mbox API to enable MC promiscuous mode
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EBE2@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EBE2@BPXM14GP.gisp.nec.co.jp>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F8243E5@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Hiroshi Shimamoto
> Sent: Thursday, April 09, 2015 6:04 PM
> To: Kirsher, Jeffrey T; Alexander Duyck; intel-wired-lan
> Cc: vyasevic at redhat.com; e1000-devel at lists.sourceforge.net;
> netdev at vger.kernel.org; Choi, Sy Jong; linux-kernel at vger.kernel.org; David
> Laight; Hayato Momma; Edward Cree; Or Gerlitz; Bj?rn Mork
> Subject: [Intel-wired-lan] [PATCH v4 1/3] ixgbe, ixgbevf: Add new mbox API to
> enable MC promiscuous mode
> 
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> The limitation of the number of multicast address for VF is not enough for the
> large scale server with SR-IOV feature.
> IPv6 requires the multicast MAC address for each IP address to handle the
> Neighbor Solicitation message.
> We couldn't assign over 30 IPv6 addresses to a single VF interface.
> 
> The easy way to solve this is enabling multicast promiscuous mode.
> It is good to have a functionality to enable multicast promiscuous mode for each
> VF from VF driver.
> 
> This patch introduces the new mbox API, IXGBE_VF_SET_MC_PROMISC, to
> enable/disable multicast promiscuous mode in VF. If multicast promiscuous
> mode is enabled the VF can receive all multicast packets.
> 
> With this patch, the ixgbevf driver automatically enable multicast promiscuous
> mode when the number of multicast addresses is over than 30 if possible.
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> Reviewed-by: Hayato Momma <h-momma@ce.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h          |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_mbx.h      |  2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c    | 76
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  3 +
>  drivers/net/ethernet/intel/ixgbevf/mbx.h          |  2 +
>  drivers/net/ethernet/intel/ixgbevf/vf.c           | 27 +++++++-
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |  1 +
>  7 files changed, 111 insertions(+), 1 deletion(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
