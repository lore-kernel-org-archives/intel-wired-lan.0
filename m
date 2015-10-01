From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Oct 2015 16:57:08 +0000
Subject: [Intel-wired-lan] [next PATCH S16 05/15] i40e: priv flag
	for	controlling VEB stats
In-Reply-To: <1443463964-148204-6-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-6-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B2BFD@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:13 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S16 05/15] i40e: priv flag for
> controlling VEB stats
> 
> From: Shannon Nelson <shannon.nelson@intel.com>
> 
> Add an ethtool priv flag to enable and disable printing the VEB statistics.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@intel.com>
> Change-ID: I7654054a3a73b08aa8310d94ee8fce6219107dd8
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         | 1 +
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 8 ++++++++
>  2 files changed, 9 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes present in tree, "ethtool --show-priv-flags [device]" shows value for "veb-stats", flag can be toggled correctly.
