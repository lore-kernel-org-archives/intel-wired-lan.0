From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 15 Oct 2015 19:05:40 +0000
Subject: [Intel-wired-lan] [next PATCH S16 11/15] i40evf: correctly
 populate	vlan_features
In-Reply-To: <1443463964-148204-12-git-send-email-catherine.sullivan@intel.com>
References: <1443463964-148204-1-git-send-email-catherine.sullivan@intel.com>
 <1443463964-148204-12-git-send-email-catherine.sullivan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A060D1DFA@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH S16 11/15] i40evf: correctly populate
> vlan_features
> 
> From: Mitch Williams <mitch.a.williams@intel.com>
> 
> The vlan_features field was correctly being set to the same value as the
> netdev features field. However, this was being done before the features
> were actually being set up, leaving the vlan_features empty.
> 
> Also, after a reset, vlan_features will be incorrectly assigned the previous
> netdev feature flags, which can contain VLAN feature bits. This makes the
> VLAN code angry and will cause a stack dump.
> 
> To fix these issues, set up the netdev features first, then mask out the VLAN
> feature bits when assigning vlan_features.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> Change-ID: Ib0548869dc83cf6a841cb8697dd94c12359ba4d2
> ---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch code changes correctly applied, features shown correctly at init
