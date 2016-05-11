From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 11 May 2016 23:04:54 +0000
Subject: [Intel-wired-lan] [next PATCH] ixgbe: Fix VLAN features error
In-Reply-To: <20160511202334.6128.46021.stgit@localhost.localdomain>
References: <20160511202334.6128.46021.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D6190@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, May 11, 2016 1:24 PM
> To: Schmitt, Phillip J <phillip.j.schmitt@intel.com>; intel-wired-
> lan at lists.osuosl.org; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next PATCH] ixgbe: Fix VLAN features error
> 
> It looks like at some point I somehow transposed the location of setting the
> VLAN features in netdev->features and the configuration of the
> vlan_features.  As a result the driver is now generating a warning about
> vlan_features being setup incorrectly.
> 
> This patch corrects that by placing the update of netdev->features to include
> the VLAN features so that it is after the point where we write
> netdev->features into netdev->vlan_features.
> 
> Fixes: b83e30104bd9 ("ixgbe/ixgbevf: Add support for GSO partial")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
An error is no longer received when creating VLAN interfaces on ixgbe devices
