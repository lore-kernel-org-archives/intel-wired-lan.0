From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 31 Oct 2018 16:26:04 +0000
Subject: [Intel-wired-lan] [next PATCH S98 1/6] i40e: don't restart nway
 if autoneg not supported
In-Reply-To: <20181026213333.51495-1-alice.michael@intel.com>
References: <20181026213333.51495-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D328F77@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, October 26, 2018 2:33 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S98 1/6] i40e: don't restart nway if
> autoneg not supported
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> On link types that do not support autoneg, we cannot attempt to restart
> nway negotiation. This results in a dead link that requires a power cycle to
> remedy.
> 
> Fix this by saving off the autoneg state and checking this value before we try
> to restart nway.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


