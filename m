From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 24 Mar 2017 19:47:59 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: Acquire PHY semaphore
	before	device reset
In-Reply-To: <1489398476-15893-1-git-send-email-paul.greenwalt@intel.com>
References: <1489398476-15893-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10409FE2@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Monday, March 13, 2017 2:48 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: Acquire PHY semaphore before
> device reset
> 
> A recent firmware change fixed an issue to acquire the PHY semaphore
> before accessing PHY registers. This led to a case where  SW can issue a
> device reset clearing the MDIO registers. This patch makes SW acquire the
> PHY semaphore before issuing a device reset.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x540.c | 8 ++++++++
> drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c | 8 ++++++++
>  2 files changed, 16 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


