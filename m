From: G, GurucharanX <gurucharanx.g@intel.com>
Date: Wed, 22 Sep 2021 18:26:16 +0000
Subject: [Intel-wired-lan] [PATCH v7 intel-next 9/9] ice: make use of
 ice_for_each_* macros
In-Reply-To: <20210819120004.34392-10-maciej.fijalkowski@intel.com>
References: <20210819120004.34392-1-maciej.fijalkowski@intel.com>
 <20210819120004.34392-10-maciej.fijalkowski@intel.com>
Message-ID: <BL0PR11MB3363A83E7180E11CB7B0F908FCA29@BL0PR11MB3363.namprd11.prod.outlook.com>
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
> Subject: [Intel-wired-lan] [PATCH v7 intel-next 9/9] ice: make use of
> ice_for_each_* macros
> 
> Go through the code base and use ice_for_each_* macros.  While at it,
> introduce ice_for_each_xdp_txq() macro that can be used for looping over
> xdp_rings array.
> 
> Commit is not introducing any new functionality.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice.h         |  5 ++++-
>  drivers/net/ethernet/intel/ice/ice_arfs.c    |  2 +-
>  drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  4 ++--
> drivers/net/ethernet/intel/ice/ice_ethtool.c | 10 ++++-----
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 22 ++++++++++----------
>  drivers/net/ethernet/intel/ice/ice_main.c    | 14 ++++++-------
>  6 files changed, 30 insertions(+), 27 deletions(-)
> 

Tested-by: Gurucharan G <gurucharanx.g@intel.com> (A Contingent worker at Intel)
