From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 14 Apr 2017 21:48:17 +0000
Subject: [Intel-wired-lan] [next PATCH S70 05/12] i40e: fix
	CONFIG_BUSY	checks in i40e_set_settings function
In-Reply-To: <20170413084555.6962-5-alice.michael@intel.com>
References: <20170413084555.6962-1-alice.michael@intel.com>
 <20170413084555.6962-5-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1040BA03@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alice Michael
> Sent: Thursday, April 13, 2017 1:46 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S70 05/12] i40e: fix CONFIG_BUSY
> checks in i40e_set_settings function
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The check for I40E_CONFIG_BUSY state bit in the i40e_set_link_ksettings
> function is fishy. First we can notice a few things about the check here.
> 
> First a similar check was introduced by commit 'c7d05ca89f8e ("i40e: driver
> ethtool core")'
> 
> Later a commit introducing the link settings was added by commit
> 'bf9c71417f72 ("i40e: Implement set_settings for ethtool")'
> 
> However, this second check was against vsi->state instead of pf->state, and
> also failed to set the bit, it only checks. That indicates the locking was not
> quite correct. The only other place that the state bit in vsi->state gets used is
> to protect the filter list.
> 
> Since this code does not care about the mac filter list,  and seems clear the
> original code should have set the pf->state bit. Fix these issues by using pf-
> >state correctly, and by actually setting the bit so that we properly lock as
> expected.
> 
> Since these checks occur while holding the rtnl_lock(), lets also add a timeout
> so that we don't potentially softlock the system.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 38
> ++++++++++++++++++++------
>  1 file changed, 29 insertions(+), 9 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


