From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 19 Dec 2018 19:54:22 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Add macvlan support on i40e
In-Reply-To: <20181218215456.15494-1-harshitha.ramamurthy@intel.com>
References: <20181218215456.15494-1-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3437F5@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Tuesday, December 18, 2018 1:55 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Duyck, Alexander H <alexander.h.duyck@intel.com>
> Subject: [Intel-wired-lan] [PATCH] i40e: Add macvlan support on i40e
> 
> This patch enables macvlan offloads on Fortville devices. The idea is to use
> channels as macvlan interfaces. The channels are VSIs of type VMDQ. When
> the first macvlan is created, the maximum no. of channels possible are
> created. From then on, as a macvlan interface is created, a mac filter is added
> to these already created channels (VSIs).
> 
> This patch builds on top of the recent changes which move away from the
> select_queue implementation of picking the tx queue.
> 
> Steps to configure the macvlan:
> 1. sudo ethtool -K ens261f1 l2-fwd-offload on 2. ip link add link ens261f1
> name macvlan1 type macvlan 3. sudo ip link add link ens261f1 name macvlan1
> type macvlan 4. sudo ip link set macvlan1 up
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e.h      |  26 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 425 +++++++++++++++++++-
>  2 files changed, 449 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


