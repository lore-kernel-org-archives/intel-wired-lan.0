From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 18:43:42 +0000
Subject: [Intel-wired-lan] [next PATCH 1/3] ixgbe: Allow setting
 multiple queues when SR-IOV is enabled
In-Reply-To: <20160908032811.25312.38792.stgit@localhost.localdomain>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
 <20160908032811.25312.38792.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCA3A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Wednesday, September 07, 2016 8:28 PM
> To: intel-wired-lan at lists.osuosl.org
> Cc: ruslan at purestorage.com; Jayakumar, Muthurajan
> <muthurajan.jayakumar@intel.com>; Blevins, Christopher R
> <christopher.r.blevins@intel.com>
> Subject: [Intel-wired-lan] [next PATCH 1/3] ixgbe: Allow setting multiple
> queues when SR-IOV is enabled
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The maximum queue count reported was 1, however support for multiple
> queues with SR-IOV was added some time ago so we should report support
> for it to the user so that they can select multiple queues if they so desire.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>

