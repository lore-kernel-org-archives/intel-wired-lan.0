From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Thu, 2 Aug 2018 22:06:54 +0000
Subject: [Intel-wired-lan] e1000: check on netif_running() before
 calling e1000_up()
In-Reply-To: <20180723160130.8911-1-jeffrey.t.kirsher@intel.com>
References: <20180723160130.8911-1-jeffrey.t.kirsher@intel.com>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B9652FC4B@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jeff Kirsher
> Sent: Monday, July 23, 2018 9:01 AM
> To: intel-wired-lan at lists.osuosl.org
> Cc: Bo Chen <chenbo@pdx.edu>
> Subject: [Intel-wired-lan] e1000: check on netif_running() before calling
> e1000_up()
> 
> From: Bo Chen <chenbo@pdx.edu>
> 
> When the device is not up, the call to 'e1000_up()' from the error handling
> path
> of 'e1000_set_ringparam()' causes a kernel oops with a null-pointer
> dereference. The null-pointer dereference is triggered in function
> 'e1000_alloc_rx_buffers()' at line 'buffer_info = &rx_ring->buffer_info[i]'.
> 
> This bug was reported by COD, a tool for testing kernel module binaries I am
> building. This bug was also detected by KFI from Dr. Kai Cong.
> 
> This patch fixes the bug by checking on 'netif_running()' before calling
> 'e1000_up()' in 'e1000_set_ringparam()'.
> 
> Signed-off-by: Bo Chen <chenbo@pdx.edu>
> Acked-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/e1000/e1000_ethtool.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
