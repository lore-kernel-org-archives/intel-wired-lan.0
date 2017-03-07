From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 7 Mar 2017 19:21:52 +0000
Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix output from ixgbe_dump
In-Reply-To: <20170302230136.8845.40421.stgit@localhost.localdomain>
References: <20170302230136.8845.40421.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10401FCA@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Thursday, March 2, 2017 3:02 PM
> To: intel-wired-lan at lists.osuosl.org; Kirsher, Jeffrey T
> <jeffrey.t.kirsher@intel.com>
> Subject: [Intel-wired-lan] [net PATCH] ixgbe: Fix output from ixgbe_dump
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> I just found that when we had changed the Rx path to check for length
> instead of the DD bit we introduced an issue in ixgbe_dump since we were
> no longer clearing the status bits.
> 
> To correct this I am updating ixgbe_dump to look for the length bits in the
> descriptor since that is what we are using in the Rx path.
> 
> Fixes: c3630cc40b4f ("ixgbe: Use length to determine if descriptor is done")
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


