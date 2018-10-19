From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 19 Oct 2018 16:11:51 +0000
Subject: [Intel-wired-lan] [net-next 3/3] fm10k: add missing device IDs
 to the upstream driver
In-Reply-To: <20181015191829.17115-4-jacob.e.keller@intel.com>
References: <20181015191829.17115-1-jacob.e.keller@intel.com>
 <20181015191829.17115-4-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D3108F2@FMSMSX152.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, October 15, 2018 12:18 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [net-next 3/3] fm10k: add missing device IDs to the
> upstream driver
> 
> The device IDs for the Ethernet SDI Adapter devices were never added to
> the upstream driver. The IDs are already in the pci.ids database, and are
> supported by the out-of-tree driver.
> 
> Add the device IDs now, so that the upstream driver can recognize and load
> these devices.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  drivers/net/ethernet/intel/fm10k/fm10k_pci.c  | 2 ++
> drivers/net/ethernet/intel/fm10k/fm10k_type.h | 2 ++
>  2 files changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


