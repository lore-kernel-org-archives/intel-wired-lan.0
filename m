From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 13 Apr 2016 17:51:25 +0000
Subject: [Intel-wired-lan] [next PATCH S33 05/13] i40evf: Allow PF
 driver to	configure RSS
In-Reply-To: <1460475052-6348-6-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-6-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D0721@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 05/13] i40evf: Allow PF driver to
> configure RSS
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> If the PF driver reports proper support, allow the PF driver to configure RSS
> on the behalf of the VF driver. This will allow for RSS support on future
> hardware without changes to the VF driver.
> 
> Unfortunately, the old RSS code still needs to stay as the driver needs to be
> compatible with PF drivers that don't support this interface. But this change
> still simplifies the data structures a bunch and makes this code simpler to
> read and maintain.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I0375aad40788ecdc0cb24d5cfeccf07804e69771
> ---
> Testing Hints : Use ethtool to change RSS params and make sure they stick
> and work correctly.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  30 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 121 ++++----
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 308 +++++++-------------
> -
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 119 ++++++++
>  4 files changed, 294 insertions(+), 284 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
RSS settings can be changed and stick via ethtool
