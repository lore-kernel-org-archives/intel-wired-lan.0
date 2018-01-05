From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 5 Jan 2018 19:32:18 +0000
Subject: [Intel-wired-lan] [next PATCH S85-V1 13/14] i40e/i40evf: Split
 container ITR into current_itr and target_itr
In-Reply-To: <20171229135125.14740-1-alice.michael@intel.com>
References: <20171229135125.14740-1-alice.michael@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A8D7287@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Alice Michael
> Sent: Friday, December 29, 2017 5:51 AM
> To: Michael, Alice <alice.michael@intel.com>; intel-wired-
> lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S85-V1 13/14] i40e/i40evf: Split
> container ITR into current_itr and target_itr
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is mostly prep-work for replacing the current approach to
> programming the dynamic aka adaptive ITR. Specifically here what we are
> doing is splitting the Tx and Rx ITR each into two separate values.
> 
> The first value current_itr represents the current value of the register.
> 
> The second value target_itr represents the desired value of the register.
> 
> The general plan by doing this is to allow for deferring the update of the ITR
> value under certain circumstances. For now we will work with what we have,
> but in the future I hope to change the behavior so that we always only
> update one ITR at a time using some simple logic to determine which ITR
> requires an update.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c     | 13 +++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c        | 22 ++++---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c        | 68 +++++++++++++---------
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h        |  5 +-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c      | 68 +++++++++++++-------
> --
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.h      |  5 +-
>  drivers/net/ethernet/intel/i40evf/i40evf_ethtool.c | 14 ++---
>  drivers/net/ethernet/intel/i40evf/i40evf_main.c    | 10 ++--
>  8 files changed, 117 insertions(+), 88 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


