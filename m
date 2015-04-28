From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 28 Apr 2015 19:37:32 +0000
Subject: [Intel-wired-lan] [PATCH v4 3/3] ixgbe: Add new ndo to allow VF
 multicast promiscuous mode
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EC5C@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EC5C@BPXM14GP.gisp.nec.co.jp>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F82443D@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Hiroshi Shimamoto
> Sent: Thursday, April 09, 2015 6:08 PM
> To: Kirsher, Jeffrey T; Alexander Duyck; intel-wired-lan
> Cc: vyasevic at redhat.com; e1000-devel at lists.sourceforge.net;
> netdev at vger.kernel.org; Choi, Sy Jong; linux-kernel at vger.kernel.org; David
> Laight; Hayato Momma; Edward Cree; Or Gerlitz; Bj?rn Mork
> Subject: [Intel-wired-lan] [PATCH v4 3/3] ixgbe: Add new ndo to allow VF
> multicast promiscuous mode
> 
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Implements the new netdev op to allow VF multicast promiscuous mode.
> 
> The multicast promiscuous mode is not allowed for all VFs by default.
> 
> The administrator can allow to VF multicast promiscuous mode for only trusted
> VM. After allowing multicast promiscuous mode from the host, we can use over
> 30 IPv6 addresses on VM.
>  # ip link set dev eth0 vf 1 mc_promisc on
> 
> When disallowing multicast promiscuous mode, ixgbevf can only handle 30
> IPv6 addresses at most.
>  # ip link set dev eth0 vf 1 mc_promisc off
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> Reviewed-by: Hayato Momma <h-momma@ce.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
> ---
> 
> v4: Put reconfiguration of MC promiscuous mode into the previous loop.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h       |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  5 ++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c | 32
> ++++++++++++++++++++++++--  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |
> 2 ++
>  4 files changed, 38 insertions(+), 2 deletions(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
