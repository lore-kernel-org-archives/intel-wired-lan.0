From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 10 Oct 2017 17:40:27 +0000
Subject: [Intel-wired-lan] [PATCH v3 04/14 net-next] i40e: fix clearing
 link	masks in i40e_get_link_ksettings
In-Reply-To: <20171005215344.2886-5-alan.brady@intel.com>
References: <20171005215344.2886-1-alan.brady@intel.com>
 <20171005215344.2886-5-alan.brady@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAC26F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alan Brady
> Sent: Thursday, October 5, 2017 2:54 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v3 04/14 net-next] i40e: fix clearing link
> masks in i40e_get_link_ksettings
> 
> This fixes two issues in i40e_get_link_ksettings.  It adds calls to
> ethtool_link_ksettings_zero_link_mode to make sure advertising and
> supported link masks are cleared before we start setting bits in them.
> 
> This also replaces some funky bit manipulations with a much nicer call to
> ethtool_link_ksettings_del_link_mode when removing link modes.
> 
> Signed-off-by: Alan Brady <alan.brady@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


