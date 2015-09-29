From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 29 Sep 2015 17:23:42 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix for recursive RTNL lock
 during	PROMISC change
In-Reply-To: <1443472632-33873-1-git-send-email-anjali.singhai@intel.com>
References: <1443472632-33873-1-git-send-email-anjali.singhai@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B1FFA@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Anjali Singhai Jain
> Sent: Monday, September 28, 2015 1:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] i40e: Fix for recursive RTNL lock during
> PROMISC change
> 
> The sync_vsi_filters function can be called directly under RTNL or through the
> timer subtask without one. This was causing a deadlock.
> 
> If sync_vsi_filters is called from a thread which held the lock, and in another
> thread the PROMISC setting got changed we would be executing the
> PROMISC change in the thread which already held the lock alongside the
> other filter update. The PROMISC change requires a reset if we are on a VEB,
> which requires it to be called under RTNL.
> 
> Earlier the driver would call reset for PROMISC change without checking if we
> were already under RTNL and would try to grab it causing a deadlock. This
> patch changes the flow to see if we are already under RTNL before trying to
> grab it.
> 
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |  2 +-
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |  4 ++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 19 ++++++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  8 ++++----
>  4 files changed, 19 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, able to successfully add and delete bridges, attach bridges to VLANs, and pass traffic across the bridge without errors or lockups. Unable to pass traffic across VLAN.
