From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 6 Apr 2016 18:35:42 +0000
Subject: [Intel-wired-lan] [PATCH V5 05/11] ixgbe: Read and set instance
 id
In-Reply-To: <20160401191819.120975.51167.stgit@mdrustad-wks.jf.intel.com>
References: <20160401191701.120975.34684.stgit@mdrustad-wks.jf.intel.com>
 <20160401191819.120975.51167.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9ACF6A@ORSMSX106.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Friday, April 01, 2016 12:18 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V5 05/11] ixgbe: Read and set instance id
> 
> Read the instance number from EEPROM and save it for later use.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    8 ++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |    5 +++++
>  2 files changed, 13 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch applied and compiles cleanly, driver correctly communicates with device

