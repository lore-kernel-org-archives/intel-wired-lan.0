From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 10 Mar 2016 18:42:53 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Place SWFW semaphore in
	known	valid state at probe
In-Reply-To: <1457559900-7031-1-git-send-email-donald.c.skidmore@intel.com>
References: <1457559900-7031-1-git-send-email-donald.c.skidmore@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99CCF3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Donald C Skidmore
> Sent: Wednesday, March 09, 2016 1:45 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Place SWFW semaphore in known
> valid state at probe
> 
> From: Don Skidmore <donald.c.skidmore@intel.com>
> 
> It is possible on some HW that a system reset could occur when we are
> holding the SWFW semaphore lock.  So next time the driver was loaded we
> would see it incorrectly as locked. This patch will recover from that state
> by: Attempting to aquire the semaphore and then regardless of whether or
> not it was aquire we immediately release it. This will force us into a known
> good state.
> 
> Signed-off-by: Donald C Skidmore <donald.c.skidmore@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_82599.c |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_main.c  |  4 ++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_type.h  |  1 +
> drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c  | 20
> ++++++++++++++++++++  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.h  |
> 1 +  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c  |  2 ++
>  7 files changed, 30 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Driver correctly builds and passes traffic normally.
