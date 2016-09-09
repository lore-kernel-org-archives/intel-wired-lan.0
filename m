From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 9 Sep 2016 18:46:03 +0000
Subject: [Intel-wired-lan] [next PATCH 3/3] ixgbe: Support 4 queue RSS
 on VFs with 1 or 2 queue RSS on PF
In-Reply-To: <20160908032824.25312.34696.stgit@localhost.localdomain>
References: <20160908032606.25312.86849.stgit@localhost.localdomain>
 <20160908032824.25312.34696.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FCA5A@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH 3/3] ixgbe: Support 4 queue RSS on
> VFs with 1 or 2 queue RSS on PF
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> Instead of limiting the VFs if we don't use 4 queues for RSS in the PF we can
> instead just limit the RSS queues used to a power of 2.  By doing this we can
> support use cases where VFs are using more queues than the PF is currently
> using and can support RSS if so desired.
> 
> The only limitation on this is that we cannot support 3 queues of RSS in the PF
> or VF.  In either of these cases we should fall back to 2 queues in order to be
> able to use the power of 2 masking provided by the psrtype register.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c  |    7 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   12 +++++++-----
>  2 files changed, 11 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


