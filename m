From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 14 Feb 2019 22:51:40 +0000
Subject: [Intel-wired-lan] [PATCH S11 04/16] ice: sizeof(<type>) should
 be avoided
In-Reply-To: <20190208205043.11975-5-anirudh.venkataramanan@intel.com>
References: <20190208205043.11975-1-anirudh.venkataramanan@intel.com>
 <20190208205043.11975-5-anirudh.venkataramanan@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3661F2@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Anirudh Venkataramanan
> Sent: Friday, February 8, 2019 12:51 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S11 04/16] ice: sizeof(<type>) should be
> avoided
> 
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> With sizeof(), it is preferable to use the variable of type <type> instead of
> sizeof(<type>).
> 
> There are multiple places where a temporary variable is used to hold a 'size'
> value which is then used for a subsequent alloc/memset. Get rid of the
> temporary variable by calculating size as part of the alloc/memset statement.
> 
> Also remove unnecessary type-cast.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> Signed-off-by: Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com>
> ---
> [Anirudh Venkataramanan <anirudh.venkataramanan@intel.com> fixed
> checkpatch errors] [Anirudh Venkataramanan
> <anirudh.venkataramanan@intel.com> edited commit message]
> ---
>  drivers/net/ethernet/intel/ice/ice_ethtool.c | 15 +++++++--------
>  drivers/net/ethernet/intel/ice/ice_lib.c     | 10 +++++-----
>  drivers/net/ethernet/intel/ice/ice_main.c    | 23 +++++++++++------------
>  drivers/net/ethernet/intel/ice/ice_sched.c   |  9 ++++-----
>  drivers/net/ethernet/intel/ice/ice_switch.c  |  2 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 24 ++++++++++--------------
>  6 files changed, 38 insertions(+), 45 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


