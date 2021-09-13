From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 13 Sep 2021 06:47:20 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 1/9] ice: remove
 ring_active from ice_ring
In-Reply-To: <20210819120004.34392-2-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-2-maciej.fijalkowski@intel.com>
Message-ID: <BYAPR11MB3367F6285437BF1AFB7C5A5EFCD99@BYAPR11MB3367.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


> -----Original Message-----
> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of
> Maciej Fijalkowski
> Sent: Thursday, August 19, 2021 5:30 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org;
> kuba at kernel.org; bpf at vger.kernel.org; davem at davemloft.net; Karlsson,
> Magnus <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 1/9] ice: remove ring_active
> from ice_ring
> 
> This field is dead and driver is not making any use of it. Simply remove it.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c  | 2 --
> drivers/net/ethernet/intel/ice/ice_main.c | 1 -
> drivers/net/ethernet/intel/ice/ice_txrx.h | 2 --
>  3 files changed, 5 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
