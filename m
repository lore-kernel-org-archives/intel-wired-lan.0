From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:36:07 +0000
Subject: [Intel-wired-lan] [next PATCH v2 09/11] ixgbe: Add private flag
 to	control buffer mode
In-Reply-To: <20170117163700.5423.65006.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163700.5423.65006.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D6D0@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 17, 2017 8:37 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v2 09/11] ixgbe: Add private flag to
> control buffer mode
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Since there are potential drawbacks to the new Rx allocation approach I
> thought it best to add a "chicken bit" so that we can turn the feature off if in
> the event that a problem is found.
> 
> It also provides a means of validating the legacy Rx path in the event that we
> are forced to fall back.  At some point in the future when we are convinced
> we don't need it anymore we might be able to drop the legacy-rx flag.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   47
> ++++++++++++++++++++++
>  1 file changed, 47 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


