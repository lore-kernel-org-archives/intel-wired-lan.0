From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Tue, 14 Dec 2021 09:37:10 +0000
Subject: [Intel-wired-lan] [PATCH intel-next] ice: Don't put stale
 timestamps in the skb
In-Reply-To: <20211116120714.310539-1-karol.kolacinski@intel.com>
References: <20211116120714.310539-1-karol.kolacinski@intel.com>
Message-ID: <BYAPR11MB3367FA6D070426952E18543BFC759@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Karol
> Kolacinski
> Sent: Tuesday, November 16, 2021 5:37 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Kolacinski, Karol <karol.kolacinski@intel.com>
> Subject: [Intel-wired-lan] [PATCH intel-next] ice: Don't put stale timestamps in
> the skb
> 
> The driver has to check if it does not accidentally put the timestamp in the SKB
> before previous timestamp gets overwritten.
> Timestamp values in the PHY are read only and do not get cleared except at
> hardware reset or when a new timestamp value is captured.
> The cached_tstamp field is used to detect the case where a new timestamp has
> not yet been captured, ensuring that we avoid sending stale timestamp data to
> the stack.
> 
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_ptp.c | 11 ++++-------
> drivers/net/ethernet/intel/ice/ice_ptp.h |  6 ++++++
>  2 files changed, 10 insertions(+), 7 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
