From: Kuruvinakunnel, George <george.kuruvinakunnel@intel.com>
Date: Fri, 3 Sep 2021 06:54:50 +0000
Subject: [Intel-wired-lan] [PATCH v6 intel-next 9/9] ice: make use of
 ice_for_each_* macros
In-Reply-To: <20210818135916.25007-10-maciej.fijalkowski@intel.com>
References: <20210818135916.25007-1-maciej.fijalkowski@intel.com>
 <20210818135916.25007-10-maciej.fijalkowski@intel.com>
Message-ID: <PH0PR11MB51445B9EAB6E3DE927E8FBAEE2CF9@PH0PR11MB5144.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf Of Maciej
> Fijalkowski
> Sent: Wednesday, August 18, 2021 7:29 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: joamaki at gmail.com; Lobakin, Alexandr <alexandr.lobakin@intel.com>;
> netdev at vger.kernel.org; toke at redhat.com; bjorn at kernel.org; kuba at kernel.org;
> bpf at vger.kernel.org; davem at davemloft.net; Karlsson, Magnus
> <magnus.karlsson@intel.com>
> Subject: [Intel-wired-lan] [PATCH v6 intel-next 9/9] ice: make use of ice_for_each_*
> macros
> 
> Go through the code base and use ice_for_each_* macros.  While at it, introduce
> ice_for_each_xdp_txq() macro that can be used for looping over xdp_rings array.
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

Tested-by: George Kuruvinakunnel <george.kuruvinakunnel@intel.com>
