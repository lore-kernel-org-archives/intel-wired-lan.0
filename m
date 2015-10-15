From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:54:30 +0000
Subject: [Intel-wired-lan] [net PATCH] i40e: fix stats offsets
In-Reply-To: <1443838174-3692-1-git-send-email-jesse.brandeburg@intel.com>
References: <1443838174-3692-1-git-send-email-jesse.brandeburg@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1E58@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Jesse Brandeburg
> Sent: Friday, October 02, 2015 7:10 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [net PATCH] i40e: fix stats offsets
> 
> The code was setting up stats that were not being initialized.
> This caused several counters to be displayed incorrectly, due to indexing
> beyond the array of strings when printing stats.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Code changes not applied, counters display correctly in ethtool
