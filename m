From: Jesper Dangaard Brouer <brouer@redhat.com>
Date: Fri, 23 Apr 2021 13:04:27 +0200
Subject: [Intel-wired-lan] [PATCH intel-net] i40e: fix broken XDP support
In-Reply-To: <20210423095955.15207-1-magnus.karlsson@gmail.com>
References: <20210423095955.15207-1-magnus.karlsson@gmail.com>
Message-ID: <20210423130427.1bbe4df2@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 23 Apr 2021 11:59:55 +0200
Magnus Karlsson <magnus.karlsson@gmail.com> wrote:

> From: Magnus Karlsson <magnus.karlsson@intel.com>
> 
> Commit 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c") broke
> XDP support in the i40e driver. That commit was fixing a sparse error
> in the code by introducing a new variable xdp_res instead of
> overloading this into the skb pointer. The problem is that the code
> later uses the skb pointer in if statements and these where not
> extended to also test for the new xdp_res variable. Fix this by adding
> the correct tests for xdp_res in these places.
> 
> Fixes: 12738ac4754e ("i40e: Fix sparse errors in i40e_txrx.c")
> Reported-by: Jesper Dangaard Brouer <brouer@redhat.com>
> Signed-off-by: Magnus Karlsson <magnus.karlsson@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_txrx.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Acked-by: Jesper Dangaard Brouer <brouer@redhat.com>

Tested-by: Jesper Dangaard Brouer <brouer@redhat.com>

I also tested that i40e works on my system again.
 Intel(R) Xeon(R) CPU E5-1650 v4 @ 3.60GHz

Running XDP on dev:i40e2 (ifindex:8) action:XDP_DROP options:no_touch
XDP stats       CPU     pps         issue-pps  
XDP-RX CPU      4       33,670,895  0          
XDP-RX CPU      total   33,670,895 

RXQ stats       RXQ:CPU pps         issue-pps  
rx_queue_index    4:4   33,670,900  0          
rx_queue_index    4:sum 33,670,900 


Running XDP on dev:i40e2 (ifindex:8) action:XDP_DROP options:read
XDP stats       CPU     pps         issue-pps  
XDP-RX CPU      4       31,424,994  0          
XDP-RX CPU      total   31,424,994 

RXQ stats       RXQ:CPU pps         issue-pps  
rx_queue_index    4:4   31,424,997  0          
rx_queue_index    4:sum 31,424,997 


Running XDP on dev:i40e2 (ifindex:8) action:XDP_TX options:swapmac
XDP stats       CPU     pps         issue-pps  
XDP-RX CPU      4       14,777,900  0          
XDP-RX CPU      total   14,777,900 

RXQ stats       RXQ:CPU pps         issue-pps  
rx_queue_index    4:4   14,777,893  0          
rx_queue_index    4:sum 14,777,893 


$ sudo ./xdp_redirect_map i40e2 i40e2
input: 8 output: 8
libbpf: elf: skipping unrecognized data section(24) .eh_frame
libbpf: elf: skipping relo section(25) .rel.eh_frame for section(24) .eh_frame
libbpf: Kernel error message: XDP program already attached
WARN: link set xdp fd failed on 8
ifindex 8:    8212980 pkt/s
ifindex 8:   11725145 pkt/s
ifindex 8:   11727939 pkt/s
ifindex 8:   11727640 pkt/s
ifindex 8:   11729593 pkt/s

-- 
Best regards,
  Jesper Dangaard Brouer
  MSc.CS, Principal Kernel Engineer at Red Hat
  LinkedIn: http://www.linkedin.com/in/brouer

