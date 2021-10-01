From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Fri, 1 Oct 2021 15:12:18 +0000
Subject: [Intel-wired-lan] [PATCH net-next] ice: fix getting UDP tunnel
 entry
In-Reply-To: <BYAPR11MB336720434076C532018850BBFCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
References: <20210914232505.8117-1-user@wasp>
 <BYAPR11MB3367264BEB0D2D3900A07035FCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB3367E3C1301A94EE962CC629FCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
 <BYAPR11MB336720434076C532018850BBFCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
Message-ID: <BYAPR11MB3367AF7DB2EA07601748E4E1FCAB9@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> Of Michal Swiatkowski
> Sent: Wednesday, September 15, 2021 4:55 AM
> To: intel-wired-lan at osuosl.org
> Subject: [Intel-wired-lan] [PATCH net-next] ice: fix getting UDP
> tunnel entry
>
> From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>
> Correct parameters order in call to ice_tunnel_idx_to_entry function.
>
> Entry in sparse port table is correct when the idx is 0. For idx 1 one
> correct entry should be skipped, for idx 2 two of them should be
> skipped
etc.
> Change if condition to be true when idx is 0, which means that
> previous valid entry of this tunnel type were skipped.
>
> Fixes: b20e6c17c468 ("ice: convert to new udp_tunnel infrastructure")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_flex_pipe.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
