From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 20 Mar 2017 23:03:57 +0000
Subject: [Intel-wired-lan] [next PATCH S62 2/6] i40e: Clean up handling
 of	private flags
In-Reply-To: <1489177325-13156-3-git-send-email-bimmy.pujari@intel.com>
References: <1489177325-13156-1-git-send-email-bimmy.pujari@intel.com>
 <1489177325-13156-3-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A104066C7@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, March 10, 2017 12:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S62 2/6] i40e: Clean up handling of
> private flags
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch cleans up and addresses several issues in the way that i40e
> handles private flags. Previously the code was choosing fixed bits and trying
> to match them up with strings in a somewhat haphazard way. This resulted in
> the possibility for adding a new bit and causing a mismatch as the private
> flags are linear bits starting at 0, and the private flags in the driver were split
> up over a group specific to the PF and a group that was global.
> 
> What this change does is define an array of structs used to represent the
> private flags. Contained within the structs are the bits necessary to know
> which flags to set and/or clear depending on the state of the bit. By doing
> this we can add new bits in the future with minimal overhead and avoid
> creating possible mis-matches should we need to remove a flag based on
> compile options.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: Ia3214ab04f0ab2f70354ac0997a135f1d01b0acd
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h         |   8 --
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 189 +++++++++++++++----
> ------
>  2 files changed, 112 insertions(+), 85 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


