Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA8A7C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 10:43:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6906140B59;
	Fri, 18 Sep 2026 10:43:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id eH9fvivu_F3E; Fri, 18 Sep 2026 10:43:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 472F940B48
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789728236;
	b=YRpqPk6p3uDFUwGh4KhHk6hpSyMtZQ/g3tEIZ/ZhbmKECxvyLMPOYnxYMkEvfrc4J7DE
	 gs9oHVfKkCb1UznqxrpPK+BBykX008qLt7WENGt0uV6xUL4mbhjPkB47zmRcCJXEWqsR+
	 JJLulHULBKJ5XLdKNsHZjPdWIaB9B6iVJ/20wXHTldbeIJNBsij1cjdzWLdHYq2G6ivub
	 742YhT6lx/+Wh2yXrKT7guLdFUA1xPs7B7FXqQdZG81/lYriq9h64YJjLTYeOVdrFqXzW
	 9oZm7xTfK1Bgq9Llj2Z0p3BUI0JjfcwBPk/FKo3cqxgZ/zTN0rbeN7AlhoCFGQFEAgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789728236;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=foQJ0jeaHV1fAkfBH2v/eTvPeWtiF89HlWxh4T3QQEc=;
	b=U7fMQS0JAuCkrG7eyyXTH397sHljl7GVn0KWlPLqmPv+4vYwrZxbGsyn6fZwCBwraQLg
	 /b8ViWEwuJuxxskhHxniEePti5mf9xMzJvzKqtPjQPVuMt1CQwTYYjpD7GzrIzwm72YRe
	 qP/G9+GwBFsv8Mm5sk621xVvfKEilT1uXUKbnx/4agt+kbtSko3HRNB5/T3M4Ki6DcB9L
	 MBJJhuFbVR6iigXUYQJc2p7wbyV/c6UJ+H+nHoHazMUlysouvQmIgTk2JMqhWHF9eviZy
	 Y4ZVAOrzQIMaBZ65Lv3sWgjFcJF1bJwiAFdLZ8MOyJxyQQwiaKUb0nJbAg2pqTSrm0A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789728236;
	bh=foQJ0jeaHV1fAkfBH2v/eTvPeWtiF89HlWxh4T3QQEc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HB9+j2JaKNb6Gl2Movp22+0tGSNXDxuFI5h9gSBfPnx2mqa6NtNFvnFd+l7+M9psS
	 c2SunKCgYLdwY6LBlnVOGHN3Vkdydf3vCh3TFZP6VwfVa2Szkk9hK0MyCW1xb4BFlV
	 gTm20wfh7O4F1CaZMcx5qdt8tuE6XqE3hwpsQvkSx5MTbZSnbMaB7VSPJswD+TseKG
	 Zo33D+NcfwlI+AZu5yRN4B7q4EiEneClA2QJrZ//xUTddSEHN1cNFZTNI0/7NqtDR4
	 L3yEhe1EcOVjZH9T/skU8KAMUj7/pI4r5UyKOPxEcLf6ySb5LUiqTkvnd50gdcbWcJ
	 8Froyh7GTl9rQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 472F940B48;
	Fri, 18 Sep 2026 10:43:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 907AF24D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 10:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 763F960D4B
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 10:43:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CXYRHBLgxmgx for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 10:43:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1AE0160BFF
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=192.198.163.8
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789728233;
 b=f/ItBI3Q0Ng8JFG34mOTcXyp/N/aYVJAXWBFhTTM9G+Ket8sbzJq2tsD2sMXgMuuatln
 8bJhtmy/8QYqZ1lAaCiYX8xGqSnKqI6+dXM0smb4YGfQoNaWLsFhcwH1PsWtlxTKwklyY
 s8IPYHcIXzPJsgbqt+jSjo+9oeWVKEUCd9oauex+DkQGZs5OSyCgIxie+bkbvUMtKbJPL
 ZmisFx0hnwPaARYKK1p16sow8/BSepTcme9Z6gCeRgwWlCrW7we0sQlMMQul4W2nRfUwA
 Iy1z3/tU72G+iej6lt1XAs7a9MPBdke+TJ77bL6PJR0soBeHFufWg6rfaNr6yKiaTGw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789728233;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=foQJ0jeaHV1fAkfBH2v/eTvPeWtiF89HlWxh4T3QQEc=;
 b=F8ntTlD7YkX8eKUhHqcbt8TAR33vSD5sArjYjoYUgdYooe/JLSWoFvLaIB8rgH1mUp61
 p68hFwrIqlaBe7SiXjlZuazpPipRHCXvYpURV79vlpgAJYmjhx/NkGS/gJF7+Zj0nNH5m
 cRf697FeJkJyCCsSgDPCLfsOIoHOiT8zW0ByOTkJ4nRZ/vO9aY00x0WG8nH9qxH1dc1kk
 QUG6RzPOPDQO3OF08iqnn1Au8PYjVfHNnH47wqc57DLiCoRf1b1GbRjT5wk2cqWGU+2x4
 ft75wy4Q6D1WUSbhNLj8fTBr6oD2HUcuPq/PC7iBNLGhyFaVc/AZGL6i2YabQIbcS9g==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MbKbthlC; 
 arc=none smtp.remote-ip=192.198.163.8
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.8;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=MbKbthlC
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1AE0160BFF
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 10:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789728233; x=1821264233;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=H90OXW+xJ8y/ZyagLrAORG+a2SeSyOt74HFyBBNlOig=;
 b=MbKbthlCVBZ+79bMBrH5jHSe+Btdu0ywhzZkFLUaw0N16dOL8YRogp5w
 2pdCfaqug73eK+dZJIiVHGyOYCcVDNlLNGDgXWlvNRUwl0yp5kWqgeTG7
 5G+Th4GjzsJRMU0+6hg/oP+Kt6ajThf0HvlTRrJVmjHAD7g4O1ZjIZztg
 t5ASve8mxkHUvhAnbupdHDNFt5KqHZlCFHlUS0IsAra3h3l+/nP1ch6Jl
 /DhmGADeZG4X2mfwuTw8aMUj7qtFthl4YO/A1R9psIM6ytOYE9r28hUb3
 7A9uHw3ZPuH2YoEY7s2mAsIJ/n0et69ZrUTvWYZLucCGkN+MOV0hsBwn8 A==;
X-CSE-ConnectionGUID: 5mpidfWoTymJ9EOyRTFRcg==
X-CSE-MsgGUID: wWmPcvJ2RLuYLVtC/+8ZKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107728493"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107728493"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 03:43:52 -0700
X-CSE-ConnectionGUID: JjzWsOnCTZmgebUGheKsxQ==
X-CSE-MsgGUID: 52R3AJ4MQKmn38JKMk591A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="271657035"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa008.fm.intel.com with ESMTP; 18 Sep 2026 03:43:50 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7W4G-000000009cb-3mDT;
 Fri, 18 Sep 2026 10:43:44 +0000
Date: Fri, 18 Sep 2026 18:43:18 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev
Subject: Re: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <202609181819.j6XGVZPa-lkp@intel.com>
References: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917094312.1567881-3-aleksandr.loktionov@intel.com>
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Unsubscribe: <https://lists.osuosl.org/mailman/options/intel-wired-lan>, 
 <mailto:intel-wired-lan-request@osuosl.org?subject=unsubscribe>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
Errors-To: intel-wired-lan-bounces@osuosl.org

Hi Aleksandr,

kernel test robot noticed the following build errors:

[auto build test ERROR on tnguy-next-queue/dev-queue]
[also build test ERROR on tnguy-net-queue/dev-queue linus/master v7.3-rc3 next-20260916]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aleksandr-Loktionov/From-Aleksandr-Loktionov-aleksandr-loktionov-intel-com/20260917-114312
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue.git dev-queue
patch link:    https://lore.kernel.org/r/20260917094312.1567881-3-aleksandr.loktionov%40intel.com
patch subject: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
config: loongarch-defconfig (https://download.01.org/0day-ci/archive/20260918/202609181819.j6XGVZPa-lkp@intel.com/config)
compiler: clang version 24.0.0git (https://github.com/llvm/llvm-project 7252edd9aa82ef1c570ff6694ef7f4763a8a5d2f)
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609181819.j6XGVZPa-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609181819.j6XGVZPa-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/net/ethernet/intel/ice/ice_fw_update.c:255:37: error: use of undeclared identifier 'ICE_F_EROT'
     255 |                 if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
         |                                                   ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_fw_update.c:680:42: error: use of undeclared identifier 'ICE_F_EROT'
     680 |         if (!ice_is_feature_supported(priv->pf, ICE_F_EROT))
         |                                                 ^~~~~~~~~~
   2 errors generated.


vim +/ICE_F_EROT +255 drivers/net/ethernet/intel/ice/ice_fw_update.c

   213	
   214	/**
   215	 * ice_send_component_table - Send PLDM component table to firmware
   216	 * @context: PLDM fw update structure
   217	 * @component: the component to process
   218	 * @transfer_flag: relative transfer order of this component
   219	 *
   220	 * Read relevant data from the component and forward it to the device
   221	 * firmware. Check the response to determine if the firmware indicates that
   222	 * the update can proceed.
   223	 *
   224	 * This function sends AdminQ commands related to the NVM, and assumes that
   225	 * the NVM resource has been acquired.
   226	 *
   227	 * Returns: zero on success, or a negative error code on failure.
   228	 */
   229	static int
   230	ice_send_component_table(struct pldmfw *context, struct pldmfw_component *component,
   231				 u8 transfer_flag)
   232	{
   233		struct ice_fwu_priv *priv = container_of(context, struct ice_fwu_priv, context);
   234		struct netlink_ext_ack *extack = priv->extack;
   235		struct ice_aqc_nvm_comp_tbl *comp_tbl;
   236		u8 comp_response, comp_response_code;
   237		struct device *dev = context->dev;
   238		struct ice_pf *pf = priv->pf;
   239		struct ice_hw *hw = &pf->hw;
   240		size_t length;
   241		u8 comp_bit;
   242		int status;
   243	
   244		switch (component->identifier) {
   245		case NVM_COMP_ID_OROM:
   246			comp_bit = ICE_FWU_COMP_OROM;
   247			break;
   248		case NVM_COMP_ID_NVM:
   249			comp_bit = ICE_FWU_COMP_NVM;
   250			break;
   251		case NVM_COMP_ID_NETLIST:
   252			comp_bit = ICE_FWU_COMP_NETLIST;
   253			break;
   254		case NVM_COMP_ID_MANIFEST:
 > 255			if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
   256				dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
   257					component->identifier);
   258				NL_SET_ERR_MSG_MOD(extack,
   259						   "Unable to update due to unknown firmware component");
   260				return -EOPNOTSUPP;
   261			}
   262			comp_bit = ICE_FWU_COMP_MANIFEST;
   263			break;
   264		default:
   265			dev_err(dev, "Unable to update due to a firmware component with unknown ID %u\n",
   266				component->identifier);
   267			NL_SET_ERR_MSG_MOD(extack, "Unable to update due to unknown firmware component");
   268			return -EOPNOTSUPP;
   269		}
   270	
   271		if (priv->seen_components & comp_bit) {
   272			dev_err(dev, "Duplicate component in PLDM image: component ID 0x%02x\n",
   273				component->identifier);
   274			NL_SET_ERR_MSG_MOD(extack, "Duplicate component in PLDM image");
   275			return -EOPNOTSUPP;
   276		}
   277		priv->seen_components |= comp_bit;
   278	
   279		length = struct_size(comp_tbl, cvs, component->version_len);
   280		comp_tbl = kzalloc(length, GFP_KERNEL);
   281		if (!comp_tbl)
   282			return -ENOMEM;
   283	
   284		comp_tbl->comp_class = cpu_to_le16(component->classification);
   285		comp_tbl->comp_id = cpu_to_le16(component->identifier);
   286		comp_tbl->comp_class_idx = FWU_COMP_CLASS_IDX_NOT_USE;
   287		comp_tbl->comp_cmp_stamp = cpu_to_le32(component->comparison_stamp);
   288		comp_tbl->cvs_type = component->version_type;
   289		comp_tbl->cvs_len = component->version_len;
   290		memcpy(comp_tbl->cvs, component->version_string, component->version_len);
   291	
   292		dev_dbg(dev, "Sending component table to firmware:\n");
   293	
   294		status = ice_nvm_pass_component_tbl(hw, (u8 *)comp_tbl, length,
   295						    transfer_flag, &comp_response,
   296						    &comp_response_code, NULL);
   297	
   298		kfree(comp_tbl);
   299	
   300		if (status) {
   301			dev_err(dev, "Failed to transfer component table to firmware, err %d aq_err %s\n",
   302				status, libie_aq_str(hw->adminq.sq_last_status));
   303			NL_SET_ERR_MSG_MOD(extack, "Failed to transfer component table to firmware");
   304			return -EIO;
   305		}
   306	
   307		return ice_check_component_response(pf, component->identifier, comp_response,
   308						    comp_response_code, extack);
   309	}
   310	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
