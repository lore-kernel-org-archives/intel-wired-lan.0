From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Sep 2015 22:26:50 +0000
Subject: [Intel-wired-lan] [next PATCH S15 02/15] i40e: use priv flags
 to	control flow director
In-Reply-To: <1441315142-173025-3-git-send-email-catherine.sullivan@intel.com>
References: <1441315142-173025-1-git-send-email-catherine.sullivan@intel.com>
 <1441315142-173025-3-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060A62F4@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Thursday, September 03, 2015 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S15 02/15] i40e: use priv flags to
> control flow director
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> Some customers wish to be able to control our hardware specific feature
> called flow director, at runtime.  This patch enables ethtool priv flags to
> control this driver/hardware specific feature.
> 
> ethtool --set-priv-flags ethX flow-director-atr off
> 
> NOTE: the ethtool ntuple interface controls the flow-director
>       sideband rules.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-ID: Iba156350b07fa2ce66f53ded51739f9a3781fe0e
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 14 ++++++++++++++
>  2 files changed, 15 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, ethtool sets and shows flags properly
