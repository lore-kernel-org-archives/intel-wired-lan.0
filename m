From: kbuild test robot <fengguang.wu@intel.com>
Date: Tue, 19 Dec 2017 04:59:24 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 67/80]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:44:17: sparse: incorrect
 type in argument 3 (different base types)
Message-ID: <201712190407.gmgPG1WL%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   6d3426ed7dd90f482ef40f7a6abd2b0e18f37c63
commit: 7efd4bc2735643536e0b5b31e6d0fd59b0c43eea [67/80] ixgbe: add ipsec register access routines
reproduce:
        # apt-get install sparse
        git checkout 7efd4bc2735643536e0b5b31e6d0fd59b0c43eea
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


Please review and possibly fold the followup patch.

vim +44 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c

    29	
    30	/**
    31	 * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
    32	 * @hw: hw specific details
    33	 * @idx: register index to write
    34	 * @key: key byte array
    35	 * @salt: salt bytes
    36	 **/
    37	static void ixgbe_ipsec_set_tx_sa(struct ixgbe_hw *hw, u16 idx,
    38					  u32 key[], u32 salt)
    39	{
    40		u32 reg;
    41		int i;
    42	
    43		for (i = 0; i < 4; i++)
  > 44			IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(i), cpu_to_be32(key[3-i]));
    45		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, cpu_to_be32(salt));
    46		IXGBE_WRITE_FLUSH(hw);
    47	
    48		reg = IXGBE_READ_REG(hw, IXGBE_IPSTXIDX);
    49		reg &= IXGBE_RXTXIDX_IPS_EN;
    50		reg |= idx << IXGBE_RXTXIDX_IDX_SHIFT | IXGBE_RXTXIDX_WRITE;
    51		IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, reg);
    52		IXGBE_WRITE_FLUSH(hw);
    53	}
    54	
    55	/**
    56	 * ixgbe_ipsec_set_rx_item - set an Rx table item
    57	 * @hw: hw specific details
    58	 * @idx: register index to write
    59	 * @tbl: table selector
    60	 *
    61	 * Trigger the device to store into a particular Rx table the
    62	 * data that has already been loaded into the input register
    63	 **/
    64	static void ixgbe_ipsec_set_rx_item(struct ixgbe_hw *hw, u16 idx,
    65					    enum ixgbe_ipsec_tbl_sel tbl)
    66	{
    67		u32 reg;
    68	
    69		reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
    70		reg &= IXGBE_RXTXIDX_IPS_EN;
    71		reg |= tbl << IXGBE_RXIDX_TBL_SHIFT |
    72		       idx << IXGBE_RXTXIDX_IDX_SHIFT |
    73		       IXGBE_RXTXIDX_WRITE;
    74		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
    75		IXGBE_WRITE_FLUSH(hw);
    76	}
    77	
    78	/**
    79	 * ixgbe_ipsec_set_rx_sa - set up the register bits to save SA info
    80	 * @hw: hw specific details
    81	 * @idx: register index to write
    82	 * @spi: security parameter index
    83	 * @key: key byte array
    84	 * @salt: salt bytes
    85	 * @mode: rx decrypt control bits
    86	 * @ip_idx: index into IP table for related IP address
    87	 **/
    88	static void ixgbe_ipsec_set_rx_sa(struct ixgbe_hw *hw, u16 idx, __be32 spi,
    89					  u32 key[], u32 salt, u32 mode, u32 ip_idx)
    90	{
    91		int i;
    92	
    93		/* store the SPI (in bigendian) and IPidx */
    94		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, spi);
    95		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
    96		IXGBE_WRITE_FLUSH(hw);
    97	
    98		ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_spi_tbl);
    99	
   100		/* store the key, salt, and mode */
   101		for (i = 0; i < 4; i++)
 > 102			IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(i), cpu_to_be32(key[3-i]));
   103		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, cpu_to_be32(salt));
   104		IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, mode);
   105		IXGBE_WRITE_FLUSH(hw);
   106	
   107		ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_key_tbl);
   108	}
   109	
   110	/**
   111	 * ixgbe_ipsec_set_rx_ip - set up the register bits to save SA IP addr info
   112	 * @hw: hw specific details
   113	 * @idx: register index to write
   114	 * @addr: IP address byte array
   115	 **/
   116	static void ixgbe_ipsec_set_rx_ip(struct ixgbe_hw *hw, u16 idx, __be32 addr[])
   117	{
   118		int i;
   119	
   120		/* store the ip address */
   121		for (i = 0; i < 4; i++)
   122			IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPADDR(i), addr[i]);
   123		IXGBE_WRITE_FLUSH(hw);
   124	
   125		ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_ip_tbl);
   126	}
   127	
   128	/**
   129	 * ixgbe_ipsec_clear_hw_tables - because some tables don't get cleared on reset
   130	 * @adapter: board private structure
   131	 **/
 > 132	void ixgbe_ipsec_clear_hw_tables(struct ixgbe_adapter *adapter)
   133	{
   134		struct ixgbe_hw *hw = &adapter->hw;
   135		u32 buf[4] = {0, 0, 0, 0};
   136		u16 idx;
   137	
   138		/* disable Rx and Tx SA lookup */
   139		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, 0);
   140		IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, 0);
   141	
   142		/* scrub the tables - split the loops for the max of the IP table */
   143		for (idx = 0; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++) {
   144			ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
   145			ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
   146			ixgbe_ipsec_set_rx_ip(hw, idx, (__be32 *)buf);
   147		}
   148		for (; idx < IXGBE_IPSEC_MAX_RX_IP_COUNT; idx++) {
   149			ixgbe_ipsec_set_tx_sa(hw, idx, buf, 0);
   150			ixgbe_ipsec_set_rx_sa(hw, idx, 0, buf, 0, 0, 0);
   151		}
   152	}
   153	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
