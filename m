From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 16 Aug 2016 20:34:08 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: add support for geneve Rx
 offload
In-Reply-To: <20160810181923.14875.61286.stgit@localhost6.localdomain6>
References: <20160810181923.14875.61286.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9F8F9D@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Wednesday, August 10, 2016 11:19 AM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbe: add support for geneve Rx offload
> 
> Add geneve Rx offload support for x550em_a.
> 
> The implementation follows the vxlan code with the lower 16 bits of the
> VXLANCTRL register holding the UDP port for VXLAN and the upper for
> Geneve.
> 
> Disabled NFS filters in the RFCTL register which allows us to simplify the check
> for VXLAN and Geneve packets in ixgbe_rx_checksum().
> 
> Removed vxlan from the name of the callback functions and replaced it with
> udp_tunnel which is more in line with the new API.
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    4 -
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  174
> ++++++++++++++++++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_type.h |    7 +
>  3 files changed, 134 insertions(+), 51 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
