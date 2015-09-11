From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 11 Sep 2015 16:39:54 +0000
Subject: [Intel-wired-lan] [next PATCH S11 13/15] i40e: fix bug in
 return	from get_link_status and avoid spurious link messages
In-Reply-To: <1440616461-110869-14-git-send-email-catherine.sullivan@intel.com>
References: <1440616461-110869-1-git-send-email-catherine.sullivan@intel.com>
 <1440616461-110869-14-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A6464@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Wednesday, August 26, 2015 12:14 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S11 13/15] i40e: fix bug in return from
> get_link_status and avoid spurious link messages
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Previously, the driver could call this function and have only true/false
> returned, but false could mean multiple things like failure to read or link was
> down. This change allows the caller to get all return values in the call chain
> bubbled back to the source, which keeps information about failures from
> being lost.
> 
> Also, in some unlikely scenarios, the firmware can become slow to respond
> to admin queue (AQ) queries for link state.  Should the AQ time out, the
> driver can detect the state and avoid a link change when there may have
> been none.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Ib2ac38407b7880750fb891b392fa77457fe6c21c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c    | 15 ++++++++-------
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c   | 11 ++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c      | 12 ++++++++++--
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h |  2 +-
>  4 files changed, 29 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree
