From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Mon, 13 Sep 2021 06:50:25 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 2/9] ice: move
 ice_container_type onto ice_ring_container
In-Reply-To: <20210819120004.34392-3-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-3-maciej.fijalkowski@intel.com>
Message-ID: <BYAPR11MB3367F482C33461F1861A189DFCD99@BYAPR11MB3367.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 2/9] ice: move
> ice_container_type onto ice_ring_container
> 
> Currently ice_container_type is scoped only for ice_ethtool.c. Next commit
> that will split the ice_ring struct onto Rx/Tx specific ring structs is going to also
> modify the type of linked list of rings that is within ice_ring_container.
> Therefore, the functions that are taking the ice_ring_container as an input
> argument will need to be aware of a ring type that will be looked up.
> 
> Embed ice_container_type within ice_ring_container and initialize it properly
> when allocating the q_vectors.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  2 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 38 ++++++++------------
>  drivers/net/ethernet/intel/ice/ice_txrx.h    |  6 ++++
>  3 files changed, 23 insertions(+), 23 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
