From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jan 2016 19:44:13 +0000
Subject: [Intel-wired-lan] [next PATCH S28 03/15] i40evf: support
	packet	split receive
In-Reply-To: <1452897202-15204-4-git-send-email-joshua.a.hay@intel.com>
References: <1452897202-15204-1-git-send-email-joshua.a.hay@intel.com>
 <1452897202-15204-4-git-send-email-joshua.a.hay@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F988BE1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Joshua Hay
> Sent: Friday, January 15, 2016 2:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S28 03/15] i40evf: support packet split
> receive
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> Support packet split receive on VFs. This is off by default but can be enabled
> using ethtool private flags. Because we need to trigger a reset from outside
> of i40evf_main.c, create a new function to do so, and export it.
> 
> Also update copyright year in file headers.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: I721aa5d70113d3d6d94102e5f31526f6fc57cbbb
> ---
> Testing Hints: Use ethtool --set-priv-flags to enable and disable packet split.
> Traffic should proceed as normal in either mode.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  6 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 67
> +++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 64 +++++++++++--------
> --
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    |  4 ++
>  4 files changed, 110 insertions(+), 31 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, receive works normally on VF with packet split enabled and disabled
