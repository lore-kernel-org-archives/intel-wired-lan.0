From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 25 Apr 2016 22:34:23 +0000
Subject: [Intel-wired-lan] [next PATCH S33 10/13] i40e/i40evf: Only
 offload	vlan tag if enabled
In-Reply-To: <1460475052-6348-11-git-send-email-harshitha.ramamurthy@intel.com>
References: <1460475052-6348-1-git-send-email-harshitha.ramamurthy@intel.com>
 <1460475052-6348-11-git-send-email-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D4DED@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, April 12, 2016 8:31 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S33 10/13] i40e/i40evf: Only offload
> vlan tag if enabled
> 
> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The driver was offloading the vlan tag into the skb any time there was a vlan
> tag and the hardware stripping was enabled.  Just check to make sure it's
> enabled before put_tag.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Change-Id: Ife95290c06edd9a616393b38679923938b382241
> ---
> Testing Hints : Make sure ethtool control over RX vlan tag insertion/removal
> still works.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 3 ++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VLAN offloading can be enabled and disabled with ethtool and works correctly.
