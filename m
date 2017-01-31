From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:35:06 +0000
Subject: [Intel-wired-lan] [next PATCH v2 06/11] ixgbe: Use length to
 determine if descriptor is done
In-Reply-To: <20170117163620.5423.4591.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163620.5423.4591.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D69C@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, January 17, 2017 8:36 AM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [next PATCH v2 06/11] ixgbe: Use length to
> determine if descriptor is done
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This change makes it so that we use the length of the packet instead of the
> DD status bit to determine if a new descriptor is ready to be processed.
> The obvious advantage is that it cuts down on reads as we don't really even
> need the DD bit if going from a 0 to a non-zero value on size is enough to
> inform us that the packet has been completed.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Update ethtool loopback test to use length check instead of DD check
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |    2 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |   14 ++++++++------
>  2 files changed, 9 insertions(+), 7 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


