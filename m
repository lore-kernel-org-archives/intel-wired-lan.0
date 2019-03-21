From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 21 Mar 2019 22:27:39 +0000
Subject: [Intel-wired-lan] [PATCH v5] i40e: Add macvlan support on i40e
In-Reply-To: <20190320200335.18121-1-jeffrey.t.kirsher@intel.com>
References: <20190320200335.18121-1-jeffrey.t.kirsher@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D376A99@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Wednesday, March 20, 2019 1:04 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH v5] i40e: Add macvlan support on i40e
> 
> From: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> 
> This patch enables macvlan offloads for i40e. The idea is to use channels as
> macvlan interfaces. The channels are VSIs of type VMDQ. When the first
> macvlan is created, the maximum number of channels possible are created.
> From then on, as a macvlan interface is created, a mac filter is added to these
> already created channels (VSIs).
> 
> This patch builds on top of the recent changes which move away from the
> select_queue implementation of picking the tx queue.
> 
> Steps to configure macvlan offloads:
> 1. ethtool -K ens261f1 l2-fwd-offload on 2. ip link add link ens261f1 name
> macvlan1 type macvlan 3. ip addr add <address> dev macvlan1 4. ip link set
> macvlan1 up
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
> v5: updated the patch description based on community feedback
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      |  26 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 484 +++++++++++++++++++-
>  2 files changed, 508 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


