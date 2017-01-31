From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 31 Jan 2017 17:36:48 +0000
Subject: [Intel-wired-lan] [next PATCH v2 11/11] ixgbe: Don't bother
 clearing buffer memory for descriptor rings
In-Reply-To: <20170117163719.5423.93533.stgit@localhost.localdomain>
References: <20170117163401.5423.37993.stgit@localhost.localdomain>
 <20170117163719.5423.93533.stgit@localhost.localdomain>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA5D6F2@ORSMSX104.amr.corp.intel.com>
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
> Subject: [Intel-wired-lan] [next PATCH v2 11/11] ixgbe: Don't bother clearing
> buffer memory for descriptor rings
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch makes it so that we don't need to bother with clearing the
> memory out for the descriptor rings.  The general idea is to only free buffers
> associated with buffers in use which are located between the next_to_clean
> and next_to_use or next_to_alloc values.  Everything outside of those
> regions can be safely ignored since they should have no buffers associated
> with them.
> 
> The advantage to doing things this way is that is should speed up bring-up
> and tear-down of the rings.  Specifically we can avoid the 512 or more cycles
> required to memset the rings in tear-down.  In the bring-up phase we then
> clear the memory as a part of initialization.  The general idea is that the
> clearing in initialization can act as a prefetch of sorts for the buffer info
> structures so they are in the local CPU when we go to populate them.  This
> should help to improve overall time needed to perform a suspend/resume.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
> 
> v2: Fixed Tx mapping exception path to reset tx_buffer address
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |   11 +-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  159 ++++++++++++------
> ----
>  2 files changed, 99 insertions(+), 71 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


