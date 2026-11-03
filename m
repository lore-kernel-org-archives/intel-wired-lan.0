Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48536606A324
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 02:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=dTbkRmtS;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=a/OKE1vr
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 22F92606B6;
	Tue,  3 Nov 2026 02:20:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id q1Utv6DbZtTL; Tue,  3 Nov 2026 02:19:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 4481B6070C
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793672399;
	b=j/U0/WbJSFMSTKY/T2fOCeQnu0rZjHqgmbumOAYR5EELmGPI2GHzTpFshipLwjWNufI0
	 SZivmWjNI4B2DprN1rFPw0haUQXK+8OD6IbndLLDJ98mZZmV6NGNMw95mtpnuPs8EIeV/
	 HD6hnZCQgjaSgTdfuWs6HUb8qEYLFLxjZQjjR6huFmNrr90SWA0R345iq8W92n+exC8OO
	 FUgV1E8paSULP4CPcTr0cYnYE/avrPWEQaLM8YRvSCrzI0RJg3JovGieOP+At5cPoxn4d
	 7OMq+JvitQDiwc6cEzQnWMWHnhIODfuYOvTUUKqA8cl9FcAiN6wErJzxKdzsDrNHTxg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793672399;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 User-Agent:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=6OfzYIP1bXExBnvc/K1qwnkf3+tq7zkwz1Js0K4ygeI=;
	b=Tvw8F2gVcMWaUBfRsxZPesujRnGYXb0ZP+9HGO2eaiJmo+YW99kgDU4vDHIj5DxGa//9
	 ZC/ydnLR7YPhdFg80vfLU8Uy9hJQbd91n3rIfa1cHeoAMKFP41FAgeJ/cnbT8Y7T/+8Uq
	 FIl8chzr61vnc8mRZ6Fgf+iZx0Xptb/wRmynDbN5PfsC0cPrVODHpdsmSAldJGp+sSWpY
	 ktTnZ+iURxB0RbZhrHQ6k69HXtb0CCHlCFkdcoR1gVwamp41Pvyk7cAL9IFd1dDYOHe/F
	 bSKPEh1N9UpyETkvsxcZT+UMDD343HLhK094DUa8kleTm6zs4skoSwgPTaPHIuOljWw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b="a/OKE1vr";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793672399;
	bh=6OfzYIP1bXExBnvc/K1qwnkf3+tq7zkwz1Js0K4ygeI=;
	h=Date:From:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=dTbkRmtSKdSfyGb1CqeLA6vShWRuc29Mn+D2UETxlUk0iKF34FR8591MVXyibJ01B
	 rUQp0B4+/RBODu4Wyll5HbixLxw9XjRugJiYLyf29WUKHPsHet5b71TdZRflCCpm9q
	 aReFoggRtRtBUbOqAus07bMzgYOPwDwgGFsu7/QECrrwSlvKRpkR4IUNZDcYPEaeB3
	 8vZSyVNwMChFqpqicJohicJWR1uMVQ+MypBCj6GoYwJjR0XQqS0wjwofuL62/7eQSq
	 yDQRplPs1Zu40qjwino5e6zbb+WZqnMZa2wdSwe4ZHL73pbp4RW161nNdzWCZQxLKm
	 s+fkpeKzRofiQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4481B6070C;
	Tue,  3 Nov 2026 02:19:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 4CF87356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 02:19:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3E88F6070C
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 02:19:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GcehwskyMJdK for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 02:19:57 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F0C3606B6
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.16
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793672397;
 b=SNYaghbZmZEnlPb461FINjr/iVRzR7nfUvNXGVzCbvV/3uBXKKEY+Nc/GDjYAAypEuJb
 PIZCDzhtEOVUW7l5cG53910eTjUZA0nv42gNbPWkhFYm7cOsBA1H8DVtofJOoAZh2qW74
 mGGx+F+YDNJ2m1KnjzX36nFVlTl5vqGjzA3G4I11iLikNmEJXRYKNCBufJmgdfkYxrcul
 H7C37PBa5eaz13T/XjJGHJ8dggub0nbViYHLtaFKxJNiZ8Tavb93HTQqdbWYhh3CWAj0y
 rqpqQoYmbnxFJQvVZXPC9mnpuxyH/Po29Yb1eDXHa1CxwygVhHt6zX+b6IaKJ6Z0Bng==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793672397;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:Date:From:To:
 Cc:Subject:Message-ID:User-Agent;
 bh=6OfzYIP1bXExBnvc/K1qwnkf3+tq7zkwz1Js0K4ygeI=;
 b=pLjv37iRthsjpC79Vry/X/XYXSajbAjd3stWPs3cOpOKS+uzj2zGT06QBhLxQibpHzU+
 ts8qzOO+pzuipjoePy+OFMAT4svc8HGSM+UiJTbuxjuj3QcjasByxNBaGpDTGQM3SpqNS
 g3zApCcc16VN8wyoeHQHyYLIQZpeyBUkBqh6uqfSSiULTppsK1ilxmm51wxPjUj3hEaAj
 73i/iub+7LQOyTxKjhWvYku2CQwb/C21I7RSYc3GmSSIxrGuqh7x5h6+b9fYCmLiDCxlP
 0kVQKdz6qEC3T3jwPDo+y4Rw96Yhycr6IcMxMaXF6KJ6qgqTUJaowgjcRPisIF2KpfA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b="a/OKE1vr"; 
 arc=none smtp.remote-ip=192.198.163.16
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.16;
 helo=mgamail.intel.com; envelope-from=lkp@intel.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=a/OKE1vr
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F0C3606B6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 02:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793672397; x=1825208397;
 h=date:from:to:cc:subject:message-id;
 bh=rJJ5NJ+myaFf56S49k8Z+VH+GXdpVVQvCQashy+coWM=;
 b=a/OKE1vrcltwA6K/VdwKPyJ54sfeQkR48aJ3xe+WA7FYTUqNg6BIY6Go
 U0iAFTPw2BIKy8xYNh1H7PAWWfg5ihNteZK9oFDlXTalXt2wCxfpuxeu8
 00IFgKEGZpjKX6IT7A7D3LNIQ70yncbBG/GTWY4/mTKH33anmZj4aW8qN
 ONOdjBp/IMxQuT5rDjq4qbQVs2FiPQmxH/HFNLEAXn1X1UINtgUx+tWIZ
 K//HvkffmQu22c0tqYqp9OYp2dcTsi/6vy2FmsACjHbVAHV8EK4t8PfP+
 BQoixg4UhMidylQGCF8p3An41j3qwbYIQ3s4gDG6QWbOamm73UNM5xZ+g g==;
X-CSE-ConnectionGUID: 3F4Mfwd6QG2tGdHzJiorcg==
X-CSE-MsgGUID: nIR9PxgsQZSqQS/hRXDjAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11954"; a="2396769"
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="2396769"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Nov 2026 18:19:56 -0800
X-CSE-ConnectionGUID: UCvned1ARz6oU4bRNnFt6w==
X-CSE-MsgGUID: IB5bKjUkSZmvT7Zrv1WTJw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,192,1787036400"; 
   d="scan'208";a="6451119"
Received: from lkp-server01.sh.intel.com (HELO 0caa9d2d175c) ([10.239.97.150])
 by fmviesa002.fm.intel.com with ESMTP; 02 Nov 2026 18:19:55 -0800
Received: from kbuild by 0caa9d2d175c with local (Exim 4.98.2)
 (envelope-from <lkp@intel.com>) id 1xO47s-00000000iC0-0Sau;
 Tue, 03 Nov 2026 02:19:52 +0000
Date: Tue, 03 Nov 2026 10:19:43 +0800
From: kernel test robot <lkp@intel.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: oe-kbuild-all@lists.linux.dev,
 Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
 Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [tnguy-net-queue:100GbE 5/11]
 drivers/net/ethernet/intel/ice/ice_ptp.c:1253:29: error: 'struct ice_ptp_tx'
 has no member named 'calibrating'
Message-ID: <202611031042.vATH1Rxg-lkp@intel.com>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue.git 100GbE
head:   3c73d34ba643c4e24ff549f3f083372a36b09952
commit: 64639b94e14663a7f80953ac0d075edac626ee96 [5/11] ice: E825: stop clearing PHY_REG_TX_OFFSET_READY
config: csky-allmodconfig (https://download.01.org/0day-ci/archive/20261103/202611031042.vATH1Rxg-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 16.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20261103/202611031042.vATH1Rxg-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202611031042.vATH1Rxg-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_port_phy_stop':
>> drivers/net/ethernet/intel/ice/ice_ptp.c:1253:29: error: 'struct ice_ptp_tx' has no member named 'calibrating'
    1253 |                 ptp_port->tx.calibrating = true;
         |                             ^
   drivers/net/ethernet/intel/ice/ice_ptp.c: In function 'ice_ptp_port_phy_restart':
   drivers/net/ethernet/intel/ice/ice_ptp.c:1328:29: error: 'struct ice_ptp_tx' has no member named 'calibrating'
    1328 |                 ptp_port->tx.calibrating = true;
         |                             ^
   drivers/net/ethernet/intel/ice/ice_ptp.c:1338:29: error: 'struct ice_ptp_tx' has no member named 'calibrating'
    1338 |                 ptp_port->tx.calibrating = false;
         |                             ^


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
