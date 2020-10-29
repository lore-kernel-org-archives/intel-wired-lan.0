From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Date: Thu, 29 Oct 2020 15:07:44 +0100
Subject: [Intel-wired-lan] [PATCH v2 05/10] igc: Refactor rx timestamp
 handling
In-Reply-To: <20201028201943.93147-6-andre.guedes@intel.com>
References: <20201028201943.93147-1-andre.guedes@intel.com>
 <20201028201943.93147-6-andre.guedes@intel.com>
Message-ID: <20201029140744.GB890@ranger.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, Oct 28, 2020 at 01:19:38PM -0700, Andre Guedes wrote:
> This patch refactors the rx timestamp handling in preparation to land
> XDP support.
> 
> RX timestamps are put in the rx buffer by hardware, before the packet
> data. When creating the xdp buffer, we will need to check the rx
> descriptor to determine if the buffer contains timestamp information
> and consider the offset when setting xdp.data.

Out of curiosity, is the timestamping somehow configurable on this device
or does it always take place? Could it be toggled?

> 
> The rx descriptor check is already done in igc_construct_skb(). To
> avoid code duplication, this patch moves the timestamp handling to
> igc_clean_rx_irq() so both skb and xdp paths can reuse it.
> 
> Signed-off-by: Andre Guedes <andre.guedes@intel.com>
