From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 20 Apr 2016 21:21:13 +0000
Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf:
	Add	support for GSO partial
In-Reply-To: <20160414211931.14141.18864.stgit@ahduyck-xeon-server>
References: <20160414210725.14141.25917.stgit@ahduyck-xeon-server>
 <20160414211931.14141.18864.stgit@ahduyck-xeon-server>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9D2658@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, April 14, 2016 2:20 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>; alexander.duyck at gmail.com
> Subject: [Intel-wired-lan] [next-queue PATCH v2 2/3] ixgbe/ixgbevf: Add
> support for GSO partial
> 
> This patch adds support for partial GSO segmentation in the case of tunnels.
> Specifically with this change the driver an perform segmenation as long as
> the frame either has IPv6 inner headers, or we are allowed to mangle the IP
> IDs on the inner header.  This is needed because we will not be modifying
> any fields from the start of the start of the outer transport header to the
> start of the inner transport header as we are treating them like they are just
> a block of IP options.
> 
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c     |  133 ++++++++++++++--
> -----
>  drivers/net/ethernet/intel/ixgbevf/ixgbevf_main.c |  129
> +++++++++++++++-----
>  2 files changed, 180 insertions(+), 82 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>
GRE tunnel traffic works as expected with speed increase with GSO on
