From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 26 Jun 2019 22:24:24 +0000
Subject: [Intel-wired-lan] [PATCH v6] i40e: Add macvlan support on i40e
In-Reply-To: <20190619184540.21298-1-harshitha.ramamurthy@intel.com>
References: <20190619184540.21298-1-harshitha.ramamurthy@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3FB4F1@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Harshitha Ramamurthy
> Sent: Wednesday, June 19, 2019 11:46 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: harshitha.ramamurthy at gmail.com
> Subject: [Intel-wired-lan] [PATCH v6] i40e: Add macvlan support on i40e
> 
> This patch enables macvlan offloads for i40e. The idea is to use channels as
> macvlan interfaces. The channels are VSIs of type VMDQ. When the first
> macvlan is created, the maximum number of channels possible are created.
> From then on, as a macvlan interface is created, a macvlan filter is added to
> these already created channels (VSIs).
> 
> This patch utilizes subordinate device traffic classes to make queue
> groups(channels) available for an upper device like a macvlan.
> 
> Steps to configure macvlan offloads:
> 1. ethtool -K ethx l2-fwd-offload on
> 2. ip link add link ethx name macvlan1 type macvlan 3. ip addr add <address>
> dev macvlan1 4. ip link set macvlan1 up
> 
> Signed-off-by: Harshitha Ramamurthy <harshitha.ramamurthy@intel.com>
> ---
> v6: Fixed a bug in calculation of macvlans to enable when there are
>     smaller number of vectors
> 
> v5: updated patch description based on community feedback
> 
> v4: Added code to check for a non-empty list of macvlans before deleting
>     them
> 
> v3: Renamed i40e_remove_macvlan_channels() to
>     i40e_free_macvlan_channels()
>     Fixed an indentation issue and added some comments
>     Removed a code name from the commit message
>     Addressed some more of Shannon's comments
> 
> v2: Addressed Shannon's comments
>     Added a new function to remove all macvlan VSIs
> 
>  drivers/net/ethernet/intel/i40e/i40e.h      |  27 ++
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 491 +++++++++++++++++++-
>  2 files changed, 516 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


