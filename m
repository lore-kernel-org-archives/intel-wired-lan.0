From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Mon, 24 Jun 2019 15:19:02 +0300
Subject: [Intel-wired-lan] [bug report] iavf: allow null RX descriptors
In-Reply-To: <20190620074516.GA12233@mwanda>
References: <20190620074516.GA12233@mwanda>
Message-ID: <20190624121902.GR18776@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Jun 20, 2019 at 10:45:16AM +0300, Dan Carpenter wrote:
> Hello Mitch Williams,
> 
> This is a semi-automatic email about new static checker warnings.
> 
> The patch efa14c398582: "iavf: allow null RX descriptors" from May
> 14, 2019, leads to the following Smatch complaint:
> 
>     drivers/net/ethernet/intel/iavf/iavf_txrx.c:1533 iavf_clean_rx_irq()
>     warn: variable dereferenced before check 'rx_buffer' (see line 1526)
> 
> drivers/net/ethernet/intel/iavf/iavf_txrx.c
>   1515  
>   1516                  size = (qword & IAVF_RXD_QW1_LENGTH_PBUF_MASK) >>
>   1517                         IAVF_RXD_QW1_LENGTH_PBUF_SHIFT;
>   1518  
>   1519                  iavf_trace(clean_rx_irq, rx_ring, rx_desc, skb);
>   1520                  rx_buffer = iavf_get_rx_buffer(rx_ring, size);
>   1521  
>   1522                  /* retrieve a buffer from the ring */
>   1523                  if (skb)
> 
> skb is non-NULL so ignore this path.
> 
>   1524                          iavf_add_rx_frag(rx_ring, rx_buffer, skb, size);
>   1525			else if (ring_uses_build_skb(rx_ring))
>   1526				skb = iavf_build_skb(rx_ring, rx_buffer, size);
>                                                               ^^^^^^^^^
>   1527			else
>   1528				skb = iavf_construct_skb(rx_ring, rx_buffer, size);
>                                                                   ^^^^^^^^^
> These functions both dereference "rx_buffer" and might set skb to NULL.

Oh...  Huh.  They aren't *supposed* to dereference rx_buffer, but the
NULL checks are too late.

regards,
dan carpenter

