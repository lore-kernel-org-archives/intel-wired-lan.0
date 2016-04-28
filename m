From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 28 Apr 2016 18:02:05 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Use mac_ops instead of
 trying to	identify NIC type
In-Reply-To: <20160422171826.11019.16994.stgit@ahduyck-xeon-server>
References: <20160422171826.11019.16994.stgit@ahduyck-xeon-server>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D5262@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Friday, April 22, 2016 10:18 AM
> To: kys at microsoft.com; intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Use mac_ops instead of trying to
> identify NIC type
> 
> This change makes it so that we can just use function pointers instead of
> having to identify if a given VF is running on a Linux or Windows PF.  By doing
> this we can avoid having to pull too much information out of the lower layers
> and can instead just make use of the mac_ops pointers since they should
> differ between the two types of VFs anyway.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf.h      |    1 -
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |   15 +++------------
>  drivers/net/ethernet/intel/ixgbevf/vf.c           |   20 +++++++++-----------
>  drivers/net/ethernet/intel/ixgbevf/vf.h           |    4 +---
>  4 files changed, 13 insertions(+), 27 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Jumbo frames/MTU can still be set on VF
