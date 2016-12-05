From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Mon, 5 Dec 2016 18:33:11 +0000
Subject: [Intel-wired-lan] [next PATCH S56 4/8] i40e: don't warn every
 time	we clear an Rx timestamp register
In-Reply-To: <1480710782-9195-5-git-send-email-bimmy.pujari@intel.com>
References: <1480710782-9195-1-git-send-email-bimmy.pujari@intel.com>
 <1480710782-9195-5-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA3939A@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Friday, December 02, 2016 12:33 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S56 4/8] i40e: don't warn every time
> we clear an Rx timestamp register
> 
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The intent of this message was to indicate to a user that we might have
> missed a timestamp event for a valid packet. The original method of
> detecting the missed events relied on waiting until all 4 registers were filled.
> 
> A recent commit d55458c0cd7a5 ("i40e: replace PTP Rx timestamp hang
> logic") replaced this logic with much better detection scheme that could
> detect a stalled Rx timestamp register even when other registers were still
> functional.
> 
> The new logic means that a message will be displayed almost as soon as a
> timestamp for a dropped frame occurs. This new logic highlights that the
> hardware will attempt timestamp for frames which it later decides to drop.
> The most prominent example is when a multicast PTP frame is received on a
> multicast address that we are not subscribed to.
> 
> Because the hardware initiates the Rx timestamp as soon as possible, it will
> latch an RXTIME register, but then drop the packet.
> 
> This results in users being confused by the message as they are not
> expecting to see dropped timestamp messages unless their application also
> indicates that timestamps were missing.
> 
> Resolve this by reducing the severity and frequency of the displayed
> message. We now only print the message if 3 or 4 of the RXTIME registers are
> stalled and get cleared within the same watchdog event. This ensures that
> the common case does not constantly display the message.
> Additionally, since the message is likely not as meaningful to most users,
> reduce the message to a dev_dbg instead of a dev_warn.
> 
> Users can still get a count of the number of timestamps dropped by reading
> the ethtool statistics value, if necessary.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Change-ID: I35494442226a444c418dfb4f91a3070d06c8435c
> ---
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c | 21 ++++++++++++++++-----
>  1 file changed, 16 insertions(+), 5 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


