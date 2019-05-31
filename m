From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 31 May 2019 18:00:35 +0000
Subject: [Intel-wired-lan] [next PATCH S6 6/7] i40e: Fix descriptor
 count manipulation
In-Reply-To: <20190528175921.30534-6-alice.michael@intel.com>
References: <20190528175921.30534-1-alice.michael@intel.com>
 <20190528175921.30534-6-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3DD5DF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Tuesday, May 28, 2019 10:59 AM
> To: alice.micheal at intel.com; intel-wired-lan at lists.osuosl.org
> Cc: Fijalkowski, Maciej <maciej.fijalkowski@intel.com>
> Subject: [Intel-wired-lan] [next PATCH S6 6/7] i40e: Fix descriptor count
> manipulation
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Changing descriptor count via 'ethtool -G' is not persistent across resets.
> When PF reset occurs, we roll back to the default value of vsi->num_desc,
> which is used then in i40e_alloc_rings to set descriptor count. XDP does a PF
> reset so when user has changed the descriptor count and load XDP program,
> the default count will be back there.
> 
> To fix this:
>   * introduce new VSI members - num_tx_desc and num_rx_desc in favour
> of
>     num_desc
>   * set them in i40e_set_ringparam to user's values
>   * set them to default values in i40e_set_num_rings_in_vsi only when they
>     don't have previous values
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h        |  3 +-
>  .../net/ethernet/intel/i40e/i40e_debugfs.c    |  5 +--
>  .../net/ethernet/intel/i40e/i40e_ethtool.c    |  4 +++
>  drivers/net/ethernet/intel/i40e/i40e_main.c   | 36 +++++++++++++------
>  4 files changed, 34 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


