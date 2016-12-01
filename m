From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Thu, 1 Dec 2016 23:09:02 +0000
Subject: [Intel-wired-lan] [next PATCH S55 11/14] i40e/i40evf: Moves
	skb	from i40e_rx_buffer to i40e_ring
In-Reply-To: <1480377971-23412-12-git-send-email-bimmy.pujari@intel.com>
References: <1480377971-23412-1-git-send-email-bimmy.pujari@intel.com>
 <1480377971-23412-12-git-send-email-bimmy.pujari@intel.com>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A0FA390A3@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Bimmy Pujari
> Sent: Monday, November 28, 2016 4:06 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [next PATCH S55 11/14] i40e/i40evf: Moves skb
> from i40e_rx_buffer to i40e_ring
> 
> From: "Scott Peterson" <scott.d.peterson@intel.com>
> 
> This patch reduces the size of struct i40e_rx_buffer by one pointer, and
> makes the i40e driver a little more consistent with the igb driver in terms of
> packets that span buffers.
> 
> We do this by moving the skb field from struct i40e_rx_buffer to struct
> i40e_ring. We pass the skb we already have (or NULL if we
> don't) to i40e_fetch_rx_buffer(), which skips the skb allocation if we already
> have one for this packet.
> 
> Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
> Change-ID: I4ad48a531844494ba0c5d8e1a62209a057f661b0
> ---
> Testing Hints:
> Generate traffic with jumbo frames (e.g. netperf), and observe
> "non_eop_segs" stat increases on receiver.  That confirms the path changed
> here was taken.
> 
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c   | 31 +++++++++++++------------
> --
>  drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  9 +++++++-
>  drivers/net/ethernet/intel/i40evf/i40e_txrx.c | 30 +++++++++++++----------
> ---  drivers/net/ethernet/intel/i40evf/i40e_txrx.h |  9 +++++++-
>  4 files changed, 46 insertions(+), 33 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


