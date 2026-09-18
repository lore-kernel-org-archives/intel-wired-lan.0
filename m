Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5883C982DA
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 12:37:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9D7F640598;
	Fri, 18 Sep 2026 12:37:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x9luDKClHJ1m; Fri, 18 Sep 2026 12:37:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8ED3740ABD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789735057;
	b=ebIC4ZV92w1cUeZ4XdnanQ2OUfVM/+ZGsqrdrl5Y9sZUIfCCy1Fn1iJsCJOHVbj68Fs9
	 1kR145otavaUAECk8KdDwgDEuv/UrH83tXTj3K1Jq3nWLY3fmYf9oL1zka0UYqw1QPB8f
	 ZwnT/TENC17mquuuuO22mEWK44caMVw9hVPJrmG8nOILqiEIRiIC5ShDG3rmXfgWPEy8C
	 UD81DspydGchzhmgSgXKEQpz28QzAMhwlLs2ShFlfXF2drbEgfpLWJdRdrlBuXQrdtOa1
	 C24w5GrdmnpWL1aP0gorTeoqpagh8ZpCT/HTbd3OOGKAYKKzfBlnfpMK4DE8FNvuZ9w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789735057;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=8GwJE91MWJmmHHd7Bi7CPIkMnAwuiSJDHWItFzOxgYU=;
	b=skUXsNsQssO5hHtz1+/+m6DPPMI4qe7YQN/AZxVBzM0kbiJ4zah8KIJmwT/EUuYUU3MU
	 9BPkcSVVQNdOQb6KAaTYkdIQ69O+xYnIVqQ6BGbq5A2X0DXNX8GoYKmehzbuwVV7pPXTC
	 FysQcjKXEtNuu0sWiVQpMCJbwSw9deUoNJg/UXKc+y9LMCivXGcdtaFgdOntg7JWJ0ymX
	 SUQApxFcg9QB+WI2UYyIDuvjfP1Jevaz11ZCL+gaSGW9qNAiz1LplEePPr1lWkVEyeWXp
	 45tMt/W14UdFGeiw2M0kqfbj0sL9pUka7Z3pafnkkJgcGubp2ln/uxe5255JeAovl+A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789735057;
	bh=8GwJE91MWJmmHHd7Bi7CPIkMnAwuiSJDHWItFzOxgYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=KlOXDLmRCnvOrrGx61G7oRMpCJNzp89hANKtceKiNBpUHPbFqU+Ww1xPKWY9j6iny
	 ZEWeW7SXkcptIr8HuOshV5N2FtHdCct9hpjpS6KY0eOF/IiksaBYPCnDoyxODxoHxc
	 Fy+yoQP8zvOX9UBGexc6/VPYrY2IoM7/f38T+Ie7bDVYTQj5DpJzZU1ehREp32fKba
	 cFfi2SZQZMQoap/8ditj0jnYg0CItryYamUH0ZIMMZXdxtZHIjU+edqJKrw0lbywlC
	 XiKKQpzshP3o9MJOxHrabozKMBxRmJL5vX+DsEmH3cclWkbuNEWPFb4Gv/BIpTZ6W/
	 JX4P7Gc1tTYsQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8ED3740ABD;
	Fri, 18 Sep 2026 12:37:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 50BE6224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 12:37:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F80540524
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 12:37:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HOw4byswh-Cb for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 12:37:35 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org F329B404E6
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789735055;
 b=hJgOxmAw/sk0IspD1FQrdq/cwgTHNzp2zybunf1HVviVzEQuRHEZfkkBdSaJlh6cIW9A
 +AA28NHANU5JNli1g6U5fTqAhGJKZ/rFQe8Bbx1M20ZjpHwCPN+RThkOoPZk9nWl1pWEn
 JgoyYvcy7JV+NRJ8gzCFtzifzdnwrBtAhZSoWcuXsgwOV+39T02sTdb89wiP32xbfXvoC
 jTTRLilOjZmwgFl4wrFAERszU+iWUPqGK3W4UwDH85E3FnIGGsXzrI6UE5GDDFBP9vwOm
 hsw9vcJR+xfN2i4+oOlpr+W3VrogQHSJlu0frvnq7SnFvO1EMRys9JKyviD+F5f1h1Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789735055;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=8GwJE91MWJmmHHd7Bi7CPIkMnAwuiSJDHWItFzOxgYU=;
 b=SfVjsewTRmyQDrpfiJu4nvyDZNSs3a7ES/ryrZehnaaZ5esHZ/zdhg085dbh4dRrhUCm
 xrrk+18dQ7c500JA1hSgzWrdv7UJNyU7Byh9CRx/9U7FUqpfsJ4p7ZFk/1yUidlq2LEAm
 X4bhDhco8q6J5DxMI6dW0Hy0dWQclK3qYt10nsdFj35aSNfUBtuzew1aBWngaJgfnIysE
 4nO35+Y7mX91oBqMQ8BlU94YSNewCDTBvbziC7XmxQLY+87ffL+aE7xZlI8Rmfs4eDa+h
 iuNRwLPApffz0JCK1o+HzYl3ZoPKM/BnOry1HKSjio69jwuaXgXd+rCxxTsQpuL4Mgw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=atXul4vL; 
 arc=none smtp.remote-ip=192.198.163.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.12;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=atXul4vL
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id F329B404E6
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 12:37:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789735055; x=1821271055;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:in-reply-to;
 bh=9JKlS7JbeoD17JYp0RiV8E44TqEkEw70/pa0E1MekTE=;
 b=atXul4vLozw1AM1QObSMV1s2a+I9rpECXWSQUjUTMROv+r6HTVMK7YWK
 glt/G6PRrL/reMoqXSYDdfu7ZpLjeGu5i4iFc/X3FwkzWtZPpPUjyP23Q
 bjf3sK7/yziogxEj7e8AxiU3VlsKTXv94Uhc3IuVIuIOmqnNyP6sIXDkx
 nrU/OZP+d5huYNAbTk18biLQfne+ksm9KiAFXorzBdbuCFr7aLJ1H+e2k
 V9mHNKQel+2o1/304dkFO6FCZrx29fctrdjG7opBiHCNi+rxPh2JOYNce
 0KLL6FGnEKkuJxyf3yOEDktZgWarAoXWyBmQLqa92VLqzKlq+TseDRhy1 g==;
X-CSE-ConnectionGUID: EBkqlEgRQNKgdBLMcaXwLw==
X-CSE-MsgGUID: UWk0CJLFSDG0vkoFHP8ofw==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="94070705"
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; d="scan'208";a="94070705"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 05:37:34 -0700
X-CSE-ConnectionGUID: cQ8BL3lORu2NXi05B+hDcw==
X-CSE-MsgGUID: 5br2+c1cR/+xJTrF5WNXbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,108,1787036400"; 
   d="scan'208";a="2573284"
Received: from lkp-server01.sh.intel.com (HELO 462990a40a85) ([10.239.97.150])
 by fmviesa012.fm.intel.com with ESMTP; 18 Sep 2026 05:37:33 -0700
Received: from kbuild by 462990a40a85 with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1x7XqM-000000009mj-2JTN;
 Fri, 18 Sep 2026 12:37:30 +0000
Date: Fri, 18 Sep 2026 20:37:30 +0800
From: kernel test robot <lkp@intel.com>
To: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com
Cc: oe-kbuild-all@lists.linux.dev
Subject: Re: From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Message-ID: <202609182041.eKLUsbtF-lkp@intel.com>
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
config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/20260918/202609182041.eKLUsbtF-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260918/202609182041.eKLUsbtF-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202609182041.eKLUsbtF-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_fw_update.c: In function 'ice_send_component_table':
>> drivers/net/ethernet/intel/ice/ice_fw_update.c:255:51: error: 'ICE_F_EROT' undeclared (first use in this function)
     255 |                 if (!ice_is_feature_supported(pf, ICE_F_EROT)) {
         |                                                   ^~~~~~~~~~
   drivers/net/ethernet/intel/ice/ice_fw_update.c:255:51: note: each undeclared identifier is reported only once for each function it appears in
   drivers/net/ethernet/intel/ice/ice_fw_update.c: In function 'ice_has_erot_incomplete':
   drivers/net/ethernet/intel/ice/ice_fw_update.c:680:49: error: 'ICE_F_EROT' undeclared (first use in this function)
     680 |         if (!ice_is_feature_supported(priv->pf, ICE_F_EROT))
         |                                                 ^~~~~~~~~~


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
