From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 1 Mar 2016 18:23:27 +0000
Subject: [Intel-wired-lan] [next PATCH 2/3] ixgbe: Store VXLAN port
 number	in network order
In-Reply-To: <20160126033300.16387.35470.stgit@localhost.localdomain>
References: <20160126032616.16387.86351.stgit@localhost.localdomain>
 <20160126033300.16387.35470.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F99C163@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Monday, January 25, 2016 7:36 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 2/3] ixgbe: Store VXLAN port number
> in network order
> 
> The VXLAN port number should be stored in network order instead of in host
> order as it is accessed from the hot-path in ATR.  This way we can avoid
> having to do any byte swaps in order to validate the port number.
> 
> I moved the vxlan_port value into a hole in the read-mostly region of the
> adapter struct.  This way it should be in a warm cache-line instead of in some
> isolated region in memory when it needs to be accessed.
> 
> In addition I went through and stripped a bunch of unneeded ifdef flags since
> having an extra variable present doesn't really hurt anything and makes the
> code easier to read.  I also went through and dropped the NETIF_F_RXCSUM
> flag which was being set in hw_encap_features but provides no value as the
> flag is not evaluated in the Rx path.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
> 
> Testing Hints:
> Test with X550 to verify that VXLAN offloads are still occurring as they should.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h      |    8 +--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   61 +++++++-----------------
> -
>  2 files changed, 20 insertions(+), 49 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
VxLAN offload works correctly
