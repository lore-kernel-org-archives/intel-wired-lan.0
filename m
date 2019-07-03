From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Jul 2019 21:41:27 +0000
Subject: [Intel-wired-lan] [next PATCH S7 6/9] i40e: Update visual
 effect for advertised FEC mode.
In-Reply-To: <20190702122259.79070-6-alice.michael@intel.com>
References: <20190702122259.79070-1-alice.michael@intel.com>
 <20190702122259.79070-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FD26D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, July 2, 2019 5:23 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Zagorski, CzeslawX <czeslawx.zagorski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S7 6/9] i40e: Update visual effect for
> advertised FEC mode.
> 
> From: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> 
> Updates visual effect for advertised mode after setting desired mode.
> The mode appears in advertised FEC mode correctly, when ethtool interface
> command is called. Without this commit advertised FEC is displayed
> regardless of the settings as "None BaseR RS".
> 
> Signed-off-by: Czeslaw Zagorski <czeslawx.zagorski@intel.com>
> ---
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 63 ++++++++++---------
>  1 file changed, 35 insertions(+), 28 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


