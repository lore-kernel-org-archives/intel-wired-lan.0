From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Fri, 4 Feb 2022 17:04:58 +0000
Subject: [Intel-wired-lan] [PATCH net] igc: Clear old XDP info when
 changing ring settings
In-Reply-To: <20220204080217.70054-1-kurt@linutronix.de>
References: <20220204080217.70054-1-kurt@linutronix.de>
Message-ID: <0f1e1c0fc4f555ef0eaaa983da6d8f012a0acf60.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Kurt,

On Fri, 2022-02-04 at 09:02 +0100, Kurt Kanzenbach wrote:
> When changing ring sizes the driver triggers kernel warnings in XDP
> code.
> 
> For instance, running 'ethtool -G $interface tx 1024 rx 1024' yields:
> 
> > [? 754.838136] Missing unregister, handled but fix driver
> > [? 754.838143] WARNING: CPU: 4 PID: 704 at net/core/xdp.c:170
> > xdp_rxq_info_reg+0x7d/0xe0
> 
> The newly allocated ring is copied by memcpy() and still contains the
> old XDP
> information. Therefore, it has to be cleared before allocating new
> resources
> by igc_setup_rx_resources().
> 
> Igb does it the same way. Keep the code in sync.

Thanks for the patch, but we have a patch[1] to resolve this issue in a
more preferred method. igb is actually changing as well to this new
solution [2].

Thanks,
Tony

[1] https://patchwork.ozlabs.org/patch/1581816/
[2] https://patchwork.ozlabs.org/patch/1581815/

> Fixes: 4609ffb9f615 ("igc: Refactor XDP rxq info registration")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>

