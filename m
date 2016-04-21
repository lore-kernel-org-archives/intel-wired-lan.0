From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Apr 2016 19:29:08 +0000
Subject: [Intel-wired-lan] [next-queue PATCH] ixgbevf: Move API
 negotiation function into mac_ops
In-Reply-To: <20160415003715.11097.60482.stgit@ahduyck-xeon-server>
References: <20160415003715.11097.60482.stgit@ahduyck-xeon-server>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2822@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, April 14, 2016 5:37 PM
> To: kys at microsoft.com; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next-queue PATCH] ixgbevf: Move API
> negotiation function into mac_ops
> 
> This patch moves API negotiation into mac_ops.  The general idea here is that
> with HyperV on the way we need to make certain that anything that will have
> different versions between HyperV and a standard VF needs to be
> abstracted enough so that we can have a separate function between the two
> so we can avoid changes in one breaking something in the other.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |    2 +-
>  drivers/net/ethernet/intel/ixgbevf/vf.c           |    5 +++--
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |    2 +-
>  3 files changed, 5 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Able to create VFs without errors
