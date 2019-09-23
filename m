From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 23 Sep 2019 18:10:28 +0000
Subject: [Intel-wired-lan] [next PATCH S10 03/10] i40e: Wrong
 'Advertised FEC modes' after set FEC to AUTO
In-Reply-To: <20190920091724.51767-3-alice.michael@intel.com>
References: <20190920091724.51767-1-alice.michael@intel.com>
 <20190920091724.51767-3-alice.michael@intel.com>
Message-ID: <b75849c37ce949e28023159abca99bd1@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, September 20, 2019 2:17 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Gawin, JaroslawX <jaroslawx.gawin@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S10 03/10] i40e: Wrong 'Advertised
> FEC modes' after set FEC to AUTO
> 
> From: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> 
> Fix display of parameters "Configured FEC encodings:" and "Advertised FEC
> modes:" in ethtool.  Implemented by setting proper FEC bits in ?advertising?
> bitmask of link_modes struct and ?fec? bitmask in ethtool_fecparam struct.
> Without this patch wrong FEC settings can be shown.
> 
> Signed-off-by: Jaroslaw Gawin <jaroslawx.gawin@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 13 ++++++--
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    | 32 +++++++++----------
>  2 files changed, 26 insertions(+), 19 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


