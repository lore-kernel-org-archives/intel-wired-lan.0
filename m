From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:35:26 +0000
Subject: [Intel-wired-lan] [next PATCH v2 07/11] ixgbe: Break out Rx
 buffer	page management
In-Reply-To: <20170117163634.5423.68644.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163634.5423.68644.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D6B0@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v2 07/11] ixgbe: Break out Rx buffer
> page management
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> We are going to be expanding the number of Rx paths in the driver.  Instead
> of duplicating all that code I am pulling it apart into separate functions so that
> we don't have so much code duplication.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Update patch to incorporate addition of ring to can_reuse_page function
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  231 +++++++++++++------
> ------
>  1 file changed, 122 insertions(+), 109 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


