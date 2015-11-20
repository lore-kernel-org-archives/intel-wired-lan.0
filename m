From: Brown, Aaron F <aaron.f.brown@intel.com>
Date: Fri, 20 Nov 2015 04:50:12 +0000
Subject: [Intel-wired-lan] [next PATCH 5/5] igb: Fix unused variable
 warning
In-Reply-To: <20151027235937.30048.88092.stgit@localhost.localdomain>
References: <20151027235341.30048.46286.stgit@localhost.localdomain>
 <20151027235937.30048.88092.stgit@localhost.localdomain>
Message-ID: <309B89C4C689E141A5FF6A0C5FB2118B81D3DADB@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Alexander Duyck
> Sent: Tuesday, October 27, 2015 5:00 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH 5/5] igb: Fix unused variable warning
> 
> I ran into an unused variable warning when building dev-queue.  It turns
> out that hw isn't used anymore when setting up the q_vectors since we
> switch from hw->hw_addr to adapter->io_addr in igb_request_irq.  As such
> the variable can be dropped.
> 
> Fixes: 0b3659ca297fc ("igb: improve handling of disconnected adapters")
> Signed-off-by: Alexander Duyck <aduyck@mirantis.com>
> ---
>  drivers/net/ethernet/intel/igb/igb_main.c |    1 -
>  1 file changed, 1 deletion(-)
> 

Tested-by: Aaron Brown <aaron.f.brown@intel.com>
