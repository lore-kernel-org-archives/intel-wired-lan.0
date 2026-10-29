Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B18606A339
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Oct 2026 20:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dvJNACox;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cfdddEid
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F2ADB60A7D;
	Thu, 29 Oct 2026 20:54:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PjGL4ftIG9DG; Thu, 29 Oct 2026 20:54:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C2C4260755
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793307262;
	b=lz/+46FW8oc+4av+B3GXnmG91eYxCuHfhMO9mQuEyOf9V8FgKUmGMDIdzPnXqufIylwt
	 dJrsh69GEdI/BfzQ7vTTRaD+T3SAIvWzJspDIXYsb9sXvb7IGwL9m19a5ZyXPdb3UtbES
	 /evkaC/GE+I+ph1Apm3VZ89VZHT0JIespiwfz13we1Osmm0ydUsv/eQFXpR5Y4eSu6cFz
	 K0IMGpGwDYoDxnN632Vu33R7HptSuPe7jDgQ62sagNSE5OGV/2fby2AUDvx219d8VewXI
	 Mw8iLqL4g4Rk0O8RoP3mlE0ZhwqtUigpExUJIqItzt/E9F2TN+79G3UoFGHa4Ka1ALw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793307262;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=lGu69vDvGx+7L4WZE7mVDe2bLPktA6ISozdTi5g/Juk=;
	b=H47Uv8xh3cuWicNQaL9JR6c8mFetEeRuHJ/HVeSo3zDcs2+ih+P9jeRCM++aPUu704gi
	 wnyQxH3o1ibdDdRFH149siedmSIQ+391xPGrT8niTOVmk9dwF3x4Rk3ldHgZp+d2NLfRe
	 g1BIIj1NOd62mtS6i/09jd4NghrhBOniyX8LfIehfFubx9DBd/3ckMB/G/E2UwCroG1ql
	 qLbZdGGgo4xnh5H2+biG16P1xWGtErngd91/O9nTk/GIijryalO7Jj/z0DEoMuaB3D8yB
	 3I87Tm7e3MbFMl3FhqpV2UYRuW5NVEWOywOJIwGdNYwGyOKmpglM+mmYmIxdTiySLlw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793307262;
	bh=lGu69vDvGx+7L4WZE7mVDe2bLPktA6ISozdTi5g/Juk=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dvJNACoxHdUnteJ85zqPgB2+pBS2wgzHROhtDv9+Q1RxrxyRX+B3ipQ9WSpkc77If
	 NlR5x+ideZaQl6q60lZ4cE2tCYLkqYHhrKohA5pyQPTp/Vb5KqfVRB4ZG5HsbpEufS
	 B1EtMUS+0vukImgf4CEoZ4qlDH2OISopULaMrzIklEKfXRiyw5qJxwh/xk5ebfK7+O
	 lTbfG7HnlXXzM4E0zvxf77oXSOXR+pnR3jppgIfwF2CeeRk5d+20B5CcJ7sDFsfBy+
	 SI2J+7KmojIWOXtD9ptKmAI7TmHo+sV1q60wmqTV+25Qn5Ctn+qtEbI25dVwXCC+Uf
	 6ighzDPpiavsg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2C4260755;
	Thu, 29 Oct 2026 20:54:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A6692D36
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 20:54:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D35E40A6B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 20:54:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id xm9r72kU3Svr for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Oct 2026 20:54:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org E1CA4407B3
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.13
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793307260;
 b=rYGpUCVwOrmUfdWzq+7GvmjutroMRZUpMHCgY9afVarstfJ6Bqy96FgKPEZh2GM3rIuE
 1j3kIBwC9wSPh5ovy4WuEDqFY5sc15FKOTp+BofjD96IqOtwbgsdVGiSF6En8AB0tH4k9
 X7e/lTulZbMjj6C7IUkJDv+LcEkTV3U76qPC2OrzVjN9h1LbKzED07KUIqjNCgDqRIJDj
 8marSAtKH2d2l6Slf4PVBGifS041XS8t2IocgDiEzcStqSI62Kj7H6NiaiTtOEXbdCIDL
 Ye4drz3TUbiX2HXJDeEr13TJwIaFs0o7XSllNPhbJGUh/1fRrhzAaWmNn4pcmanjuFw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793307260;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=lGu69vDvGx+7L4WZE7mVDe2bLPktA6ISozdTi5g/Juk=;
 b=qg9HWxpikDkxJt6pJ8rAJFQdn119UreW3Czwl98qpnGHz0vRaZslXlq2c+7RKQpfGyg/
 uqWhXTlv255aZhEuSf2Opj2zPAg3NGUbinBKToBAc219xwHNxS1D8RdOVlqRxAxWwC5Fw
 Yaem/PC1mcQRmkGDrINyvkNPVYQWPpBfIRniKTbWRZsfEOvz/gIKzvK8Abhs/iYFuLwxu
 nsPVv7ziN520Kb/Tst7W1Hqlqkj9iQoL+i6RPaUBGAM2d/MncEiMTAunQ0e2vo/HeXemE
 CcsMZwhrwXvwVU/cw3F4LgiHiHMWFnzJpMDVdNhaxImlH8z12+ENc41Ihap1o2eluiw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cfdddEid; 
 arc=none smtp.remote-ip=192.198.163.13
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.13;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=cfdddEid
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E1CA4407B3
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Oct 2026 20:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793307260; x=1824843260;
 h=date:from:to:cc:subject:message-id;
 bh=gWxtGLHDvEyB9hQHU+iVke1FUdNo0PxD3/rIURZ/IWo=;
 b=cfdddEidVqcYCZY7kDw+V2CA2R8N/a9FC8m2B0WQDwpwtmKuqfZOuwVM
 5KPWly65elLuDG9/Nz2k1Rrq6D8VzlVBg/HNEmggglvjCsgb9J1AVPvNx
 xGuuImUel9B3B0i7hhdD7cfliRokyZSLuVp+okAJrPqX06WIrgBxHbHQN
 2cr3Z5GGzgqZ57f2rexzxku2e155WWXtYSt6szdG9bGrNBe+CgP72x/81
 Tw3DsNwYZ8GdhDF31qDNDl2Pqcq6Wiasz3cg8hirV4d3QHMEid9yc8og4
 MFC8t9O9dnm7+WEwXwz0328nYS+vlnha5ltkhGSugxid+5/bBD6vVeInY A==;
X-CSE-ConnectionGUID: UMy93LT+R4q5wA2FCMYnSQ==
X-CSE-MsgGUID: epBdJp9wTYW1uJxCDRqqlA==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2054740"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2054740"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 13:54:20 -0700
X-CSE-ConnectionGUID: sVXAUUIdQ6CLSNJs9335FA==
X-CSE-MsgGUID: 6yJ9WioLQPufnjJTRi69Cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5275470"
Received: from igk-lkp-server01.igk.intel.com (HELO 58ca8a381a5c)
 ([10.211.93.152])
 by fmviesa004.fm.intel.com with ESMTP; 29 Oct 2026 13:54:17 -0700
Received: from kbuild by 58ca8a381a5c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xMX8Z-000000005LH-3CKd;
 Thu, 29 Oct 2026 20:54:15 +0000
Date: Thu, 29 Oct 2026 21:53:23 +0100
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE 5/11]
 drivers/net/ethernet/intel/ice/ice_ptp.c:1253:15: error: 'struct ice_ptp_tx'
 has no member named 'calibrating'
Message-ID: <202610292105.A3nUSLeQ-lkp@intel.com>
User-Agent: s-nail v14.9.25
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
head:   3c73d34ba643c4e24ff549f3f083372a36b09952
commit: 64639b94e14663a7f80953ac0d075edac626ee96 [5/11] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
config: sparc-randconfig-2000-20261029 (https://download.01.org/0day-ci/archive/20261029/202610292105.A3nUSLeQ-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261029/202610292105.A3nUSLeQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202610292105.A3nUSLeQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_port_phy_stop':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1253:15: error: 'struct ice_ptp_tx' has no member named 'calibrating'
      ptp_port->tx.calibrating = true;
                  ^
   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_port_phy_restart':
   drivers/net/ethernet/intel/ice/ice_ptp.c:1328:15: error: 'struct ice_ptp_tx' has no member named 'calibrating'
      ptp_port->tx.calibrating = true;
                  ^
   drivers/net/ethernet/intel/ice/ice_ptp.c:1338:15: error: 'struct ice_ptp_tx' has no member named 'calibrating'
      ptp_port->tx.calibrating = false;
                  ^


vim +1253 drivers/net/ethernet/intel/ice/ice_ptp.c

  1222	
  1223	/**
  1224	 * ice_ptp_port_phy_stop - Stop timestamping for a PHY port
  1225	 * @ptp_port: PTP port to stop
  1226	 *
  1227	 * Context: must hold the adapter ps_lock.
  1228	 */
  1229	static int
  1230	ice_ptp_port_phy_stop(struct ice_ptp_port *ptp_port)
  1231	{
  1232		struct ice_pf *pf = ptp_port_to_pf(ptp_port);
  1233		u8 port = ptp_port->port_num;
  1234		struct ice_hw *hw = &pf->hw;
  1235		unsigned long flags;
  1236		int err;
  1237	
  1238		lockdep_assert_held(&pf->adapter->ps_lock);
  1239	
  1240		switch (hw->mac_type) {
  1241		case ICE_MAC_E810:
  1242		case ICE_MAC_E830:
  1243			err = 0;
  1244			break;
  1245		case ICE_MAC_GENERIC:
  1246			kthread_cancel_delayed_work_sync(&ptp_port->ov_work);
  1247	
  1248			err = ice_stop_phy_timer_e82x(hw, port, true);
  1249			break;
  1250		case ICE_MAC_GENERIC_3K_E825:
  1251			/* Disable new Tx timestamp requests */
  1252			spin_lock_irqsave(&ptp_port->tx.lock, flags);
> 1253			ptp_port->tx.calibrating = true;
  1254			spin_unlock_irqrestore(&ptp_port->tx.lock, flags);
  1255	
  1256			ice_ptp_mark_tx_tracker_stale(&ptp_port->tx);
  1257	
  1258			err = ice_stop_phy_timer_eth56g(hw, port);
  1259			break;
  1260		default:
  1261			err = -ENODEV;
  1262		}
  1263		if (err && err != -EBUSY)
  1264			dev_err(ice_pf_to_dev(pf), "PTP failed to set PHY port %d down, err %d\n",
  1265				port, err);
  1266	
  1267		return err;
  1268	}
  1269	

--
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
