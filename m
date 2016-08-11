From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 11 Aug 2016 19:27:20 +0000
Subject: [Intel-wired-lan] [next PATCH S41-V2 2/5] i40evf: report link
 speed
In-Reply-To: <1470335825-15534-3-git-send-email-bimmy.pujari@intel.com>
References: <1470335825-15534-1-git-send-email-bimmy.pujari@intel.com>
 <1470335825-15534-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F89FD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Thursday, August 04, 2016 11:37 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S41-V2 2/5] i40evf: report link speed
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The PF driver tells us the link speed, so do something with that information.
> Add link speed to log messages, and report speed through ethtool.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-Id: I279dc9540cc5203376406050a3e8d67e128d5882
> ---
> Testing Hints : Test reporting of link up/down and various speeds.
> 
>  drivers/net/ethernet/intel/i40evf/i40evf.h         |  1 +
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 26 ++++++++--
>  .../net/ethernet/intel/i40evf/i40evf_virtchnl.c    | 55
> ++++++++++++++++++----
>  3 files changed, 70 insertions(+), 12 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
