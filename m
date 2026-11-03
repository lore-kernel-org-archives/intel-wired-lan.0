Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2612E606A335
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=vPzA6JBT;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=JMiYCjG0
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 00114606CE;
	Tue,  3 Nov 2026 14:39:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4AY--qytdUaQ; Tue,  3 Nov 2026 14:39:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9EBEC607C2
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716787;
	b=c2DyEUKl7wo+uMkB4ZB8nbveYMABlSZopbgDCdFcTw4Z9/YJ2El5C7ubq2pjRn99debS
	 66b5zU3FLgUQ+oTYKb4QllDzyZu3wFwaFdjN6aWB95JXwzgXc+dTh09NOE61sCLlc5ZrH
	 amI3QR8XTQ9i2lZ4P1wOdXyKxTC21/v1Aaw9OIj8fXyu//7WMTBLcSiezRtkLiLSSzaUM
	 U6QFbumoiMh8e5x9Hqhj7Ok/d9nacQ3osn9utf8ZALmCfQaCBfy1fkQ9eA5h20MPnDdFS
	 W983+7LjsMVU08i3xROanKmqGVaOQ4nL8qqlikz6mN3u/oCe/LHiF6ISr6+vRGnTlCw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716787;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=SHRtTIwSmNkgp15gG3MxPlaeI177A9ASleGLZSw3ylE=;
	b=sbWrzgTF3DsUg6RbHctDuAR4cjSq1c4WaG2xM0luamKrBOVtZCQFw9FCuYfH6yGLe25H
	 6T5PxHEurPiSBlMB1eZh3UpT34+KgiPiVycbAoFeUzZ4Rpf2xMsO73tLGq1HbMkBSPlXd
	 VukISPQ0KWlcbSYaAEzP8z/SiopaOwB1kMesXeR/cPxZ9X73TvUO95G+M3byPobVjJ8MD
	 1yRfVpQVZO6I3apLol/b2ua8lfMuZEMp7GGWHS+A4JHviaIpyEKkGIN5htAYpx+SKOfTt
	 eN9THAEIjhyccUDLdaR8mHwQSZLjhn1M59lYwA1sM1PsbDw/JbTxyFhzxGO9vZq72EQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716787;
	bh=SHRtTIwSmNkgp15gG3MxPlaeI177A9ASleGLZSw3ylE=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=vPzA6JBT9hMZF4XWvXjU8BAWyHSsPBp2zQbda+o21n2KfmUe1P0sTtCb0UhFGgJRc
	 w976Mo6ahYerTkUdshzZ+DT06M6UkF6sjJuwdhYvdb0K9Sc4j8tw4pAtKE6QFKG2oA
	 XJe+CHsWLuzDHj3n2LmGbO5w7l4hf4ZIkea1uNfTxo0KRLJI2USG9tRuAaoRnIEx6M
	 sOcgvTTHNXcO7r53sWoeJDYV4uaM3noTV6W1+IRhnWK8yJp3eliBfcEW/cB8MOYeHW
	 BeVyJiqHRrYaeJLZV2G7OZ/3zHa/4mo/P42RhJ8rfVYkfd/1D92M7A44ih06tloYd/
	 0GHh4rvncR0WA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 9EBEC607C2;
	Tue,  3 Nov 2026 14:39:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 39E89356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B4A44070A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7i9-Vl-JMehY for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:39:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C4B5540715
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716785;
 b=mTowTDjVgj2hpoq0cNj4joc0mF3UpWdfUU0qQWCQGtxgEtDR3LLogHuTCqrDGwdtnN8P
 txYUL74YnWW9t/u6iWNlwAuvmnKN8LbOUTQvHicTbgG9F4yvxpVFoMiu3cC7wXvG6ARoj
 m4/+5s1B8JrPB94TkivtH8bu6LLV48JYgHND6Qq9lgUxdU+ra1y64Jeys3TH4Ht8fWIWX
 X8e2NwIDfns9v9nbL7mqac5UWlFnptSmq0cPm7u4WZZx+YsKvcXkxCPQ+ZbxAaS+5Go8G
 adJ3Y2WYmfJc7frQcqns6QLXPkT0mHaOT4oZQTAQkKqR8Ez5JWikTPf2aTM8NIRDyDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716785;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:MIME-Version:
 Content-Transfer-Encoding;
 bh=SHRtTIwSmNkgp15gG3MxPlaeI177A9ASleGLZSw3ylE=;
 b=WYxMu6oXuCysFlDEPddY45HMM3B9ynlyxvVXFJkkt53RFqLjsiZTvWPq+66IzXLKLk+3
 QwFWXmkFU/DSFhSECYjBCVePUCZ39i83TPTWtAcl81ss6eLeAHNywL68eFuNfpjAfClKm
 Noy8XvRde3NP7bj5soQzHc+Dn1DPyv75VkllIozg01cxVkwbAK4cApcuw/mKB3jhtRS4A
 ezUtwmHuzB9bSWV2Nd1hxg3VrACn9QwK5tOGs6ZGnk6RP/hiKZYF09/8W/eHhuzAAdnIV
 agPJgChbXtbu5I7pW5LbSF2cDpXO59AINkN70cJkSGriP/YDdPShMD7LU1ObXcFenFA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=JMiYCjG0; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=JMiYCjG0
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C4B5540715
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716785; x=1825252785;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BnUCkLe6FRlgPEPrB3bX8dlE3/DheYzRxhVA6psip3I=;
 b=JMiYCjG05hc0U2qOMUPj2Fu1IvKTdFZkqKK89gCJJRYoCI4tUECcBgDC
 aWTBnLc7urWup7mrT0mDpaXvYCtMmo4MDn4GO2VFRXT+oMBCXs5Ja/eFd
 leSSqJzhSrKsMtg0El8qtZFheTR+a/Bf0BKEuIXdfexMpQMrK6cg4769f
 3TxKmINv3VgLMouMGhQsWJC/msZSfTCyZSdK6hFqwwK47Dy14e0Vp/lxZ
 zkaONQ6uH8mUryv6iS9orGGz5ZHUBEmH0cB/vsvVIyi6qJdvEzXwcnZ2o
 F9ZEi3Dy70sAEGD2Jm39DPw2Njl/3Jl83ssZn+KmcTtlYsQI9IcaAv2tU A==;
X-CSE-ConnectionGUID: EnVjyNgITfyZ/Pcud82THg==
X-CSE-MsgGUID: tCG9nIutTiGcOpAPbr0/Xg==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2323960"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2323960"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:39:42 -0800
X-CSE-ConnectionGUID: ThPV+OqwRkiy1WgCNB7Glw==
X-CSE-MsgGUID: DfaHHEhwSHij0nzhvnluUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8289830"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:39:38 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 5E0FF312E9;
 Tue,  3 Nov 2026 14:39:35 +0000 (GMT)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Jiri Pirko <jiri@resnulli.us>
Cc: intel-wired-lan@lists.osuosl.org, Simon Horman <horms@kernel.org>,
 Michal Schmidt <mschmidt@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 bruce.richardson@intel.com,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 padraig.j.connolly@intel.com, ananth.s@intel.com,
 timothy.miskell@intel.com, Jacob Keller <jacob.e.keller@intel.com>,
 Lukasz Czapnik <lukasz.czapnik@intel.com>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v4 00/15] devlink, mlx5, iavf, ice: XLVF for iavf
Date: Tue,  3 Nov 2026 15:14:41 +0100
Message-ID: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Also available here
https://github.com/pkitszel/linux/tree/xlvf-v4

The purpose of this series is to allow iavf to use more than 16 queue
pairs, in two modes: up to 64 and up to 256 queue pairs.

In order to support more queues for VF, we must give it a bigger RSS
table (GLOBAL LUT or PF LUT). There are 16 GLOBAL LUTs on E810, and one
PF LUT for every PF on given card. Both kinds could be (re)assigned to
a VF, while a PF must hold at least one of them at any given moment.
GLOBAL LUT allows VF to use up to 64 queues, PF LUT lets it use up to
256 queues.

RSS LUTs are exposed to the user for assignment via devlink resources
API, which I have extended to make it possible.

Devlink changes:
1. Extend shared devlink by two callbacks, that give the driver
   a constructor/destructor for the priv data attached to the shared
   devlink instance. The constructor gets an additional param, used in
   "ice: represent RSS LUTs as devlink resources". mlx5 is touched only
   to adjust to the API change.
   ice uses the shared devlink instance as a "whole device" aggregate
   over all PFs on given card, instead of its custom xarray.
2. Extend devlink resources API to allow user to assign resources.
   Before, only the driver could assign resources, without any way for
   the user to interact. Now the driver could register an occupancy
   setter (.occ_set()) for a resource. ice RSS LUTs are exposed that
   way. It was proposed as an RFC in Feb 2025, link in the patch.
3. (minor) Add devlink_alloc_drv(), to allocate a devlink instance for
   a device on behalf of another driver. ice uses it for the VF devlink
   instance, which has to be owned by ice regardless of the driver bound
   to the VF device.

There are also patches for Admin Queue extension, GLOBAL RSS LUT
alloc/free, and two rather big "new opcodes" patches, by Ahmed (iavf)
and Brett (ice).

Finally there is a patch that adds devlink instance for VF and
registers devlink resources on it, combined with all the glue code to
make actual use of the whole series and accept the larger number of
queues for VF. This (the last) patch contains usage examples.

There is one resource added that just groups GLOBAL and PF LUTs under
it, so there are 3 rows of data for each device (PF/VF/whole-dev):
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 1 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none

Technically the aggregate "name rss" line could be eliminated, with
just the two last ones kept (then renamed to "rss_lut_2048" form, from
the current "rss/lut_2048"). I like it as it is, but this is just an
opinion, I'm open to discussion.

Things AI reports but I don't want to change:
 * hardening against a malicious or buggy FW: we have to trust the FW
 * hardening of the VF against a malicious or buggy PF: likewise, VF has
   to trust its PF; in particular, I'm not adding checks for the PF
   reporting qregion_width so big that BIT(qregion_width) in
   iavf_fill_rss_lut() overflows and yields a modulo by zero
 * non-atomic updates of iavf adapter->flags: pre-existing pattern in
   the whole driver, out of scope of this series
 * lock inversion between PF devlink lock and pf->vfs.table_lock:
   ice_tear_down_devlink_rate_tree() takes them in the opposite order
   than ice_start_vfs() -> ice_eswitch_attach_vf(); pre-existing, will
   be fixed separately; this series takes table_lock first

Some of the pre-existing issues reported by AI are fixed in a separate
series:
https://lore.kernel.org/netdev/20261102105346.30739-1-przemyslaw.kitszel@intel.com

v4:
 * devlink: return -EMSGSIZE directly on
   devlink_resource_occ_size_put_legacy() failure (Jakub)
 * devlink: document in devlink-info.rst that an instance created for
   another device reports the name of the creating driver
 * ice: declare rel_err at function scope, a declaration right after
   a label does not build with GCC < 11 and breaks sparse (Jakub)
 * ice: take rtnl when devlink changes the RSS LUT of the PF, and tell
   the ethtool core when the user RSS LUT is dropped, on devlink LUT
   change and on reset; drop the -EAGAIN checks from get/set_rxfh
 * ice: reject devlink RSS LUT changes while a reset is in progress, drop
   global RSS LUTs of the PF from the table already in
   ice_prepare_for_reset(), as FW frees them on reset
 * ice: log when a reset discards a devlink RSS LUT assignment, keep the
   specific extack message and the real errno when a LUT change fails
 * ice: take the Q_OPT section from vsi->info under rss_lut_lock when
   toggling the RDMA filter
 * ice: document the devlink resources and the VF devlink instance in
   ice.rst
 * ice: limit queue chunks of the LARGE VF opcodes to ICE_MAX_QS_PER_VF;
   set the q_vector and ITR fields in VIRTCHNL_OP_MAP_QUEUE_VECTOR, as
   VIRTCHNL_OP_CONFIG_IRQ_MAP does
 * ice: after a PF reset, lower the queue count only of VFs that lost
   a bigger RSS LUT, and only to 16
 * ice: restore the VF RSS LUTs after reset outside of rtnl, cap
   REQUEST_QUEUES at 16 for VFs without VIRTCHNL_VF_LARGE_NUM_QPAIRS,
   report ICE_VF_VSI_ID as vport_id in GET_MAX_RSS_QREGION reply
 * ice: do a pending deferred VF reset before handling the next message
   from that VF, clear ICE_VF_STATE_NEEDS_RESET on every VF reset, and
   re-run the service task at once if a deferred VF reset was scheduled
   during its pass
 * ice: don't create VF devlink instance without VF pci_dev, e.g. on s390
 * ice: report the VF queue allocation in num_queue_pairs also with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, as in legacy mode
 * ice: use scoped_guard() instead of guard()
 * iavf: send queue configuration and queue to vector map one message per
   watchdog run, instead of polling for each reply with a 1s timeout;
   stop sending on a PF NACK
 * iavf: ethtool -L: let the watchdog send the queue request, instead of
   failing with -EBUSY whenever another op is in flight
 * iavf: init: wait for the outcome of the queue request before other
   extended caps; ask for up to one queue per CPU, take the request as
   granted only when PF gives that many, and on a denial go on with what
   we have; check IAVF_VF_ARQLEN1 while waiting, as the PF reset event
   could be lost
 * iavf: reset aq_wait_count when init starts over after the PF stopped
   responding, forget the queue request there
 * iavf: refill the RSS LUT when the RSS region changes across a reset,
   kzalloc() the RSS key and LUT on reallocation, reject ethtool -X LUT
   entries outside of the PF RSS region
 * iavf: num_queue_pairs is the VF allocation also with
   VIRTCHNL_VF_LARGE_NUM_QPAIRS, ethtool -L max is the PF RSS region
 * iavf: limit MSI-X budget to 64 queue vectors, program ITR of vectors
   16..63 via VFINT_ITRN_64, change ADQ total_qps to u16
 * many smaller fixes after Sashiko review; per-patch changelogs are
   under "---"

v3:
 * ice: fix rollback of VF queue configuration to disable queues by
   their IDs, not by qpair index, as the config could be now split into
   many virtchnl messages
 * ice: register PF devlink resources only in the regular probe path,
   not in FW recovery mode
 * ice: don't free the user RSS LUT in ice_vsi_decfg(), it was done
   outside of pf->rss_lut_lock, and ice_vsi_cfg_def() frees it anyway
   when the LUT size changes
 * iavf: auto-request queues in LARGE mode only at init, not on every
   reset, and only after VSI and RSS fields are initialized
 * iavf: schedule a VF reset when RSS key/LUT reallocation fails
 * devlink: keep size of .occ_set() resources in sync with the getter;
   WARN on registering only one of .occ_set()/.occ_get()
 * devlink: add devlink_alloc_drv(), so ice owns the VF devlink
   instance, regardless of the driver bound to the VF
 * ice: unregister VF devlink on ice_start_vfs() failure
 * ice: reject out of range itr_idx in VIRTCHNL_OP_MAP_QUEUE_VECTOR
 * ice: fill the new RSS LUT under rss_lut_lock, keep the PF LUT zeroed
   when RXHASH is disabled
 * ice: restore VF aggregator node accounting in ice_vsi_decfg()
 * ice: drop PF RSS LUT ownership also in ice_deinit_pf(), as
   ice_vsi_decfg() skips it after a NO_INIT VSI rebuild
 * ice: restore default RSS LUT assignment of PF and its VFs after
   reset, as FW drops it
 * ice: check VF VSI for NULL in ice_vc_request_qs_msg()
 * ice: fix RSS LUT tracking on dual-NAC E825C: each NAC numbers its
   PFs and global LUTs from 0, so offset secondary NAC PFs by 4, and
   keep a separate global LUT table for the secondary NAC
 * ice: derive VF rss_size from its queue count and LUT capacity on
   each VSI config, instead of keeping a stale value
 * ice: wake up service task when scheduling a deferred VF reset

v2:
 * drop "ice: simplify ice_vc_dis_qs_msg() a little", already applied
 * devlink: propagate the .shd_init() error to the caller, so
   devlink_shd_get() returns ERR_PTR() now; register the shared
   instance only after successful .shd_init(); document the new ops
 * devlink: document the .occ_set() mode of resources
 * ice: prefix the shared devlink id with "ice:", handle errors of
   devl_nested_devlink_set()
 * iavf: stop multi-message virtchnl ops (queue config, queue-vector
   mapping) at the first error or PF NACK, keep the op pending on
   timeout
 * iavf: fix queue and RSS (re)negotiation on init, reset and
   ethtool -L
 * ice: serialize devlink RSS LUT changes with ethtool -x/-X/-L, RXHASH
   toggle and VSI (re)configuration, by new pf->rss_lut_lock; make ADQ
   and devlink RSS LUT reassignment mutually exclusive
 * ice: limit VF queue count and PF RSS size to the capacity of the
   current RSS LUT
 * ice: create VF devlink together with the VF, rework deferred VF reset
 * many smaller fixes, mostly after Sashiko review; per-patch changelogs
   are under "---", together with Sashiko suggestions that I decided
   not to apply, and why

v1:
https://lore.kernel.org/netdev/20260508124208.11622-1-przemyslaw.kitszel@intel.com

v2:
https://lore.kernel.org/netdev/20261009121433.30347-1-przemyslaw.kitszel@intel.com

v3:
https://lore.kernel.org/netdev/20261015185454.6332-1-przemyslaw.kitszel@intel.com


Ahmed Zaki (1):
  iavf: use new opcodes to request more than 16 queues

Brett Creeley (2):
  ice: add VF queue ena/dis helper functions
  ice: introduce handling of virtchnl LARGE VF opcodes

Przemek Kitszel (12):
  devlink, mlx5: add init/fini ops for shared devlink
  ice: use shared devlink to store ice_adapters instead of custom xarray
  ice: add helpers for Global RSS LUT alloc, free, vsi_update
  ice: rename ICE_MAX_RSS_QS_PER_VF to ICE_MAX_QS_PER_VF_VCV1
  ice: bump to 256qs for VF
  iavf: extend iavf_configure_queues() to support more queues
  iavf: temporary rename of IAVF_MAX_REQ_QUEUES to
    IAVF_MAX_REQ_QUEUES_VCV1
  iavf: increase max number of queues to 256
  devlink: give user option to allocate resources
  ice: represent RSS LUTs as devlink resources
  devlink: add devlink_alloc_drv()
  ice: support up to 256 VF queues

 .../networking/devlink/devlink-info.rst       |   2 +
 .../networking/devlink/devlink-resource.rst   |   5 +
 .../networking/devlink/devlink-shared.rst     |  19 +-
 Documentation/networking/devlink/ice.rst      |  74 ++
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 drivers/net/ethernet/intel/iavf/iavf.h        |  35 +-
 .../net/ethernet/intel/iavf/iavf_register.h   |   2 +
 .../net/ethernet/intel/ice/devlink/devlink.h  |   2 +-
 .../net/ethernet/intel/ice/devlink/resource.h |  28 +
 drivers/net/ethernet/intel/ice/ice.h          |   5 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  55 +-
 .../net/ethernet/intel/ice/ice_adminq_cmd.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lag.h      |   2 +-
 drivers/net/ethernet/intel/ice/ice_lib.h      |   5 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   5 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  36 +-
 drivers/net/ethernet/intel/ice/virt/queues.h  |   3 +
 drivers/net/ethernet/intel/ice/virt/rss.h     |   1 +
 .../net/ethernet/intel/ice/virt/virtchnl.h    |   4 +
 include/linux/net/intel/virtchnl.h            | 136 ++-
 include/net/devlink.h                         |  41 +
 .../net/ethernet/intel/iavf/iavf_ethtool.c    |  45 +-
 drivers/net/ethernet/intel/iavf/iavf_main.c   | 253 +++++-
 .../net/ethernet/intel/iavf/iavf_virtchnl.c   | 281 +++++-
 .../net/ethernet/intel/ice/devlink/devlink.c  |  11 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 804 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  | 115 +--
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  91 +-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  25 +-
 drivers/net/ethernet/intel/ice/ice_lag.c      |   6 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 169 +++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  64 +-
 drivers/net/ethernet/intel/ice/ice_sriov.c    |  19 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  52 +-
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   |  79 +-
 .../net/ethernet/intel/ice/virt/allowlist.c   |   8 +
 drivers/net/ethernet/intel/ice/virt/queues.c  | 518 +++++++++--
 drivers/net/ethernet/intel/ice/virt/rss.c     |  38 +-
 .../net/ethernet/intel/ice/virt/virtchnl.c    |  38 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |   6 +-
 net/devlink/core.c                            |  20 +
 net/devlink/resource.c                        |  97 ++-
 net/devlink/sh_dev.c                          |  57 +-
 45 files changed, 2946 insertions(+), 315 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

-- 
2.54.0

