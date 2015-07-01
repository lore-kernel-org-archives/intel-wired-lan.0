From: Young, James M <james.m.young@intel.com>
Date: Wed, 1 Jul 2015 20:45:35 +0000
Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 4/8]
	i40evf:	handle big resets
In-Reply-To: <1433449442-31420-5-git-send-email-catherine.sullivan@intel.com>
References: <1433449442-31420-1-git-send-email-catherine.sullivan@intel.com>
 <1433449442-31420-5-git-send-email-catherine.sullivan@intel.com>
Message-ID: <68C85B5FC2FE974B87244D7222BC92783EA1C09F@ORSMSX102.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, June 04, 2015 1:24 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [intel-wired-lan][net-next PATCH 4/8] i40evf:
> handle big resets
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The most common type of reset that the VF will encounter is a PF reset that
> cascades down into a VF reset for each VF. In this case, the VF will always be
> assigned the same VSI and recovery is fairly simple.
> 
> However, in the case of 'bigger' resets, such as a Core or EMP reset, when
> the device is reinitialized, it's probable that the VF will NOT get the same VSI.
> When this happens, the VF will not be able to recover, as it will continue to
> request resources for its original VSI.
> 
> Add an extra state to the admin queue state machine so that the driver can
> re-request its configuration information at runtime. During reset recovery,
> set this bit in the aq_required field, and fetch the (possibly
> new) configuration information before attempting to bring the driver back
> up. Since the driver doesn't know what kind of reset it has encountered, this
> step is done even for a PF reset, but it doesn't hurt anything - it just gets the
> same VSI back.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I915d59ffb40375215117362f4ac7a37811aba748
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |   2 +
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 109 +++++++++++++----
> ----
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  30 +++++-
>  3 files changed, 95 insertions(+), 46 deletions(-)
> 
Tested-By: Jim Young <james.m.young@intel.com>
VFs operate properly after a core reset to the PF 
