From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 8 Dec 2016 18:19:42 +0000
Subject: [Intel-wired-lan] [PATCH V3 3/4] ixgbe: Implement firmware
 interface to access some PHYs
In-Reply-To: <148115001069.19165.10838022666033887490.stgit@mdrustad-wks.jf.intel.com>
References: <148114991608.19165.8749732086590634860.stgit@mdrustad-wks.jf.intel.com>
 <148115001069.19165.10838022666033887490.stgit@mdrustad-wks.jf.intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA39B3C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Mark D Rustad
> Sent: Wednesday, December 07, 2016 2:34 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH V3 3/4] ixgbe: Implement firmware
> interface to access some PHYs
> 
> Implement new interface for firmware commands to access some PHYs.
> 
> Signed-off-by: Mark Rustad <mark.d.rustad@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.h |    2 +
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h   |   66
> +++++++++++++++++++++++
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |   45 ++++++++++++++++
>  3 files changed, 113 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


