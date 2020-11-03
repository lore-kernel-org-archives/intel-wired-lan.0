From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 3 Nov 2020 17:32:01 +0300
Subject: [Intel-wired-lan] [bug report] igb: Add support for ETF offload
Message-ID: <20201103143201.GA1477350@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Jesus Sanchez-Palencia,

The patch 3048cf84d152: "igb: Add support for ETF offload" from Jul
3, 2018, leads to the following static checker warning:

	drivers/net/ethernet/intel/igb/igb_main.c:1862 igb_save_txtime_params()
	warn: array off by one? 'adapter->tx_ring[queue]'

drivers/net/ethernet/intel/igb/igb_main.c
  1854  static int igb_save_txtime_params(struct igb_adapter *adapter, int queue,
  1855                                    bool enable)
  1856  {
  1857          struct igb_ring *ring;
  1858  
  1859          if (queue < 0 || queue > adapter->num_tx_queues)
                                       ^^
I feel like this should be >= instead.

  1860                  return -EINVAL;
  1861  
  1862          ring = adapter->tx_ring[queue];
  1863          ring->launchtime_enable = enable;
  1864  
  1865          return 0;
  1866  }
  1867  
  1868  static int igb_save_cbs_params(struct igb_adapter *adapter, int queue,
  1869                                 bool enable, int idleslope, int sendslope,
  1870                                 int hicredit, int locredit)
  1871  {
  1872          struct igb_ring *ring;
  1873  
  1874          if (queue < 0 || queue > adapter->num_tx_queues)
                                 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Here too.

  1875                  return -EINVAL;
  1876  
  1877          ring = adapter->tx_ring[queue];
  1878  
  1879          ring->cbs_enable = enable;
  1880          ring->idleslope = idleslope;
  1881          ring->sendslope = sendslope;
  1882          ring->hicredit = hicredit;
  1883          ring->locredit = locredit;
  1884  
  1885          return 0;
  1886  }

regards,
dan carpenter
