From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Tue, 16 Feb 2021 22:42:43 +0300
Subject: [Intel-wired-lan] [bug report] i40e: Add hardware configuration for
 software based DCB
Message-ID: <YCwgM5yvXRAZix/Q@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hello Arkadiusz Kubalewski,

The patch 90bc8e003be2: "i40e: Add hardware configuration for
software based DCB" from Oct 19, 2020, leads to the following static
checker warning:

	drivers/net/ethernet/intel/i40e/i40e_dcb.c:1645 i40e_dcb_hw_calculate_pool_sizes()
	error: uninitialized symbol 'mfs_max'.

drivers/net/ethernet/intel/i40e/i40e_dcb.c
  1628  void i40e_dcb_hw_calculate_pool_sizes(struct i40e_hw *hw,
  1629                                        u8 num_ports, bool eee_enabled,
  1630                                        u8 pfc_en, u32 *mfs_tc,
  1631                                        struct i40e_rx_pb_config *pb_cfg)
  1632  {
  1633          u32 pool_size[I40E_MAX_TRAFFIC_CLASS];
  1634          u32 high_wm[I40E_MAX_TRAFFIC_CLASS];
  1635          u32 low_wm[I40E_MAX_TRAFFIC_CLASS];
  1636          u32 total_pool_size = 0;
  1637          int shared_pool_size; /* Need signed variable */
  1638          u32 port_pb_size;
  1639          u32 mfs_max;
  1640          u32 pcirtt;
  1641          u8 i;
  1642  
  1643          /* Get the MFS(max) for the port */
  1644          for (i = 0; i < I40E_MAX_TRAFFIC_CLASS; i++) {
  1645                  if (mfs_tc[i] > mfs_max)
                                        ^^^^^^^
Uninitialized.

  1646                          mfs_max = mfs_tc[i];
  1647          }
  1648  

regards,
dan carpenter
