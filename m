From: John Fastabend <john.fastabend@gmail.com>
Date: Thu, 4 Jan 2018 20:13:38 -0800
Subject: [Intel-wired-lan] [bpf-next V4 PATCH 04/14] ixgbe: setup
 xdp_rxq_info
In-Reply-To: <151497512896.18176.14287471693450621693.stgit@firesoul>
References: <151497504273.18176.10177133999720101758.stgit@firesoul>
 <151497512896.18176.14287471693450621693.stgit@firesoul>
Message-ID: <2094c087-13f4-bf03-0407-fc19322669c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 01/03/2018 02:25 AM, Jesper Dangaard Brouer wrote:
> Driver hook points for xdp_rxq_info:
>  * reg  : ixgbe_setup_rx_resources()
>  * unreg: ixgbe_free_rx_resources()
> 
> Tested on actual hardware.
> 
> V2: Fix ixgbe_set_ringparam, clear xdp_rxq_info in temp_ring
> 
> Cc: intel-wired-lan at lists.osuosl.org
> Cc: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> Cc: Alexander Duyck <alexander.duyck@gmail.com>
> Signed-off-by: Jesper Dangaard Brouer <brouer@redhat.com>
> ---

Looked a bit for reset paths that might be missed but didn't
find any. LGTM.

Acked-by: John Fastabend <john.fastabend@gmail.com>
