From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 21 Nov 2016 23:18:40 +0000
Subject: [Intel-wired-lan] [next PATCH S53-V3 2/5] i40e: Add support for
 25G	devices
In-Reply-To: <1479762231-27559-2-git-send-email-bimmy.pujari@intel.com>
References: <1479762231-27559-1-git-send-email-bimmy.pujari@intel.com>
 <1479762231-27559-2-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA3858F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 21, 2016 1:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Tieman, Henry W <henry.w.tieman@intel.com>; Joyner, Eric
> <eric.joyner@intel.com>; Kosiarz, Michal <michal.kosiarz@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S53-V3 2/5] i40e: Add support for 25G
> devices
> 
> From: Carolyn Wyborny <carolyn.wyborny@intel.com>
> 
> Add support for 25G devices - defines and data structures.
> 
> One tricky part here is that the firmware support for these Devices
> introduces a mismatch between the PHY type enum and the bitfields for the
> phy types.
> 
> This change creates a macro and uses it to increment the 25G PHY values
> when creating 25G bitfields.
> 
> Signed-off-by: Carolyn Wyborny <carolyn.wyborny@intel.com>
> Signed-off-by: Michal Kosiarz <michal.kosiarz@intel.com>
> Signed-off-by: Eric Joyner <eric.joyner@intel.com>
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Signed-off-by: Henry Tieman <henry.w.tieman@intel.com>
> Signed-off-by: Avinash Dayanand <avinash.dayanand@intel.com>
> Change-ID: I69b24d837d44cf9220bf5cb8dd46c5be89ce490b
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h  | 30 +++++++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c      | 11 ++-
>  drivers/net/ethernet/intel/i40e/i40e_devids.h      |  2 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 26 ++++++-
>  drivers/net/ethernet/intel/i40e/i40e_main.c        |  6 +-
>  drivers/net/ethernet/intel/i40e/i40e_type.h        | 82 +++++++++++++-------
> --
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c |  3 +
>  .../net/ethernet/intel/i40evf/i40e_adminq_cmd.h    | 30 +++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_common.c    |  2 +
>  drivers/net/ethernet/intel/i40evf/i40e_devids.h    |  2 +
>  drivers/net/ethernet/intel/i40evf/i40e_type.h      | 82 +++++++++++++------
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c |  8 +++
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  3 +
>  13 files changed, 208 insertions(+), 79 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


