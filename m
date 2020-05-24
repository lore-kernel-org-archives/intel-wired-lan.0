From: kbuild test robot <lkp@intel.com>
Date: Sun, 24 May 2020 15:35:37 +0800
Subject: [Intel-wired-lan] [jkirsher-next-queue:dev-queue 9/99]
 drivers/net/ethernet/intel/ice/ice_common.c:1770:7: warning: this statement
 may fall through
Message-ID: <202005241529.6IwOFdiv%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git dev-queue
head:   5950d1e508b225372208a78339e6434adf129852
commit: 71c1f807aa1ff02f44b51234fb57c1b6f0eea872 [9/99] ice: Create and register virtual bus for RDMA
config: i386-allyesconfig (attached as .config)
compiler: gcc-7 (Ubuntu 7.5.0-6ubuntu2) 7.5.0
reproduce (this is a W=1 build):
        git checkout 71c1f807aa1ff02f44b51234fb57c1b6f0eea872
        # save the attached .config to linux build tree
        make ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/net/ethernet/intel/ice/ice_common.c: In function 'ice_parse_caps':
>> drivers/net/ethernet/intel/ice/ice_common.c:1770:7: warning: this statement may fall through [-Wimplicit-fallthrough=]
if (func_p) {
^
drivers/net/ethernet/intel/ice/ice_common.c:1788:3: note: here
case ICE_AQC_CAPS_IWARP:
^~~~

vim +1770 drivers/net/ethernet/intel/ice/ice_common.c

995c90f2de819b Anirudh Venkataramanan 2018-10-26  1613  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1614  /**
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1615   * ice_parse_caps - parse function/device capabilities
f9867df6d96593 Anirudh Venkataramanan 2019-02-19  1616   * @hw: pointer to the HW struct
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1617   * @buf: pointer to a buffer containing function/device capability records
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1618   * @cap_count: number of capability records in the list
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1619   * @opc: type of capabilities list to parse
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1620   *
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1621   * Helper function to parse function(0x000a)/device(0x000b) capabilities list.
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1622   */
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1623  static void
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1624  ice_parse_caps(struct ice_hw *hw, void *buf, u32 cap_count,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1625  	       enum ice_adminq_opc opc)
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1626  {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1627  	struct ice_aqc_list_caps_elem *cap_resp;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1628  	struct ice_hw_func_caps *func_p = NULL;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1629  	struct ice_hw_dev_caps *dev_p = NULL;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1630  	struct ice_hw_common_caps *caps;
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1631  	char const *prefix;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1632  	u32 i;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1633  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1634  	if (!buf)
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1635  		return;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1636  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1637  	cap_resp = (struct ice_aqc_list_caps_elem *)buf;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1638  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1639  	if (opc == ice_aqc_opc_list_dev_caps) {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1640  		dev_p = &hw->dev_caps;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1641  		caps = &dev_p->common_cap;
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1642  		prefix = "dev cap";
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1643  	} else if (opc == ice_aqc_opc_list_func_caps) {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1644  		func_p = &hw->func_caps;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1645  		caps = &func_p->common_cap;
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1646  		prefix = "func cap";
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1647  	} else {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1648  		ice_debug(hw, ICE_DBG_INIT, "wrong opcode\n");
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1649  		return;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1650  	}
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1651  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1652  	for (i = 0; caps && i < cap_count; i++, cap_resp++) {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1653  		u32 logical_id = le32_to_cpu(cap_resp->logical_id);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1654  		u32 phys_id = le32_to_cpu(cap_resp->phys_id);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1655  		u32 number = le32_to_cpu(cap_resp->number);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1656  		u16 cap = le16_to_cpu(cap_resp->cap);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1657  
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1658  		switch (cap) {
995c90f2de819b Anirudh Venkataramanan 2018-10-26  1659  		case ICE_AQC_CAPS_VALID_FUNCTIONS:
995c90f2de819b Anirudh Venkataramanan 2018-10-26  1660  			caps->valid_functions = number;
995c90f2de819b Anirudh Venkataramanan 2018-10-26  1661  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1662  				  "%s: valid_functions (bitmap) = %d\n", prefix,
995c90f2de819b Anirudh Venkataramanan 2018-10-26  1663  				  caps->valid_functions);
eae1bbb2a4519a Bruce Allan            2019-11-08  1664  
eae1bbb2a4519a Bruce Allan            2019-11-08  1665  			/* store func count for resource management purposes */
eae1bbb2a4519a Bruce Allan            2019-11-08  1666  			if (dev_p)
eae1bbb2a4519a Bruce Allan            2019-11-08  1667  				dev_p->num_funcs = hweight32(number);
995c90f2de819b Anirudh Venkataramanan 2018-10-26  1668  			break;
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1669  		case ICE_AQC_CAPS_SRIOV:
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1670  			caps->sr_iov_1_1 = (number == 1);
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1671  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1672  				  "%s: sr_iov_1_1 = %d\n", prefix,
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1673  				  caps->sr_iov_1_1);
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1674  			break;
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1675  		case ICE_AQC_CAPS_VF:
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1676  			if (dev_p) {
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1677  				dev_p->num_vfs_exposed = number;
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1678  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1679  					  "%s: num_vfs_exposed = %d\n", prefix,
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1680  					  dev_p->num_vfs_exposed);
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1681  			} else if (func_p) {
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1682  				func_p->num_allocd_vfs = number;
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1683  				func_p->vf_base_id = logical_id;
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1684  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1685  					  "%s: num_allocd_vfs = %d\n", prefix,
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1686  					  func_p->num_allocd_vfs);
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1687  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1688  					  "%s: vf_base_id = %d\n", prefix,
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1689  					  func_p->vf_base_id);
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1690  			}
75d2b253026b8b Anirudh Venkataramanan 2018-09-19  1691  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1692  		case ICE_AQC_CAPS_VSI:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1693  			if (dev_p) {
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1694  				dev_p->num_vsi_allocd_to_host = number;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1695  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1696  					  "%s: num_vsi_allocd_to_host = %d\n",
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1697  					  prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1698  					  dev_p->num_vsi_allocd_to_host);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1699  			} else if (func_p) {
7a1f7111754020 Brett Creeley          2019-02-08  1700  				func_p->guar_num_vsi =
7a1f7111754020 Brett Creeley          2019-02-08  1701  					ice_get_num_per_func(hw, ICE_MAX_VSI);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1702  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1703  					  "%s: guar_num_vsi (fw) = %d\n",
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1704  					  prefix, number);
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1705  				ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1706  					  "%s: guar_num_vsi = %d\n",
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1707  					  prefix, func_p->guar_num_vsi);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1708  			}
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1709  			break;
a257f188b72bf0 Usha Ketineni          2019-08-08  1710  		case ICE_AQC_CAPS_DCB:
a257f188b72bf0 Usha Ketineni          2019-08-08  1711  			caps->dcb = (number == 1);
a257f188b72bf0 Usha Ketineni          2019-08-08  1712  			caps->active_tc_bitmap = logical_id;
a257f188b72bf0 Usha Ketineni          2019-08-08  1713  			caps->maxtc = phys_id;
a257f188b72bf0 Usha Ketineni          2019-08-08  1714  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1715  				  "%s: dcb = %d\n", prefix, caps->dcb);
a257f188b72bf0 Usha Ketineni          2019-08-08  1716  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1717  				  "%s: active_tc_bitmap = %d\n", prefix,
a257f188b72bf0 Usha Ketineni          2019-08-08  1718  				  caps->active_tc_bitmap);
a257f188b72bf0 Usha Ketineni          2019-08-08  1719  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1720  				  "%s: maxtc = %d\n", prefix, caps->maxtc);
a257f188b72bf0 Usha Ketineni          2019-08-08  1721  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1722  		case ICE_AQC_CAPS_RSS:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1723  			caps->rss_table_size = number;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1724  			caps->rss_table_entry_width = logical_id;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1725  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1726  				  "%s: rss_table_size = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1727  				  caps->rss_table_size);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1728  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1729  				  "%s: rss_table_entry_width = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1730  				  caps->rss_table_entry_width);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1731  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1732  		case ICE_AQC_CAPS_RXQS:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1733  			caps->num_rxq = number;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1734  			caps->rxq_first_id = phys_id;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1735  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1736  				  "%s: num_rxq = %d\n", prefix,
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1737  				  caps->num_rxq);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1738  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1739  				  "%s: rxq_first_id = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1740  				  caps->rxq_first_id);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1741  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1742  		case ICE_AQC_CAPS_TXQS:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1743  			caps->num_txq = number;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1744  			caps->txq_first_id = phys_id;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1745  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1746  				  "%s: num_txq = %d\n", prefix,
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1747  				  caps->num_txq);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1748  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1749  				  "%s: txq_first_id = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1750  				  caps->txq_first_id);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1751  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1752  		case ICE_AQC_CAPS_MSIX:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1753  			caps->num_msix_vectors = number;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1754  			caps->msix_vector_first_id = phys_id;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1755  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1756  				  "%s: num_msix_vectors = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1757  				  caps->num_msix_vectors);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1758  			ice_debug(hw, ICE_DBG_INIT,
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1759  				  "%s: msix_vector_first_id = %d\n", prefix,
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1760  				  caps->msix_vector_first_id);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1761  			break;
148beb61203125 Henry Tieman           2020-05-11  1762  		case ICE_AQC_CAPS_FD:
148beb61203125 Henry Tieman           2020-05-11  1763  			if (dev_p) {
148beb61203125 Henry Tieman           2020-05-11  1764  				dev_p->num_flow_director_fltr = number;
148beb61203125 Henry Tieman           2020-05-11  1765  				ice_debug(hw, ICE_DBG_INIT,
148beb61203125 Henry Tieman           2020-05-11  1766  					  "%s: num_flow_director_fltr = %d\n",
148beb61203125 Henry Tieman           2020-05-11  1767  					  prefix,
148beb61203125 Henry Tieman           2020-05-11  1768  					  dev_p->num_flow_director_fltr);
148beb61203125 Henry Tieman           2020-05-11  1769  			}
148beb61203125 Henry Tieman           2020-05-11 @1770  			if (func_p) {
148beb61203125 Henry Tieman           2020-05-11  1771  				u32 reg_val, val;
148beb61203125 Henry Tieman           2020-05-11  1772  
148beb61203125 Henry Tieman           2020-05-11  1773  				reg_val = rd32(hw, GLQF_FD_SIZE);
148beb61203125 Henry Tieman           2020-05-11  1774  				val = (reg_val & GLQF_FD_SIZE_FD_GSIZE_M) >>
148beb61203125 Henry Tieman           2020-05-11  1775  				      GLQF_FD_SIZE_FD_GSIZE_S;
148beb61203125 Henry Tieman           2020-05-11  1776  				func_p->fd_fltr_guar =
148beb61203125 Henry Tieman           2020-05-11  1777  				      ice_get_num_per_func(hw, val);
148beb61203125 Henry Tieman           2020-05-11  1778  				val = (reg_val & GLQF_FD_SIZE_FD_BSIZE_M) >>
148beb61203125 Henry Tieman           2020-05-11  1779  				      GLQF_FD_SIZE_FD_BSIZE_S;
148beb61203125 Henry Tieman           2020-05-11  1780  				func_p->fd_fltr_best_effort = val;
148beb61203125 Henry Tieman           2020-05-11  1781  				ice_debug(hw, ICE_DBG_INIT,
148beb61203125 Henry Tieman           2020-05-11  1782  					  "%s: fd_fltr_guar = %d\n",
148beb61203125 Henry Tieman           2020-05-11  1783  					  prefix, func_p->fd_fltr_guar);
148beb61203125 Henry Tieman           2020-05-11  1784  				ice_debug(hw, ICE_DBG_INIT,
148beb61203125 Henry Tieman           2020-05-11  1785  					  "%s: fd_fltr_best_effort = %d\n",
148beb61203125 Henry Tieman           2020-05-11  1786  					  prefix, func_p->fd_fltr_best_effort);
148beb61203125 Henry Tieman           2020-05-11  1787  			}
71c1f807aa1ff0 Dave Ertman            2020-05-04  1788  		case ICE_AQC_CAPS_IWARP:
71c1f807aa1ff0 Dave Ertman            2020-05-04  1789  			caps->iwarp = (number == 1);
71c1f807aa1ff0 Dave Ertman            2020-05-04  1790  			ice_debug(hw, ICE_DBG_INIT,
71c1f807aa1ff0 Dave Ertman            2020-05-04  1791  				  "%s: iwarp = %d\n", prefix, caps->iwarp);
148beb61203125 Henry Tieman           2020-05-11  1792  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1793  		case ICE_AQC_CAPS_MAX_MTU:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1794  			caps->max_mtu = number;
5c875c1af8dc69 Anirudh Venkataramanan 2019-09-03  1795  			ice_debug(hw, ICE_DBG_INIT, "%s: max_mtu = %d\n",
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1796  				  prefix, caps->max_mtu);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1797  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1798  		default:
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1799  			ice_debug(hw, ICE_DBG_INIT,
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1800  				  "%s: unknown capability[%d]: 0x%x\n", prefix,
a84db52569ddef Anirudh Venkataramanan 2019-04-16  1801  				  i, cap);
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1802  			break;
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1803  		}
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1804  	}
9164f761c99493 Bruce Allan            2019-11-08  1805  
9164f761c99493 Bruce Allan            2019-11-08  1806  	/* Re-calculate capabilities that are dependent on the number of
9164f761c99493 Bruce Allan            2019-11-08  1807  	 * physical ports; i.e. some features are not supported or function
9164f761c99493 Bruce Allan            2019-11-08  1808  	 * differently on devices with more than 4 ports.
9164f761c99493 Bruce Allan            2019-11-08  1809  	 */
9164f761c99493 Bruce Allan            2019-11-08  1810  	if (hw->dev_caps.num_funcs > 4) {
9164f761c99493 Bruce Allan            2019-11-08  1811  		/* Max 4 TCs per port */
9164f761c99493 Bruce Allan            2019-11-08  1812  		caps->maxtc = 4;
9164f761c99493 Bruce Allan            2019-11-08  1813  		ice_debug(hw, ICE_DBG_INIT,
9164f761c99493 Bruce Allan            2019-11-08  1814  			  "%s: maxtc = %d (based on #ports)\n", prefix,
9164f761c99493 Bruce Allan            2019-11-08  1815  			  caps->maxtc);
71c1f807aa1ff0 Dave Ertman            2020-05-04  1816  		if (caps->iwarp) {
71c1f807aa1ff0 Dave Ertman            2020-05-04  1817  			ice_debug(hw, ICE_DBG_INIT, "%s: forcing RDMA off\n",
71c1f807aa1ff0 Dave Ertman            2020-05-04  1818  				  prefix);
71c1f807aa1ff0 Dave Ertman            2020-05-04  1819  			caps->iwarp = 0;
71c1f807aa1ff0 Dave Ertman            2020-05-04  1820  		}
71c1f807aa1ff0 Dave Ertman            2020-05-04  1821  
71c1f807aa1ff0 Dave Ertman            2020-05-04  1822  		/* print message only when processing device capabilities */
71c1f807aa1ff0 Dave Ertman            2020-05-04  1823  		if (dev_p)
71c1f807aa1ff0 Dave Ertman            2020-05-04  1824  			dev_info(ice_hw_to_dev(hw),
71c1f807aa1ff0 Dave Ertman            2020-05-04  1825  				 "RDMA functionality is not available with the current device configuration.\n");
9164f761c99493 Bruce Allan            2019-11-08  1826  	}
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1827  }
9c20346b6309e2 Anirudh Venkataramanan 2018-03-20  1828  

:::::: The code at line 1770 was first introduced by commit
:::::: 148beb612031255156d68b342170140524afb36e ice: Initialize Flow Director resources

:::::: TO: Henry Tieman <henry.w.tieman@intel.com>
:::::: CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 72570 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200524/605f70ad/attachment-0001.bin>
