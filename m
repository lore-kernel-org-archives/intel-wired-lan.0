From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Jul 2016 21:14:59 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Explicitly write
 platform-specific	mac address after PF reset
In-Reply-To: <1467393080-2202-1-git-send-email-tushar.n.dave@oracle.com>
References: <1467393080-2202-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9EAF84@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Tushar Dave
> Sent: Friday, July 01, 2016 10:11 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; Brandeburg, Jesse
> <jesse.brandeburg@intel.com>; shannon.nelson at intel.com; Wyborny,
> Carolyn <carolyn.wyborny@intel.com>; Skidmore, Donald C
> <donald.c.skidmore@intel.com>; Allan, Bruce W <bruce.w.allan@intel.com>;
> john.ronciak at intel.com; Williams, Mitch A <mitch.a.williams@intel.com>;
> intel-wired-lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: sowmini.varadhan at oracle.com
> Subject: [Intel-wired-lan] [PATCH] i40e: Explicitly write platform-specific mac
> address after PF reset
> 
> i40e PF reset clears mac filters. If platform-specific mac address is used,
> driver has to explicitly write default mac address to mac filters otherwise all
> incoming traffic destined to default mac address will be dropped after reset.
> 
> This issue was found on SPARC while toggling i40e ntuple via ethtool.
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> Acked-by: Sowmini Varadhan <sowmini.varadhan@oracle.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 87 ++++++++++++++++-------
> ------
>  1 file changed, 49 insertions(+), 38 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
