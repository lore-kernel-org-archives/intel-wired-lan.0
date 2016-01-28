From: Chris Friesen <chris.friesen@windriver.com>
Date: Thu, 28 Jan 2016 12:53:29 -0600
Subject: [Intel-wired-lan] anyone aware of problem with 82599ES stuck
 sending TX pause frames?
In-Reply-To: <56AA60A1.7060408@windriver.com>
References: <56AA60A1.7060408@windriver.com>
Message-ID: <56AA63A9.7050005@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/28/2016 12:40 PM, Chris Friesen wrote:
> Hi,
>
> We're running linux 3.10 with the 3.13.10-k ixgbe driver.  We're seeing an
> intermittent issue with our 82599ES devices where they seem to occasionally get
> stuck sending TX pause frames.
>
> controller-1:~$ sudo ethtool -S eth26 | grep flow_control
>       tx_flow_control_xon: 0
>       rx_flow_control_xon: 0
>       tx_flow_control_xoff: 3446364
>       rx_flow_control_xoff: 0


For what it's worth, on this same device the dropped/missed counts are 
relatively low:

      rx_errors: 0
      rx_dropped: 0
      rx_no_buffer_count: 0
      rx_missed_errors: 160553
      tx_flow_control_xon: 0
      rx_flow_control_xon: 0
      tx_flow_control_xoff: 3446364
      rx_flow_control_xoff: 0
      rx_csum_offload_errors: 0
      alloc_rx_page_failed: 0
      alloc_rx_buff_failed: 0
      rx_no_dma_resources: 0

Chris
