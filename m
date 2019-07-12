From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 12 Jul 2019 17:44:49 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Link lost in VM on ixgbevf
 when restoring from freeze or suspend
In-Reply-To: <20190704134842.7900-1-radoslawx.tyl@intel.com>
References: <20190704134842.7900-1-radoslawx.tyl@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D40AB7E@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Radoslaw Tyl
> Sent: Thursday, July 4, 2019 6:49 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Link lost in VM on ixgbevf when
> restoring from freeze or suspend
> 
> This patch fixed issue in VM which shows no link when hypervisor is restored
> from low-power state. The driver is responsible for reenabling any features
> of the device that had been disabled during suspend calls, such as IRQs and
> bus mastering.
> 
> Signed-off-by: Radoslaw Tyl <radoslawx.tyl@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c | 1 +
>  1 file changed, 1 insertion(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


