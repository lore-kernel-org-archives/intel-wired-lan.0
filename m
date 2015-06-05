From: Young, James M <james.m.young@intel.com>
Date: Fri, 5 Jun 2015 00:04:54 +0000
Subject: [Intel-wired-lan] [net PATCH 2/2] i40e: start up in VEPA mode
 by	default
In-Reply-To: <20150508223557.26673.76301.stgit@jbrandeb-cp2.jf.intel.com>
References: <20150508223552.26673.5631.stgit@jbrandeb-cp2.jf.intel.com>
 <20150508223557.26673.76301.stgit@jbrandeb-cp2.jf.intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA0A012@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, May 08, 2015 3:36 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH 2/2] i40e: start up in VEPA mode by
> default
> 
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The patch fixes a bug in the default configuration which prevented a
> software bridge loaded on the PF interface from working correctly because
> broadcast packets are incorrectly looped back.
> 
> Fix the general case, by loading the driver in VEPA mode Until a VF or VMDq
> VSI is added. This way loopback on the Main VSI is turned off until needed
> and can resolve the issue of unnecessary reflection for users that do not
> have VF or VMDq VSIs setup.
> 
> The driver must now coordinate the loopback setting for the Flow Director
> (FDIR) VSI to make sure it is in sync with the current VEB or VEPA mode
> setting.
> 
> The user can still switch bridge modes from the bridge commands and
> choose to be in VEPA mode with VF VSIs. Because of hardware
> requirements, the call to switch to VEB mode when no VF/VMDqs are
> present will be rejected.
> 
> NOTE: This patch uses BIT_ULL as that is preferred going forward, a followup
> patch in the lower priority queue to net-next will fix up the remaining 1 <<
> usages.
> 
> Change-ID: Ib121ddb18fe4b3c4f52e9deda6fcbeb9105683d1
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    9 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   21 ++++++++++++++++-
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   10 +++++++++-
>  4 files changed, 36 insertions(+), 5 deletions(-)
> 

Tested-by: Jim Young <james.m.young@intel.com>

Tested with sriov turned on, and sriov enabled in the bios, bridging works. 

