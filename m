From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 8 Dec 2020 15:21:01 +0300
Subject: [Intel-wired-lan] [bug report] xsk: Propagate napi_id to XDP socket
 Rx path
Message-ID: <X89vkBAEFET+IchI@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Bj?rn T?pel,

This is a semi-automatic email about new static checker warnings.

The patch b02e5a0ebb17: "xsk: Propagate napi_id to XDP socket Rx 
path" from Nov 30, 2020, leads to the following Smatch complaint:

    drivers/net/ethernet/intel/ixgbe/ixgbe_main.c:6580 ixgbe_setup_rx_resources()
    error: we previously assumed 'rx_ring->q_vector' could be null (see line 6550)

drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
  6549	
  6550		if (rx_ring->q_vector)
                    ^^^^^^^^^^^^^^^^^
Check for NULL

  6551			ring_node = rx_ring->q_vector->numa_node;
  6552	
  6553		rx_ring->rx_buffer_info = vmalloc_node(size, ring_node);
  6554		if (!rx_ring->rx_buffer_info)
  6555			rx_ring->rx_buffer_info = vmalloc(size);
  6556		if (!rx_ring->rx_buffer_info)
  6557			goto err;
  6558	
  6559		/* Round up to nearest 4K */
  6560		rx_ring->size = rx_ring->count * sizeof(union ixgbe_adv_rx_desc);
  6561		rx_ring->size = ALIGN(rx_ring->size, 4096);
  6562	
  6563		set_dev_node(dev, ring_node);
  6564		rx_ring->desc = dma_alloc_coherent(dev,
  6565						   rx_ring->size,
  6566						   &rx_ring->dma,
  6567						   GFP_KERNEL);
  6568		set_dev_node(dev, orig_node);
  6569		if (!rx_ring->desc)
  6570			rx_ring->desc = dma_alloc_coherent(dev, rx_ring->size,
  6571							   &rx_ring->dma, GFP_KERNEL);
  6572		if (!rx_ring->desc)
  6573			goto err;
  6574	
  6575		rx_ring->next_to_clean = 0;
  6576		rx_ring->next_to_use = 0;
  6577	
  6578		/* XDP RX-queue info */
  6579		if (xdp_rxq_info_reg(&rx_ring->xdp_rxq, adapter->netdev,
  6580				     rx_ring->queue_index, rx_ring->q_vector->napi.napi_id) < 0)
                                                           ^^^^^^^^^^^^^^^^^^^
New unchecked dereference.

  6581			goto err;
  6582	

regards,
dan carpenter
