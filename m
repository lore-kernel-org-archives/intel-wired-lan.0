From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Oct 2015 19:57:56 +0000
Subject: [Intel-wired-lan] [next PATCH S17 09/11] i40e: Fix order of
 checks	when enabling/disabling autoneg in ethtool
In-Reply-To: <1443464220-148318-10-git-send-email-catherine.sullivan@intel.com>
References: <1443464220-148318-1-git-send-email-catherine.sullivan@intel.com>
 <1443464220-148318-10-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060B35C6@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Catherine Sullivan
> Sent: Monday, September 28, 2015 11:17 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S17 09/11] i40e: Fix order of checks
> when enabling/disabling autoneg in ethtool
> 
> We were previously checking if autoneg was allowed to change before
> checking if autoneg was changing. We need to do this in the other order or
> else we will erroneously return EINVAL when autoneg is not changing.
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: Iff9f7d1c9bddc1ad1e5d227d4f42754f90155410
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 29 ++++++++++++++-------
> -----
>  1 file changed, 16 insertions(+), 13 deletions(-)

Patch code changes correctly applied, per HSD 5645268 notes "With i40e-1.3.38, the behavior described in this HSD no longer occurs.  I am able to set advertise 0x20 and then return to advertise 0x1020 without error."
