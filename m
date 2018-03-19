From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 19 Mar 2018 18:41:52 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add status reg reads to
 ixgbe_check_remove
In-Reply-To: <1520860975-110746-1-git-send-email-paul.greenwalt@intel.com>
References: <1520860975-110746-1-git-send-email-paul.greenwalt@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A94C93F@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Paul Greenwalt
> Sent: Monday, March 12, 2018 6:23 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add status reg reads to
> ixgbe_check_remove
> 
> Add status register reads and delay between reads to ixgbe_check_remove.
> Registers can read 0xFFFFFFFF during pci reset, which causes the driver to
> remove the adapter. The additional status register reads can reduce the
> chance of this race condition.
> 
> If the status register is not 0xFFFFFFFF, then ixgbe_check_remove returns
> the value of the register being read.
> 
> Signed-off-by: Paul Greenwalt <paul.greenwalt@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |  1 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c   | 31 ++++++++++++++++--
> -------
>  2 files changed, 21 insertions(+), 11 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


