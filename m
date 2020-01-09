From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 9 Jan 2020 00:50:16 +0000
Subject: [Intel-wired-lan] [PATCH] e1000e: fix missing cpu_to_le64 on
 buffer_addr
In-Reply-To: <20191218095308.2397408-1-ben.dooks@codethink.co.uk>
References: <20191218095308.2397408-1-ben.dooks@codethink.co.uk>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B971A921A@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: netdev-owner at vger.kernel.org <netdev-owner@vger.kernel.org>
> On Behalf Of Ben Dooks (Codethink)
> Sent: Wednesday, December 18, 2019 1:53 AM
> To: ben.dooks at codethink.co.uk
> Cc: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; David S. Miller
> <davem@davemloft.net>; intel-wired-lan at lists.osuosl.org;
> netdev at vger.kernel.org
> Subject: [PATCH] e1000e: fix missing cpu_to_le64 on buffer_addr
> 
> The following warning suggests there is a missing cpu_to_le64() in
> the e1000_flush_tx_ring() function (it is also the behaviour
> elsewhere in the driver to do cpu_to_le64() on the buffer_addr
> when setting it)
> 
> drivers/net/ethernet/intel/e1000e/netdev.c:3813:30: warning: incorrect
> type in assignment (different base types)
> drivers/net/ethernet/intel/e1000e/netdev.c:3813:30:    expected restricted
> __le64 [usertype] buffer_addr
> drivers/net/ethernet/intel/e1000e/netdev.c:3813:30:    got unsigned long
> long [usertype] dma
> 
> Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
> ---
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: netdev at vger.kernel.org
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
