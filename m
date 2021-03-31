From: Brelinski, TonyX <tonyx.brelinski@intel.com>
Date: Wed, 31 Mar 2021 21:36:55 +0000
Subject: [Intel-wired-lan] [PATCH S57 06/14] ice: Rename a couple of
 variables
In-Reply-To: <20210325223517.17722-6-anthony.l.nguyen@intel.com>
References: <20210325223517.17722-1-anthony.l.nguyen@intel.com>
 <20210325223517.17722-6-anthony.l.nguyen@intel.com>
Message-ID: <CO1PR11MB51056755063B3F49348A819FFA7C9@CO1PR11MB5105.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Tony Nguyen
> Sent: Thursday, March 25, 2021 3:35 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S57 06/14] ice: Rename a couple of
> variables
> 
> From: Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>
> 
> In ice_set_link_ksettings, change 'abilities' to 'phy_caps' and 'p' to 'pi'. This is
> more consistent with similar usages elsewhere in the driver.
> 
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 50 ++++++++++----------
>  1 file changed, 25 insertions(+), 25 deletions(-)

Tested-by: Tony Brelinski <tonyx.brelinski@intel.com> A Contingent Worker at Intel


