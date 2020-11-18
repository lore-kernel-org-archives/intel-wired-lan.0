From: kernel test robot <lkp@intel.com>
Date: Wed, 18 Nov 2020 21:43:18 +0800
Subject: [Intel-wired-lan] [tnguy-next-queue:dev-queue 29/94]
 drivers/net/ethernet/intel/ice/ice_flow.c:1703:1: warning: the frame size
 of 4104 bytes is larger than 1024 bytes
Message-ID: <202011182114.61frFJh9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
head:   de0223bde011b2f6da54bfb8e087ac6718a32c8a
commit: 8452a38dcac801e875b13334d886dcf404fb4d33 [29/94] ice: create ACL entry
config: csky-randconfig-p002-20201117 (attached as .config)
compiler: csky-linux-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git/commit/?id=8452a38dcac801e875b13334d886dcf404fb4d33
        git remote add tnguy-next-queue https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git
        git fetch --no-tags tnguy-next-queue dev-queue
        git checkout 8452a38dcac801e875b13334d886dcf404fb4d33
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=csky 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_flow.c: In function 'ice_flow_acl_frmt_entry':
>> drivers/net/ethernet/intel/ice/ice_flow.c:1703:1: warning: the frame size of 4104 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    1703 | }
         | ^

vim +1703 drivers/net/ethernet/intel/ice/ice_flow.c

  1544	
  1545	/**
  1546	 * ice_flow_acl_frmt_entry - Format ACL entry
  1547	 * @hw: pointer to the hardware structure
  1548	 * @prof: pointer to flow profile
  1549	 * @e: pointer to the flow entry
  1550	 * @data: pointer to a data buffer containing flow entry's match values/masks
  1551	 * @acts: array of actions to be performed on a match
  1552	 * @acts_cnt: number of actions
  1553	 *
  1554	 * Formats the key (and key_inverse) to be matched from the data passed in,
  1555	 * along with data from the flow profile. This key/key_inverse pair makes up
  1556	 * the 'entry' for an ACL flow entry.
  1557	 */
  1558	static enum ice_status
  1559	ice_flow_acl_frmt_entry(struct ice_hw *hw, struct ice_flow_prof *prof,
  1560				struct ice_flow_entry *e, u8 *data,
  1561				struct ice_flow_action *acts, u8 acts_cnt)
  1562	{
  1563		u8 *buf = NULL, *dontcare = NULL, *key = NULL, range = 0, dir_flag_msk;
  1564		struct ice_aqc_acl_profile_ranges *range_buf = NULL;
  1565		enum ice_status status;
  1566		bool cnt_alloc;
  1567		u8 prof_id = 0;
  1568		u16 i, buf_sz;
  1569	
  1570		status = ice_flow_get_hw_prof(hw, ICE_BLK_ACL, prof->id, &prof_id);
  1571		if (status)
  1572			return status;
  1573	
  1574		/* Format the result action */
  1575	
  1576		status = ice_flow_acl_check_actions(hw, acts, acts_cnt, &cnt_alloc);
  1577		if (status)
  1578			return status;
  1579	
  1580		status = ICE_ERR_NO_MEMORY;
  1581	
  1582		e->acts = devm_kmemdup(ice_hw_to_dev(hw), acts,
  1583				       acts_cnt * sizeof(*acts), GFP_KERNEL);
  1584		if (!e->acts)
  1585			goto out;
  1586	
  1587		e->acts_cnt = acts_cnt;
  1588	
  1589		/* Format the matching data */
  1590		buf_sz = prof->cfg.scen->width;
  1591		buf = kzalloc(buf_sz, GFP_KERNEL);
  1592		if (!buf)
  1593			goto out;
  1594	
  1595		dontcare = kzalloc(buf_sz, GFP_KERNEL);
  1596		if (!dontcare)
  1597			goto out;
  1598	
  1599		/* 'key' buffer will store both key and key_inverse, so must be twice
  1600		 * size of buf
  1601		 */
  1602		key = devm_kzalloc(ice_hw_to_dev(hw), buf_sz * 2, GFP_KERNEL);
  1603		if (!key)
  1604			goto out;
  1605	
  1606		range_buf = devm_kzalloc(ice_hw_to_dev(hw),
  1607					 sizeof(struct ice_aqc_acl_profile_ranges),
  1608					 GFP_KERNEL);
  1609		if (!range_buf)
  1610			goto out;
  1611	
  1612		/* Set don't care mask to all 1's to start, will zero out used bytes */
  1613		memset(dontcare, 0xff, buf_sz);
  1614	
  1615		for (i = 0; i < prof->segs_cnt; i++) {
  1616			struct ice_flow_seg_info *seg = &prof->segs[i];
  1617			u8 j;
  1618	
  1619			for_each_set_bit(j, (unsigned long *)&seg->match,
  1620					 ICE_FLOW_FIELD_IDX_MAX) {
  1621				struct ice_flow_fld_info *info = &seg->fields[j];
  1622	
  1623				if (info->type == ICE_FLOW_FLD_TYPE_RANGE)
  1624					ice_flow_acl_frmt_entry_range(j, info,
  1625								      range_buf, data,
  1626								      &range);
  1627				else
  1628					ice_flow_acl_frmt_entry_fld(j, info, buf,
  1629								    dontcare, data);
  1630			}
  1631	
  1632			for (j = 0; j < seg->raws_cnt; j++) {
  1633				struct ice_flow_fld_info *info = &seg->raws[j].info;
  1634				u16 dst, src, mask, k;
  1635				bool use_mask = false;
  1636	
  1637				src = info->src.val;
  1638				dst = info->entry.val -
  1639						ICE_AQC_ACL_PROF_BYTE_SEL_START_IDX;
  1640				mask = info->src.mask;
  1641	
  1642				if (mask != ICE_FLOW_FLD_OFF_INVAL)
  1643					use_mask = true;
  1644	
  1645				for (k = 0; k < info->entry.last; k++, dst++) {
  1646					buf[dst] = data[src++];
  1647					if (use_mask)
  1648						dontcare[dst] = ~data[mask++];
  1649					else
  1650						dontcare[dst] = 0;
  1651				}
  1652			}
  1653		}
  1654	
  1655		buf[prof->cfg.scen->pid_idx] = (u8)prof_id;
  1656		dontcare[prof->cfg.scen->pid_idx] = 0;
  1657	
  1658		/* Format the buffer for direction flags */
  1659		dir_flag_msk = BIT(ICE_FLG_PKT_DIR);
  1660	
  1661		if (prof->dir == ICE_FLOW_RX)
  1662			buf[prof->cfg.scen->pkt_dir_idx] = dir_flag_msk;
  1663	
  1664		if (range) {
  1665			buf[prof->cfg.scen->rng_chk_idx] = range;
  1666			/* Mark any unused range checkers as don't care */
  1667			dontcare[prof->cfg.scen->rng_chk_idx] = ~range;
  1668			e->range_buf = range_buf;
  1669		} else {
  1670			devm_kfree(ice_hw_to_dev(hw), range_buf);
  1671		}
  1672	
  1673		status = ice_set_key(key, buf_sz * 2, buf, NULL, dontcare, NULL, 0,
  1674				     buf_sz);
  1675		if (status)
  1676			goto out;
  1677	
  1678		e->entry = key;
  1679		e->entry_sz = buf_sz * 2;
  1680	
  1681	out:
  1682		kfree(buf);
  1683		kfree(dontcare);
  1684	
  1685		if (status && key)
  1686			devm_kfree(ice_hw_to_dev(hw), key);
  1687	
  1688		if (status && range_buf) {
  1689			devm_kfree(ice_hw_to_dev(hw), range_buf);
  1690			e->range_buf = NULL;
  1691		}
  1692	
  1693		if (status && e->acts) {
  1694			devm_kfree(ice_hw_to_dev(hw), e->acts);
  1695			e->acts = NULL;
  1696			e->acts_cnt = 0;
  1697		}
  1698	
  1699		if (status && cnt_alloc)
  1700			ice_flow_acl_free_act_cntr(hw, acts, acts_cnt);
  1701	
  1702		return status;
> 1703	}
  1704	/**
  1705	 * ice_flow_add_entry - Add a flow entry
  1706	 * @hw: pointer to the HW struct
  1707	 * @blk: classification stage
  1708	 * @prof_id: ID of the profile to add a new flow entry to
  1709	 * @entry_id: unique ID to identify this flow entry
  1710	 * @vsi_handle: software VSI handle for the flow entry
  1711	 * @prio: priority of the flow entry
  1712	 * @data: pointer to a data buffer containing flow entry's match values/masks
  1713	 * @acts: arrays of actions to be performed on a match
  1714	 * @acts_cnt: number of actions
  1715	 * @entry_h: pointer to buffer that receives the new flow entry's handle
  1716	 */
  1717	enum ice_status
  1718	ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
  1719			   u64 entry_id, u16 vsi_handle, enum ice_flow_priority prio,
  1720			   void *data, struct ice_flow_action *acts, u8 acts_cnt,
  1721			   u64 *entry_h)
  1722	{
  1723		struct ice_flow_entry *e = NULL;
  1724		struct ice_flow_prof *prof;
  1725		enum ice_status status;
  1726	
  1727		/* ACL entries must indicate an action */
  1728		if (blk == ICE_BLK_ACL && (!acts || !acts_cnt))
  1729			return ICE_ERR_PARAM;
  1730	
  1731		/* No flow entry data is expected for RSS */
  1732		if (!entry_h || (!data && blk != ICE_BLK_RSS))
  1733			return ICE_ERR_BAD_PTR;
  1734	
  1735		if (!ice_is_vsi_valid(hw, vsi_handle))
  1736			return ICE_ERR_PARAM;
  1737	
  1738		mutex_lock(&hw->fl_profs_locks[blk]);
  1739	
  1740		prof = ice_flow_find_prof_id(hw, blk, prof_id);
  1741		if (!prof) {
  1742			status = ICE_ERR_DOES_NOT_EXIST;
  1743		} else {
  1744			/* Allocate memory for the entry being added and associate
  1745			 * the VSI to the found flow profile
  1746			 */
  1747			e = devm_kzalloc(ice_hw_to_dev(hw), sizeof(*e), GFP_KERNEL);
  1748			if (!e)
  1749				status = ICE_ERR_NO_MEMORY;
  1750			else
  1751				status = ice_flow_assoc_prof(hw, blk, prof, vsi_handle);
  1752		}
  1753	
  1754		mutex_unlock(&hw->fl_profs_locks[blk]);
  1755		if (status)
  1756			goto out;
  1757	
  1758		e->id = entry_id;
  1759		e->vsi_handle = vsi_handle;
  1760		e->prof = prof;
  1761		e->priority = prio;
  1762	
  1763		switch (blk) {
  1764		case ICE_BLK_FD:
  1765		case ICE_BLK_RSS:
  1766			break;
  1767		case ICE_BLK_ACL:
  1768			/* ACL will handle the entry management */
  1769			status = ice_flow_acl_frmt_entry(hw, prof, e, (u8 *)data, acts,
  1770							 acts_cnt);
  1771			if (status)
  1772				goto out;
  1773			break;
  1774		default:
  1775			status = ICE_ERR_NOT_IMPL;
  1776			goto out;
  1777		}
  1778	
  1779		if (blk != ICE_BLK_ACL) {
  1780			/* ACL will handle the entry management */
  1781			mutex_lock(&prof->entries_lock);
  1782			list_add(&e->l_entry, &prof->entries);
  1783			mutex_unlock(&prof->entries_lock);
  1784		}
  1785	
  1786		*entry_h = ICE_FLOW_ENTRY_HNDL(e);
  1787	
  1788	out:
  1789		if (status && e) {
  1790			if (e->entry)
  1791				devm_kfree(ice_hw_to_dev(hw), e->entry);
  1792			devm_kfree(ice_hw_to_dev(hw), e);
  1793		}
  1794	
  1795		return status;
  1796	}
  1797	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all at lists.01.org
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 33155 bytes
Desc: not available
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20201118/1885283d/attachment-0001.bin>
