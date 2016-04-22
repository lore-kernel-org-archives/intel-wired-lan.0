From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 22 Apr 2016 19:32:07 +0000
Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf:
 Support	Windows hosts (Hyper-V)
In-Reply-To: <1461118677-28142-2-git-send-email-kys@microsoft.com>
References: <1461118655-28103-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-1-git-send-email-kys@microsoft.com>
 <1461118677-28142-2-git-send-email-kys@microsoft.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2A6A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of K. Y. Srinivasan
> Sent: Tuesday, April 19, 2016 7:18 PM
> To: davem at davemloft.net; netdev at vger.kernel.org; linux-
> kernel at vger.kernel.org; devel at linuxdriverproject.org; olaf at aepfle.de;
> apw at canonical.com; jasowang at redhat.com; eli at mellanox.com;
> jackm at mellanox.com; yevgenyp at mellanox.com; Ronciak, John
> <john.ronciak@intel.com>; intel-wired-lan at lists.osuosl.org;
> alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [PATCH net-next V5 2/2] intel: ixgbevf: Support
> Windows hosts (Hyper-V)
> 
> On Hyper-V, the VF/PF communication is a via software mediated path as
> opposed to the hardware mailbox. Make the necessary adjustments to
> support Hyper-V.
> 
> Signed-off-by: K. Y. Srinivasan <kys@microsoft.com>
> ---
> 	V2: Addressed most of the comments from
> 	    Alexander Duyck <alexander.duyck@gmail.com>
> 	    and Rustad, Mark D <mark.d.rustad@intel.com>.
> 
> 	V3: Addressed additional comments from
> 	    Alexander Duyck <alexander.duyck@gmail.com>
> 
> 	V4: Addressed kbuild errors reported by:
> 	    kbuild test robot <lkp@intel.com>
> 
> 	V5: Addressed additional comments from
> 	    Alexander Duyck <alexander.duyck@gmail.com>
> 
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |   12 ++
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   31 +++-
>  drivers/net/ethernet/intel/ixgbevf/mbx.c          |   12 ++
>  drivers/net/ethernet/intel/ixgbevf/vf.c           |  216
> +++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |    2 +
>  5 files changed, 266 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VF driver correctly builds and changes correctly applied.
