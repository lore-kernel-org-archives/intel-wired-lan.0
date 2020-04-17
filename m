From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Fri, 17 Apr 2020 11:40:27 -0700
Subject: [Intel-wired-lan] [PATCH] e1000e: Fixed issue with LSC pending.
In-Reply-To: <20200417110627.3589435-1-andrew@daynix.com>
References: <20200417110627.3589435-1-andrew@daynix.com>
Message-ID: <20200417114027.0000363b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 17 Apr 2020 14:06:27 +0300
<andrew@daynix.com> wrote:

> From: Andrew Melnychenko <andrew@daynix.com>
> 
> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1707441
> The issue was detected with QEMU and doesn't reproduce on Windows guest.
> CTRL_EXT.IAME is disabled by
> rev 0a8047ac68e50e4ccbadcfc6b6b070805b976885:
> "to avoid disruption from potential programs that access the registers
> directly."
> So let's leave it like that and add interrupt pending clearance
> using write to ICR. It fixes the issue when removed cable can't be detected
> by the driver.

Thanks for your patch! I think you may want to add a correctly
formatted Fixes: tag.

Please beware, this interrupt code is very tricky and difficult to get
right, we had a "small" change in e1000 that took months to iron out
and get working correctly, and in the meantime broke a bunch of stuff.

So, explaining root cause in your commit message, and a comment below
to help future code editors understand the code/functionality better
would be a good idea, IMO. Also, the QEMU behavior often doesn't do a
very good job of matching real hardware (esp with side effect
registers like ICR), so sometimes it is better to just fix QEMU, did
you consider that in this case?


> 
> Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
> index 177c6da80c57..064bb4a47131 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -1898,6 +1898,9 @@ static irqreturn_t e1000_msix_other(int __always_unused irq, void *data)
>  	struct e1000_hw *hw = &adapter->hw;
>  	u32 icr = er32(ICR);
>  

I'd really like to see a comment in the code here explaining what is
going on. f.e.

	/* if auto-mask is not enabled we need to explicitly
	 * clear the interrupt asserted bit in ICR to allow
	 * more interrupts
	 */
> +	if (!(er32(CTRL_EXT) & E1000_CTRL_EXT_IAME))
> +		ew32(ICR, icr & ~E1000_ICR_INT_ASSERTED);
> +
>  	if (icr & adapter->eiac_mask)
>  		ew32(ICS, (icr & adapter->eiac_mask));



