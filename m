From: Andre Guedes <andre.guedes@intel.com>
Date: Tue, 03 Nov 2020 09:43:32 -0800
Subject: [Intel-wired-lan] [bug report] igb: Add support for ETF offload
In-Reply-To: <20201103143201.GA1477350@mwanda>
References: <20201103143201.GA1477350@mwanda>
Message-ID: <160442541270.8198.8850590707916178617@wrjurinj-mobl.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Dan,

Quoting Dan Carpenter (2020-11-03 06:32:01)
> Hello Jesus Sanchez-Palencia,
> 
> The patch 3048cf84d152: "igb: Add support for ETF offload" from Jul
> 3, 2018, leads to the following static checker warning:
> 
>         drivers/net/ethernet/intel/igb/igb_main.c:1862 igb_save_txtime_params()
>         warn: array off by one? 'adapter->tx_ring[queue]'
> 
> drivers/net/ethernet/intel/igb/igb_main.c
>   1854  static int igb_save_txtime_params(struct igb_adapter *adapter, int queue,
>   1855                                    bool enable)
>   1856  {
>   1857          struct igb_ring *ring;
>   1858  
>   1859          if (queue < 0 || queue > adapter->num_tx_queues)
>                                        ^^
> I feel like this should be >= instead.

If queue == adapter->num_tx_queues we end up with an out-of-bounds index when
accessing adapter->tx_ring[] in line 1862.
> 
>   1860                  return -EINVAL;
>   1861  
>   1862          ring = adapter->tx_ring[queue];
                                  ^^^^^^^^^^^^^^


>   1863          ring->launchtime_enable = enable;
>   1864  
>   1865          return 0;
>   1866  }
>   1867  
>   1868  static int igb_save_cbs_params(struct igb_adapter *adapter, int queue,
>   1869                                 bool enable, int idleslope, int sendslope,
>   1870                                 int hicredit, int locredit)
>   1871  {
>   1872          struct igb_ring *ring;
>   1873  
>   1874          if (queue < 0 || queue > adapter->num_tx_queues)
>                                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> Here too.

Same here as well.

So it looks correct to me.

Best,
Andre
