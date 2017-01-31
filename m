From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 19:33:06 +0000
Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: do not use
 adapter->num_vfs when setting VFs via module parameter
In-Reply-To: <20170120221156.7616.66811.stgit@localhost6.localdomain6>
References: <20170120221145.7616.93906.stgit@localhost6.localdomain6>
 <20170120221156.7616.66811.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D795@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Friday, January 20, 2017 2:12 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 3/3] ixgbe: do not use adapter->num_vfs
> when setting VFs via module parameter
> 
> Avoid setting adapter->num_vfs early in the init code path when using the
> max_vfs module parameter by passing it to ixgbe_enable_sriov() as a
> function parameter.
> 
> This fixes an issue where if we failed to allocate vfinfo in
> __ixgbe_enable_sriov() the driver will crash with NULL pointer in
> ixgbe_disable_sriov() when attempting to free the vfinfo struct based on
> adapter->num_vfs. Also it cleans up the assignment of adapter->num_vfs
> since now it will only be set in __ixgbe_enable_sriov() and cleared in
> ixgbe_disable_sriov().
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |    6 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.c |   50 ++++++++++++---------
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_sriov.h |    2 -
>  3 files changed, 28 insertions(+), 30 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


