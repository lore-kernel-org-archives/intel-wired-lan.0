From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 4 Apr 2016 19:15:40 +0000
Subject: [Intel-wired-lan] [PATCH V5 02/11] ixgbe: Use method pointer
	to	access IOSF devices
In-Reply-To: <20160401191804.120975.50527.stgit@mdrustad-wks.jf.intel.com>
References: <20160401191701.120975.34684.stgit@mdrustad-wks.jf.intel.com>
 <20160401191804.120975.50527.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9AA967@ORSMSX106.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [PATCH V5 02/11] ixgbe: Use method pointer to
> access IOSF devices
> 
> Provide method pointers and use them to access IOSF-attached devices. A
> new MAC will introduce a new access method.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    2 ++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c |   32 ++++++++++++++------
> -----
>  2 files changed, 20 insertions(+), 14 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
Patch applied and compiles cleanly, hardware correctly recognized and passes traffic
