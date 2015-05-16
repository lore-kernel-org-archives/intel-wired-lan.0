From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat, 16 May 2015 03:57:28 -0700
Subject: [Intel-wired-lan] [net PATCH 2/2] i40e: start up in VEPA mode
 by default
In-Reply-To: <20150508223557.26673.76301.stgit@jbrandeb-cp2.jf.intel.com>
References: <20150508223552.26673.5631.stgit@jbrandeb-cp2.jf.intel.com>
 <20150508223557.26673.76301.stgit@jbrandeb-cp2.jf.intel.com>
Message-ID: <1431773848.32618.78.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2015-05-08 at 15:35 -0700, Jesse Brandeburg wrote:
> From: Anjali Singhai Jain <anjali.singhai@intel.com>
> 
> The patch fixes a bug in the default configuration which
> prevented a software bridge loaded on the PF interface from
> working correctly because broadcast packets are incorrectly
> looped back.
> 
> Fix the general case, by loading the driver in VEPA mode Until a
> VF or VMDq VSI is added. This way loopback on the Main VSI is
> turned off until needed and can resolve the issue of unnecessary
> reflection for users that do not have VF or VMDq VSIs setup.
> 
> The driver must now coordinate the loopback setting for the Flow
> Director (FDIR) VSI to make sure it is in sync with the current
> VEB or VEPA mode setting.
> 
> The user can still switch bridge modes from the bridge commands and
> choose to be in VEPA mode with VF VSIs. Because of hardware
> requirements, the call to switch to VEB mode when no VF/VMDqs are
> present will be rejected.
> 
> NOTE: This patch uses BIT_ULL as that is preferred going forward,
> a followup patch in the lower priority queue to net-next will fix
> up the remaining 1 << usages.
> 
> Change-ID: Ib121ddb18fe4b3c4f52e9deda6fcbeb9105683d1
> Signed-off-by: Anjali Singhai Jain <anjali.singhai@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h             |    1 +
>  drivers/net/ethernet/intel/i40e/i40e_debugfs.c     |    9 +++++++++
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |   21
> ++++++++++++++++----
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |   10 +++++++++-
>  4 files changed, 36 insertions(+), 5 deletions(-)

Applied to my net-queue tree
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150516/cd7a0b94/attachment.asc>
