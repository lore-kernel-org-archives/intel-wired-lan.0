From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Tue, 28 Apr 2015 19:37:08 +0000
Subject: [Intel-wired-lan] [PATCH v4 2/3] if_link: Add VF
	multicast	promiscuous control
In-Reply-To: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EC0A@BPXM14GP.gisp.nec.co.jp>
References: <7F861DC0615E0C47A872E6F3C5FCDDBD05E7EC0A@BPXM14GP.gisp.nec.co.jp>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E17F82441E@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Hiroshi Shimamoto
> Sent: Thursday, April 09, 2015 6:05 PM
> To: Kirsher, Jeffrey T; Alexander Duyck; intel-wired-lan
> Cc: vyasevic at redhat.com; e1000-devel at lists.sourceforge.net;
> netdev at vger.kernel.org; Choi, Sy Jong; linux-kernel at vger.kernel.org; David
> Laight; Hayato Momma; Edward Cree; Or Gerlitz; Bj?rn Mork
> Subject: [Intel-wired-lan] [PATCH v4 2/3] if_link: Add VF multicast promiscuous
> control
> 
> From: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> 
> Add netlink directives and ndo entry to allow VF multicast promiscuous mode.
> 
> This controls the permission to enter VF multicast promiscuous mode.
> The administrator will dedicatedly allow multicast promiscuous per VF.
> 
> When the VF is under multicast promiscuous mode, all multicast packets are sent
> to the VF.
> 
> Don't allow VF multicast promiscuous if the VM isn't fully trusted.
> 
> Signed-off-by: Hiroshi Shimamoto <h-shimamoto@ct.jp.nec.com>
> Reviewed-by: Hayato Momma <h-momma@ce.jp.nec.com>
> CC: Choi, Sy Jong <sy.jong.choi@intel.com>
> ---
>  include/linux/if_link.h      |  1 +
>  include/linux/netdevice.h    |  3 +++
>  include/uapi/linux/if_link.h |  6 ++++++
>  net/core/rtnetlink.c         | 19 +++++++++++++++++--
>  4 files changed, 27 insertions(+), 2 deletions(-)

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
