From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 20 Sep 2021 05:10:35 +0000
Subject: [Intel-wired-lan] [PATCH net-next v3 2/3] ice: fix rate limit
 update after coalesce change
In-Reply-To: <20210824011259.738307-3-jesse.brandeburg@intel.com>
References: <20210824011259.738307-1-jesse.brandeburg@intel.com>
 <20210824011259.738307-3-jesse.brandeburg@intel.com>
Message-ID: <BYAPR11MB3367279107DD5651D7E73B47FCA09@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Jesse Brandeburg
> Sent: Tuesday, August 24, 2021 6:43 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next v3 2/3] ice: fix rate limit update
> after coalesce change
> 
> If the adaptive settings are changed with ethtool -C ethx adaptive-rx off
> adaptive-tx off then the interrupt rate limit should be maintained as a user
> set value, but only if BOTH adaptive settings are off. Fix a bug where the rate
> limit that was being used in adaptive mode was staying set in the register but
> was not reported correctly by ethtool -c ethx. Due to long lines include a
> small refactor of q_vector variable.
> 
> Fixes: b8b4772377dd ("ice: refactor interrupt moderation writes")
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v3: merged with tx_ring/rx_ring split series.
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 17 +++++++++++------
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  4 ++--
>  2 files changed, 13 insertions(+), 8 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
