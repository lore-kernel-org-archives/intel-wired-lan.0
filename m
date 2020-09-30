From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Wed, 30 Sep 2020 17:29:25 +0300
Subject: [Intel-wired-lan] [bug report] igb: add XDP support
Message-ID: <20200930142925.GA650848@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Sven Auhagen,

The patch 9cbc948b5a20: "igb: add XDP support" from Sep 2, 2020,
leads to the following static checker warning:

	drivers/net/ethernet/intel/igb/igb_main.c:8427 igb_run_xdp()
	error: (-2147483647) too low for ERR_PTR

drivers/net/ethernet/intel/igb/igb_main.c
  2897  static int igb_xdp_xmit_back(struct igb_adapter *adapter, struct xdp_buff *xdp)
  2898  {
  2899          struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
  2900          int cpu = smp_processor_id();
  2901          struct igb_ring *tx_ring;
  2902          struct netdev_queue *nq;
  2903          u32 ret;
  2904  
  2905          if (unlikely(!xdpf))
  2906                  return IGB_XDP_CONSUMED;
  2907  
  2908          /* During program transitions its possible adapter->xdp_prog is assigned
  2909           * but ring has not been configured yet. In this case simply abort xmit.
  2910           */
  2911          tx_ring = adapter->xdp_prog ? igb_xdp_tx_queue_mapping(adapter) : NULL;
  2912          if (unlikely(!tx_ring))
  2913                  return -ENXIO;
                        ^^^^^^^^^^^^^^
This is only supposed to return error codes like IGB_XDP_CONSUMED.
The return here we get converted to a positive eventually it will
trigger an Oops, because it's no long an IS_ERR() nor a NULL.

  2914  
  2915          nq = txring_txq(tx_ring);
  2916          __netif_tx_lock(nq, cpu);
  2917          ret = igb_xmit_xdp_ring(adapter, tx_ring, xdpf);
  2918          __netif_tx_unlock(nq);
  2919  
  2920          return ret;
  2921  }

regards,
dan carpenter
