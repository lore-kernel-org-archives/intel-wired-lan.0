From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 16 Nov 2016 19:27:45 +0000
Subject: [Intel-wired-lan] [next PATCH S52-V2 05/15] i40e: Fix for
 ethtool	Supported link modes
In-Reply-To: <1478639119-14656-6-git-send-email-bimmy.pujari@intel.com>
References: <1478639119-14656-1-git-send-email-bimmy.pujari@intel.com>
 <1478639119-14656-6-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA36D3E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Tuesday, November 08, 2016 1:05 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S52-V2 05/15] i40e: Fix for ethtool
> Supported link modes
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch fixes the problem where the ethtool Supported link modes list
> backplane interfaces on X722 devices for 10GbE with
> SFP+ and Cortina retimer. This patch fixes the problem by setting
> and using a flag for this particular device since the backplane interface is only
> between the internal PHY and the retimer and it should not be seen by the
> user as they cannont use it.
> Without this patch, the user wrongly thinks that backplane interfaces are
> supported on their device when they actually are not.
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> Change-ID: I3882bc2928431d48a2db03a51a713a1f681a79e9
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 16 ++++++++++------
>  drivers/net/ethernet/intel/i40e/i40e_main.c    |  3 ++-
>  3 files changed, 13 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Ethtool no longer shows backplane for X722 with 10GbE SFP+


