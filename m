From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Fri, 2 Feb 2018 22:32:29 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent ptp_rx_hang from
 running when in FILTER_ALL mode
In-Reply-To: <20180129235748.21304-1-jacob.e.keller@intel.com>
References: <20180129235748.21304-1-jacob.e.keller@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1A9494EC@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Jacob Keller
> Sent: Monday, January 29, 2018 3:58 PM
> To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
> Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent ptp_rx_hang from running
> when in FILTER_ALL mode
> 
> On hardware which supports timestamping all packets, the timestamps are
> recorded in the packet buffer, and the driver no longer uses or reads the
> registers. This makes the logic for checking and clearing Rx timestmap hangs
> meaningless.
> 
> If we run the ixgbe_ptp_rx_hang() function in this case, then the driver will
> continuously spam the log output with "Clearing Rx timestamp hang".
> These messages are spurious, and confusing to end users.
> 
> The original code in commit a9763f3cb54c ("ixgbe: Update PTP to support
> X550EM_x devices", 2015-12-03) did have a flag
> PTP_RX_TIMESTAMP_IN_REGISTER which was intended to be used to avoid
> the Rx timestamp hang check, however it did not actually check the flag
> before calling the function.
> 
> Do so now in order to stop the checks and prevent the spurious log
> messages.
> 
> Fixes: a9763f3cb54c ("ixgbe: Update PTP to support X550EM_x devices",
> 2015-12-03)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
> Apparently this fix was not squashed into Mark's upstreaming effort for the
> PTP updates for X550. Here it is now.
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


