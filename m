From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 16 Nov 2021 14:36:27 +0300
Subject: [Intel-wired-lan] [bug report] ice: split ice_ring onto Tx/Rx
 separate structs
Message-ID: <20211116113627.GA11394@kili>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Maciej Fijalkowski,

This is a semi-automatic email about new static checker warnings.

The patch e72bba21355d: "ice: split ice_ring onto Tx/Rx separate
structs" from Aug 19, 2021, leads to the following Smatch complaint:

    drivers/net/ethernet/intel/ice/ice_main.c:5933 ice_update_vsi_tx_ring_stats()
    error: we previously assumed 'ring' could be null (see line 5929)

drivers/net/ethernet/intel/ice/ice_main.c
  5928			ring = READ_ONCE(rings[i]);
  5929			if (ring)
                            ^^^^
The patch adds a new check for NULL but presumably it can be removed

  5930				ice_fetch_u64_stats_per_ring(&ring->syncp, ring->stats, &pkts, &bytes);
  5931			vsi_stats->tx_packets += pkts;
  5932			vsi_stats->tx_bytes += bytes;
  5933			vsi->tx_restart += ring->tx_stats.restart_q;
                                           ^^^^^^^^^^^^^^^^^^^^^^^^
  5934			vsi->tx_busy += ring->tx_stats.tx_busy;
                                        ^^^^^^^^^^^^^^^^^^^^^^
  5935			vsi->tx_linearize += ring->tx_stats.tx_linearize;
                                             ^^^^^^^^^^^^^^^^^^^^^^^^^^^

Because the previous code didn' check

regards,
dan carpenter
