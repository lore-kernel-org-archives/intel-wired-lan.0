From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 15 Oct 2019 23:16:15 +0000
Subject: [Intel-wired-lan] [PATCH S30 7/9] ice: introduce frame padding
 computation logic
In-Reply-To: <20191009140925.13997-7-anthony.l.nguyen@intel.com>
References: <20191009140925.13997-1-anthony.l.nguyen@intel.com>
 <20191009140925.13997-7-anthony.l.nguyen@intel.com>
Message-ID: <2616c4cd1a584ac69e414bf52b32a8d7@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Tony Nguyen
> Sent: Wednesday, October 9, 2019 7:09 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH S30 7/9] ice: introduce frame padding
> computation logic
> 
> From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> 
> Take into account the underlying architecture specific settings and based on
> that calculate the possible padding that can be supplied.
> Typically, for x86 and standard MTU size we will end up with 192 bytes of
> headroom. This is the same behavior as our other drivers have and we can
> dedicate it for XDP purposes.
> 
> Furthermore, introduce the Rx ring flag for indicating whether build_skb is
> used on particular. Based on that invoke the routines for padding calculation.
> 
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c    |  6 ++
>  drivers/net/ethernet/intel/ice/ice_ethtool.c |  2 +-
>  drivers/net/ethernet/intel/ice/ice_lib.c     |  3 +-
>  drivers/net/ethernet/intel/ice/ice_txrx.c    | 42 +++++-----
>  drivers/net/ethernet/intel/ice/ice_txrx.h    | 81 ++++++++++++++++++++
>  5 files changed, 114 insertions(+), 20 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


