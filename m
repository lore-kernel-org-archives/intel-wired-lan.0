From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 3 Apr 2019 21:54:11 +0000
Subject: [Intel-wired-lan] [next PATCH S4 01/11] i40e: VF's promiscuous
 attribute is not kept
In-Reply-To: <20190329220840.51187-1-alice.michael@intel.com>
References: <20190329220840.51187-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D378791@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, March 29, 2019 3:09 PM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Cc: Siwik, Grzegorz <grzegorz.siwik@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S4 01/11] i40e: VF's promiscuous
> attribute is not kept
> 
> From: Grzegorz Siwik <grzegorz.siwik@intel.com>
> 
> This patch fixes a bug where the promiscuous mode was not being kept
> when the VF switched to a new VLAN.
> Now we are config two times a promiscuous mode when we switch VLAN.
> Without this change when we change VF VLAN we still receive all the packets
> from previous VLAN and only unicast from new VLAN.
> 
> Signed-off-by: Grzegorz Siwik <grzegorz.siwik@intel.com>
> ---
>  .../ethernet/intel/i40e/i40e_virtchnl_pf.c    | 23 +++++++++++++++++++
>  1 file changed, 23 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


