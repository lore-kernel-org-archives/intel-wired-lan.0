From: kbuild test robot <fengguang.wu@intel.com>
Date: Thu, 18 Jan 2018 07:04:31 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 89/106]
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from
 restricted __be32
Message-ID: <201801180729.hkAw6G87%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   22d7c76059d7162dfbcb96962641a345c884c694
commit: 27b8cbbccd6d0ec6573ccfe61d8ebd744c667dac [89/106] ixgbe: ipsec offload for sparc
reproduce:
        # apt-get install sparse
        git checkout 27b8cbbccd6d0ec6573ccfe61d8ebd744c667dac
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:46:17: got restricted __be32 <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:47:9: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:47:9: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:47:9: got restricted __be32 <noident>
>> drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: cast from restricted __be32
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:96:9: got restricted __le32 <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:104:17: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:104:17: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:104:17: got restricted __be32 <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:105:9: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:105:9: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:105:9: got restricted __be32 <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:124:17: sparse: cast from restricted __be32
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:124:17: sparse: incorrect type in argument 3 (different base types) @@ expected unsigned int value @@ got ed int value @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:124:17: expected unsigned int value
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:124:17: got restricted __le32 <noident>
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned int val @@ got ed int val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: expected unsigned int val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:393:9: got restricted __be32 spi
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:586:17: sparse: incorrect type in argument 1 (different base types) @@ expected unsigned long long val @@ got g long val @@
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:586:17: expected unsigned long long val
   drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:586:17: got restricted __be32 spi

vim +96 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c

    31	
    32	/**
    33	 * ixgbe_ipsec_set_tx_sa - set the Tx SA registers
    34	 * @hw: hw specific details
    35	 * @idx: register index to write
    36	 * @key: key byte array
    37	 * @salt: salt bytes
    38	 **/
    39	static void ixgbe_ipsec_set_tx_sa(struct ixgbe_hw *hw, u16 idx,
    40					  u32 key[], u32 salt)
    41	{
    42		u32 reg;
    43		int i;
    44	
    45		for (i = 0; i < 4; i++)
  > 46			IXGBE_WRITE_REG(hw, IXGBE_IPSTXKEY(i), cpu_to_be32(key[3 - i]));
    47		IXGBE_WRITE_REG(hw, IXGBE_IPSTXSALT, cpu_to_be32(salt));
    48		IXGBE_WRITE_FLUSH(hw);
    49	
    50		reg = IXGBE_READ_REG(hw, IXGBE_IPSTXIDX);
    51		reg &= IXGBE_RXTXIDX_IPS_EN;
    52		reg |= idx << IXGBE_RXTXIDX_IDX_SHIFT | IXGBE_RXTXIDX_WRITE;
    53		IXGBE_WRITE_REG(hw, IXGBE_IPSTXIDX, reg);
    54		IXGBE_WRITE_FLUSH(hw);
    55	}
    56	
    57	/**
    58	 * ixgbe_ipsec_set_rx_item - set an Rx table item
    59	 * @hw: hw specific details
    60	 * @idx: register index to write
    61	 * @tbl: table selector
    62	 *
    63	 * Trigger the device to store into a particular Rx table the
    64	 * data that has already been loaded into the input register
    65	 **/
    66	static void ixgbe_ipsec_set_rx_item(struct ixgbe_hw *hw, u16 idx,
    67					    enum ixgbe_ipsec_tbl_sel tbl)
    68	{
    69		u32 reg;
    70	
    71		reg = IXGBE_READ_REG(hw, IXGBE_IPSRXIDX);
    72		reg &= IXGBE_RXTXIDX_IPS_EN;
    73		reg |= tbl << IXGBE_RXIDX_TBL_SHIFT |
    74		       idx << IXGBE_RXTXIDX_IDX_SHIFT |
    75		       IXGBE_RXTXIDX_WRITE;
    76		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIDX, reg);
    77		IXGBE_WRITE_FLUSH(hw);
    78	}
    79	
    80	/**
    81	 * ixgbe_ipsec_set_rx_sa - set up the register bits to save SA info
    82	 * @hw: hw specific details
    83	 * @idx: register index to write
    84	 * @spi: security parameter index
    85	 * @key: key byte array
    86	 * @salt: salt bytes
    87	 * @mode: rx decrypt control bits
    88	 * @ip_idx: index into IP table for related IP address
    89	 **/
    90	static void ixgbe_ipsec_set_rx_sa(struct ixgbe_hw *hw, u16 idx, __be32 spi,
    91					  u32 key[], u32 salt, u32 mode, u32 ip_idx)
    92	{
    93		int i;
    94	
    95		/* store the SPI (in bigendian) and IPidx */
  > 96		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSPI, cpu_to_le32(spi));
    97		IXGBE_WRITE_REG(hw, IXGBE_IPSRXIPIDX, ip_idx);
    98		IXGBE_WRITE_FLUSH(hw);
    99	
   100		ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_spi_tbl);
   101	
   102		/* store the key, salt, and mode */
   103		for (i = 0; i < 4; i++)
   104			IXGBE_WRITE_REG(hw, IXGBE_IPSRXKEY(i), cpu_to_be32(key[3 - i]));
   105		IXGBE_WRITE_REG(hw, IXGBE_IPSRXSALT, cpu_to_be32(salt));
   106		IXGBE_WRITE_REG(hw, IXGBE_IPSRXMOD, mode);
   107		IXGBE_WRITE_FLUSH(hw);
   108	
   109		ixgbe_ipsec_set_rx_item(hw, idx, ips_rx_key_tbl);
   110	}
   111	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
