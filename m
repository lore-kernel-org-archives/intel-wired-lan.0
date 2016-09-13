From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 13 Sep 2016 20:34:20 +0000
Subject: [Intel-wired-lan] [next PATCH S46 3/8] i40e: Fix Flow
	Director	raw_buf cleanup
In-Reply-To: <1473715124-31296-4-git-send-email-bimmy.pujari@intel.com>
References: <1473715124-31296-1-git-send-email-bimmy.pujari@intel.com>
 <1473715124-31296-4-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0F9FD175@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, September 12, 2016 2:19 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S46 3/8] i40e: Fix Flow Director
> raw_buf cleanup
> 
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> The Tx cleanup flow was incorrectly assuming it could check for the flow
> director bits after it had unmapped the buffer.  However in this case it results
> in us trying to free a raw_buf as though it is an sk_buff.
> 
> To fix this I am moving up the flag test for the FD_SB bit so that when find a
> non-NULL skb or raw_buf value we then check the flag and use the
> appropriate call to free the buffer.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> Change-ID: I6284034ba1ea87c9922e56f6eb3181f7f09bddde
> ---
> Testing Hints:
>         The issue fixed here would present itself as a memory leak or data
>         corruption.  The trick would be to find a way to cause the Tx ring
>         for the Flow Director sideband to have buffers on it when the queue
>         is disabled.  This would likely require ifconfig up/down on the
>         interface in a loop while also adding filters.
> 
>         1.  ifconfig <iface> up
>         2.  disable interrupts for FD SB queue. (via setpci or pciraw)
>         3.  dump a number of filters on the ring via ethtool -N <iface>
>         4.  shut down interface via ifconfig <iface> down
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 8 ++++----
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


