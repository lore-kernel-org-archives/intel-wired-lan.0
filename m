Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADEA606A335
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Nov 2026 14:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=gHzP5ycK;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ABuZUtxN
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 03E266086D;
	Tue,  3 Nov 2026 14:40:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id k0I-eOFAxEsv; Tue,  3 Nov 2026 14:40:18 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 29D1760882
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793716817;
	b=P/x5oVobPWPAH6bmqEMUtW0+SbZvOecd3uJ4kUtTeRaLjKOCX4kzcx9TaojI2L0Lzdhu
	 4uMzX0cVbdOPxkZNVS9tcUYjgT3Q+bSsgLGLOer9MjeiX2MFdnX5VjWOpG6upza8lAyi/
	 vkz0wg77mhwt1zODKe7XvnNL0ATLNmaDZ5XOLp1x0hTA3oWVQDa5e+Zc1twOwEr+4HKFI
	 Uzpj/Q3AYgzTwmKOzPzLSG1DWhc7FubwRCgE0KwvHUA68whEj24lHjkLtQdBglM8pmTDF
	 xGrxAWHePz9kstsEh3sBKjUZ5wjFQCeubnqdz3nAgtR5eytxJZQ0w0T1Ur52Es2GGDA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793716817;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=mmNkwM43Ug27ibS7Csvwtd4/8WrKZy8wi2eAoaIM/Nk=;
	b=VKYjA33a3otuM2EA+Jiezl/mjWiDmUWnZrnRQV8eBYI7ugEOH+0DRzKxy/Y216ZMlJHO
	 56RadM/xceCR8rc6QGeGtoTOd1qPJw6w45AL/76feuzd2oWYW1BfZ9tEJ1ESDl1a+Wiq4
	 Mk9LgCFGkh59axirGKwHIjRTgnGQjMX/R0ww/rA9sAUwfDz6x9gI3whMvLJ/fG863R1qg
	 wnzGjFFiHgtqME0T9qVFNNfsmUTu4nSt20dIGk7PvrhOtZ3+6u4q8IyrSk/6J0ENefYNW
	 MoSPKMMZpPymOCH2i9OPUoocdgWCK5gotTihkVOU6NUZJXyAu1aFb72ILdfZdgzoNpw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793716817;
	bh=mmNkwM43Ug27ibS7Csvwtd4/8WrKZy8wi2eAoaIM/Nk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gHzP5ycKOOhNFWzP7fufrZCDfipKYyLykELnlh8ATbBXlW/w0pB0hH1aBbVA+S0HJ
	 lrYNbyTjGXJ03W5MBmvXWxHFA8vB4PBHVgAjDffyPemYDsRBX0CfdKWYJfGbZmuRP4
	 wmcCxVWEUFuqIb2B9j04lH0KArEVLs0ZydTQF3WdeAmfhkJbYKqiBOKD3SW4TNefiT
	 aBIQw5zoyFOSislC3fMuZB3jgDNf5FgWwxvXDfG4Ole1zB/hFoJ2BqNjPYNlxcx/PE
	 RDtKNQzyTdu5gXHbJBrGaVt3hNvPQsZTQ8KM67ObYN34SS5dVz2vESmyBHnrPq+zQz
	 eLeF1nsu1XLOw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29D1760882;
	Tue,  3 Nov 2026 14:40:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id E702D356
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id CD2604030D
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id V-KgXpF7OeIt for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Nov 2026 14:40:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org DD844400E0
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.12
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793716813;
 b=pwX172opsF3DtcPQQtwUUed0poP1jFS3e2VTBFohCdp0Fvmsz1tCgDFYsCrEgbrJzu7O
 pqc/EizOxg593csSKlTwuaYNHPkxeDk/y9Gf391YdaMa5AvLJBaMY2ixyZbCc8CdEbXWg
 i54rLX19v9F3p3pZF6C45RBV6XOymn2Q7z1KEsINnYSKhIPgY3D8LnzGQ2ElMfrKY0NG/
 s3i+pZOVzPh3XiZOsmHnuYv8ZSEz0grkniZx6KlFRe/6R1j3+zANtK7qCpwBSwRWb0iCh
 XxXz97dsNNXF8uTSW8cIG/k1ojOtvbHh2ZWgWySANA/TG0PSAnoOFsdJgASAPI6q37Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793716813;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=mmNkwM43Ug27ibS7Csvwtd4/8WrKZy8wi2eAoaIM/Nk=;
 b=GuYPF3vDG4qgHEAjn3pbRqvKmAUYL1NLISsJpK/TA3VsllQvy0XomGA1ZmUvS3QHerK/
 X6Hgpu0ehwyK/5fS22rYE56QlDwqjwov2flnssd3HiwgXdGhOcPEl13SiJyZFSNBL0CvI
 macPuC5EOcs9+R8yU9KAlQHX+24ktvCnNVzHgrR5nOEF1L4VWtPYzCOH9BR9whF+gHo9t
 O6i3voJoy/KjExgqku5M4cOdZIcsn1cNwdqMr9HkEeVxdmvNTS7l0RYiRPTxNlxoe3lC/
 0ocahMMxmSc+BsJjV0/ScS9wY99w/70xgsjYArXu2no6ULlJ8qnFOeB1QuPLFvGz3aw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=intel.com;
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=ABuZUtxN; 
 arc=none smtp.remote-ip=198.175.65.12
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.12;
 helo=mgamail.intel.com; envelope-from=przemyslaw.kitszel@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=ABuZUtxN
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD844400E0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Nov 2026 14:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793716813; x=1825252813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sf2AZv4R3O7A1UBWGxNLGhEG8TfjelAt/jjOrFDqMik=;
 b=ABuZUtxNPUiVEH5fBBtNgM6QtagdbUjuR2O12+zWu7eSyS5E10gfvOuR
 Mapo0wal30QHOlIsapZtSye0uHz8om2nvbVZ3pRfbOqYCGOW4evsveL/K
 6AwfByD8VtzE3P2el0jOeUAO7XcXfVgHFUb30JtNvW3+WBAlVSKS777oY
 Po4XZla5fxg2dsHM+eTPTxZTcQ1ziEPaVmAKftZqtlXrB0JgEavFz5npu
 Oj83kZ6AvW2K8FpwGTFhQrWo4fPe5s5KvAWwpkThMHEFJuna+8a7yVGzR
 cBwO7ct309ViFOSb7mDlRIWRXAcbSJ5Wcurf5N7Shp1klxhgbqGudNOos w==;
X-CSE-ConnectionGUID: 1NcPv/bHS6mCz4m6yj60cQ==
X-CSE-MsgGUID: Rgio+Eh2Tuav4esG/4k9XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2324138"
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="2324138"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 06:40:12 -0800
X-CSE-ConnectionGUID: vHhVCNzBQbe1fcmwm7xRyA==
X-CSE-MsgGUID: RUYJ+oWKQbWhv44MYmIWwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,193,1787036400"; 
   d="scan'208";a="8290046"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
 by fmviesa013.fm.intel.com with ESMTP; 03 Nov 2026 06:40:04 -0800
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
 by irvmail002.ir.intel.com (Postfix) with ESMTP id 4C266312E9;
 Tue,  3 Nov 2026 14:40:01 +0000 (GMT)
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
Subject: [PATCH iwl-next v4 13/15] ice: represent RSS LUTs as devlink resources
Date: Tue,  3 Nov 2026 15:14:54 +0100
Message-ID: <20261103141646.303620-14-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
References: <20261103141646.303620-1-przemyslaw.kitszel@intel.com>
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
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

E800 family offers three kinds of RSS LUTs: VSI LUT (sized 64), GLOBAL LUT
(sized 512), and PF LUT (sized 2048). Until now the GLOBAL kind was not
used at all. There are two possible usages for it, subsequent commit will
give VF option to acquire it, and this one enables PF to switch between PF
LUT and GLOBAL LUT - switching to smaller one is, again, to make it
possible for VF to then acquire the former one.

Devlink resources are used to let user show current usage and change the
allocation, see examples below.

Default state on 8-port card, asking for aggregate "whole device" usage,
note that there are as many PF LUTs as there is PFs, and, for e810, there
are 16 GLOBAL LUTs:
$ devlink resource show devlink_index/11
devlink_index/11:
  name rss size 8 unit entry size_min 0 size_max 24 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1 dpipe_tables none
      name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1 dpipe_tables none

Now let's add GLOBAL LUT for a single PF (on one-port NIC):
$ sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
And show it's resources after that:
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 2 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
Let's take the PF LUT out of that PF afterwards:
$ sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
now `ethtool -x $ifacename` will report smaller RSS table.

Changing the LUT of a PF resets its RSS indirection table to the default
spread, as the table size changes, and the ethtool core is told that
the user table is lost. The PF LUT change is done under rtnl, as
the ethtool core sizes its RSS buffers by the table size under rtnl.

FW drops RSS LUT assignments on reset, so the driver gives the PF its PF
LUT back after each reset, and logs when that discards a devlink change.
Changes are rejected with -EBUSY while a reset is in progress.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * take rtnl when devlink changes the RSS LUT of the PF, the new LUT is
   filled based on NETIF_F_RXHASH, which raced with ndo_set_features
   (Sashiko)
 * drop the -EAGAIN checks from get/set_rxfh, they broke ethtool -L after
   ethtool -X, and were hit after the hash function and key were already
   written (Sashiko); the PF RSS LUT size now changes only under rtnl,
   also on reset (me)
 * tell the ethtool core when the user RSS LUT is dropped, on devlink LUT
   change and on reset (Sashiko)
 * reject devlink RSS LUT changes while a reset is in progress, they
   could leak a global LUT (Sashiko)
 * log when a reset discards a devlink RSS LUT assignment (Sashiko)
 * keep the specific extack message and the real errno when a LUT change
   fails (Sashiko)
 * declare rel_err at function scope, a declaration right after a label
   does not build with GCC < 11 (Sashiko)
 * RDMA filter toggle: take the Q_OPT section from vsi->info under
   rss_lut_lock, the cached VSI context misses RSS LUT changes (Sashiko)
 * document the devlink resources in ice.rst (Sashiko)

v3:
 * don't free the user RSS LUT in ice_vsi_decfg(), it was done outside
   of pf->rss_lut_lock, and is redundant anyway: ice_vsi_cfg_def() frees
   it under the lock when the LUT size changes (Sashiko)
 * fill the new RSS LUT under rss_lut_lock (me)
 * keep PF RSS LUT zeroed on change when RXHASH is disabled (me)
 * restore default RSS LUT assignment of PF after reset, FW drops it
 * dual-NAC: each NAC numbers its PFs from 0, offset secondary NAC PFs by
   ICE_PORTS_PER_QUAD in the devlink resource table, reserve
   2 * ICE_PORTS_PER_QUAD PF LUT slots
 * dual-NAC: FW of each NAC numbers its global LUTs from 0, keep a separate
   global LUT table for the secondary NAC
 * register PF devlink resources only in the regular probe path, not in
   FW recovery mode, where pf->adapter is NULL
 * restore VF aggregator node accounting in ice_vsi_decfg(), removed by
   mistake (me)
 * drop PF RSS LUT ownership also in ice_deinit_pf(), ice_vsi_decfg()
   skips it after a NO_INIT VSI rebuild (me)
 * drop a stray debug change of the error message in ice_get_rss_lut()

v2:
 * replace -ENOANO with proper WARN_ON for "assumption error" (Alex)
 * fix goto label (Sashiko)
 * avoid queues being 0 in ADQ mode (Sashiko)
 * undo ice_take_rss_lut_pf() on error path (Sashiko)
 * program the PF VSI context with the new LUT type and global LUT ID
   after writing the LUT, so the PF really switches to the new table;
   publish the global LUT ID to the VSI only after a successful switch
 * drop the cached user RSS LUT when the RSS table size changes, on
   devlink LUT switch and on reset
 * use logical_pf_id for all PF bookkeeping of devlink resources, as the
   PF LUT resource is sized by the number of functions
 * warn when FW fails to free a global RSS LUT
 * add pf->rss_lut_lock to serialize devlink RSS LUT switch with
   ethtool -x/-X/-L, RXHASH toggle and VSI RSS config
 * return -EAGAIN from get/set_rxfh when the LUT was resized after
   the core sized the indirection table
 * reject ADQ when RSS LUTs are reassigned via devlink, and reject
   devlink RSS LUT changes when ADQ is configured (-EOPNOTSUPP)
 * remove trailing whitespace
 * commit message: GLOBAL LUT is sized 512, not 256

v4:
 * drop global RSS LUTs of the PF from the table already in
   ice_prepare_for_reset(), FW frees them on reset and could give them
   to other PFs before our rebuild cleaned the table, that hit the WARN
   in ice_devl_res_take() when LUT changes raced resets of other PFs
 * taking adapter devl there also waits for devlink RSS LUT changes that
   checked for a reset just before it was requested, they could still
   leak a global LUT (Sashiko)

v4:
 * use scoped_guard() instead of guard()

ice: represent RSS LUTs as devlink resources

E800 family offers three kinds of RSS LUTs: VSI LUT (sized 64), GLOBAL LUT
(sized 512), and PF LUT (sized 2048). Until now the GLOBAL kind was not
used at all. There are two possible usages for it, subsequent commit will
give VF option to acquire it, and this one enables PF to switch between PF
LUT and GLOBAL LUT - switching to smaller one is, again, to make it
possible for VF to then acquire the former one.

Devlink resources are used to let user show current usage and change the
allocation, see examples below.

Default state on 8-port card, asking for aggregate "whole device" usage,
note that there are as many PF LUTs as there is PFs, and, for e810, there
are 16 GLOBAL LUTs:
$ devlink resource show devlink_index/11
devlink_index/11:
  name rss size 8 unit entry size_min 0 size_max 24 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1 dpipe_tables none
      name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1 dpipe_tables none

Now let's add GLOBAL LUT for a single PF (on one-port NIC):
$ sudo devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
And show it's resources after that:
$ devlink resource show pci/0000:18:00.0
pci/0000:18:00.0:
  name rss size 2 unit entry size_min 0 size_max 2 size_gran 1 dpipe_tables none
    resources:
      name lut_512 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
      name lut_2048 size 1 unit entry size_min 0 size_max 1 size_gran 1 dpipe_tables none
Let's take the PF LUT out of that PF afterwards:
$ sudo devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
now `ethtool -x $ifacename` will report smaller RSS table.

Changing the LUT of a PF resets its RSS indirection table to the default
spread, as the table size changes, and the ethtool core is told that
the user table is lost. The PF LUT change is done under rtnl, as
the ethtool core sizes its RSS buffers by the table size under rtnl.

FW drops RSS LUT assignments on reset, so the driver gives the PF its PF
LUT back after each reset, and logs when that discards a devlink change.
Changes are rejected with -EBUSY while a reset is in progress.

Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
v4:
 * take rtnl when devlink changes the RSS LUT of the PF, the new LUT is
   filled based on NETIF_F_RXHASH, which raced with ndo_set_features
   (Sashiko)
 * drop the -EAGAIN checks from get/set_rxfh, they broke ethtool -L after
   ethtool -X, and were hit after the hash function and key were already
   written (Sashiko); the PF RSS LUT size now changes only under rtnl,
   also on reset (me)
 * tell the ethtool core when the user RSS LUT is dropped, on devlink LUT
   change and on reset (Sashiko)
 * reject devlink RSS LUT changes while a reset is in progress, they
   could leak a global LUT (Sashiko)
 * log when a reset discards a devlink RSS LUT assignment (Sashiko)
 * drop global RSS LUTs of the PF from the table already in
   ice_prepare_for_reset(), FW frees them on reset and could give them
   to other PFs before our rebuild cleaned the table, that hit the WARN
   in ice_devl_res_take() when LUT changes raced resets of other PFs (me)
 * taking adapter devl there also waits for devlink RSS LUT changes that
   checked for a reset just before it was requested, they could still
   leak a global LUT (Sashiko)
 * keep the specific extack message and the real errno when a LUT change
   fails (Sashiko)
 * declare rel_err at function scope, a declaration right after a label
   does not build with GCC < 11 and breaks sparse (Jakub)
 * RDMA filter toggle: take the Q_OPT section from vsi->info under
   rss_lut_lock, the cached VSI context misses RSS LUT changes (Sashiko)
 * document the devlink resources in ice.rst (Sashiko)

v3:
 * don't free the user RSS LUT in ice_vsi_decfg(), it was done outside
   of pf->rss_lut_lock, and is redundant anyway: ice_vsi_cfg_def() frees
   it under the lock when the LUT size changes (Sashiko)
 * fill the new RSS LUT under rss_lut_lock (me)
 * keep PF RSS LUT zeroed on change when RXHASH is disabled (me)
 * restore default RSS LUT assignment of PF after reset, FW drops it
 * dual-NAC: each NAC numbers its PFs from 0, offset secondary NAC PFs by
   ICE_PORTS_PER_QUAD in the devlink resource table, reserve
   2 * ICE_PORTS_PER_QUAD PF LUT slots
 * dual-NAC: FW of each NAC numbers its global LUTs from 0, keep a separate
   global LUT table for the secondary NAC
 * register PF devlink resources only in the regular probe path, not in
   FW recovery mode, where pf->adapter is NULL
 * restore VF aggregator node accounting in ice_vsi_decfg(), removed by
   mistake (me)
 * drop PF RSS LUT ownership also in ice_deinit_pf(), ice_vsi_decfg()
   skips it after a NO_INIT VSI rebuild (me)
 * drop a stray debug change of the error message in ice_get_rss_lut()

v2:
 * replace -ENOANO with proper WARN_ON for "assumption error" (Alex)
 * fix goto label (Sashiko)
 * avoid queues being 0 in ADQ mode (Sashiko)
 * undo ice_take_rss_lut_pf() on error path (Sashiko)
 * program the PF VSI context with the new LUT type and global LUT ID
   after writing the LUT, so the PF really switches to the new table;
   publish the global LUT ID to the VSI only after a successful switch
 * drop the cached user RSS LUT when the RSS table size changes, on
   devlink LUT switch and on reset
 * use logical_pf_id for all PF bookkeeping of devlink resources, as the
   PF LUT resource is sized by the number of functions
 * warn when FW fails to free a global RSS LUT
 * add pf->rss_lut_lock to serialize devlink RSS LUT switch with
   ethtool -x/-X/-L, RXHASH toggle and VSI RSS config
 * return -EAGAIN from get/set_rxfh when the LUT was resized after
   the core sized the indirection table
 * reject ADQ when RSS LUTs are reassigned via devlink, and reject
   devlink RSS LUT changes when ADQ is configured (-EOPNOTSUPP)
 * remove trailing whitespace
 * commit message: GLOBAL LUT is sized 512, not 256
---
 Documentation/networking/devlink/ice.rst      |  58 ++
 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../net/ethernet/intel/ice/devlink/resource.h |  25 +
 drivers/net/ethernet/intel/ice/ice.h          |   3 +-
 drivers/net/ethernet/intel/ice/ice_adapter.h  |  43 ++
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_lib.h      |   3 +
 drivers/net/ethernet/intel/ice/ice_switch.h   |   3 +-
 .../net/ethernet/intel/ice/devlink/resource.c | 662 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_adapter.c  |  19 +-
 drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  79 ++-
 drivers/net/ethernet/intel/ice/ice_idc.c      |  25 +-
 drivers/net/ethernet/intel/ice/ice_lib.c      | 115 ++-
 drivers/net/ethernet/intel/ice/ice_main.c     |  27 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   |  11 +-
 16 files changed, 998 insertions(+), 79 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/resource.c

diff --git a/Documentation/networking/devlink/ice.rst b/Documentation/networking/devlink/ice.rst
index 792e9f8c846a..6e34c107b28d 100644
--- a/Documentation/networking/devlink/ice.rst
+++ b/Documentation/networking/devlink/ice.rst
@@ -485,3 +485,61 @@ and arbitration among them is based on assigned weights.
 
     # assign tx_share to the VF
     $ devlink port function rate set pci/0000:4b:00.0/2 tx_share 500Mbps
+
+Resources
+=========
+
+The ``ice`` driver exposes the RSS lookup tables (LUTs) of the device as
+devlink resources. E800 devices have three kinds of RSS LUTs: a VSI LUT
+(64 entries) for each VSI, 16 global LUTs (512 entries) for each NAC of the
+device, and a PF LUT (2048 entries) for each PF. By default each PF uses its
+PF LUT.
+
+.. list-table:: Resources implemented
+    :widths: 15 85
+
+    * - Name
+      - Description
+    * - ``rss``
+      - The sum of its children, read-only.
+    * - ``rss/lut_512``
+      - The number of global LUTs owned.
+    * - ``rss/lut_2048``
+      - The number of PF LUTs owned.
+
+The resources are registered on two kinds of devlink instances:
+
+- The devlink instance of each PF, where ``lut_512`` and ``lut_2048`` are
+  either 0 or 1. They are changed with ``devlink resource set``, and the
+  change applies immediately.
+- The whole device devlink instance, shared by all PFs of the device, which
+  reports the total usage. Its resources are read-only, setting them fails
+  with ``EPERM``.
+
+A PF must own at least one of the two LUTs at all times, so switching a PF
+to a global LUT takes two steps: take a global LUT, then release the PF LUT.
+A PF that owns both uses its PF LUT.
+
+Changing the LUT of a PF resets its RSS indirection table to the default
+spread, a table set with ``ethtool -X`` is lost.
+
+RSS LUTs can't be changed while ADQ is configured, and ADQ can't be
+configured while the RSS LUTs of the PF are reassigned.
+
+Firmware drops the LUT assignments on reset (PFR, CORER or GLOBR). The
+driver then restores the default assignment, and logs that it did so.
+Changes are rejected with ``EBUSY`` while a reset is in progress.
+
+.. code:: shell
+
+    # whole device usage on an 8-port card
+    $ devlink resource show devlink_index/11
+    devlink_index/11:
+      name rss size 8 unit entry size_min 0 size_max 24 size_gran 1 dpipe_tables none
+        resources:
+          name lut_512 size 0 unit entry size_min 0 size_max 16 size_gran 1 dpipe_tables none
+          name lut_2048 size 8 unit entry size_min 0 size_max 8 size_gran 1 dpipe_tables none
+
+    # switch a PF to a global LUT
+    $ devlink resource set pci/0000:18:00.0 path rss/lut_512 size 1
+    $ devlink resource set pci/0000:18:00.0 path rss/lut_2048 size 0
diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
index a952bacb7ec7..e50e02efbf7a 100644
--- a/drivers/net/ethernet/intel/ice/Makefile
+++ b/drivers/net/ethernet/intel/ice/Makefile
@@ -34,6 +34,7 @@ ice-y := ice_main.o	\
 	 devlink/devlink.o	\
 	 devlink/health.o \
 	 devlink/port.o \
+	 devlink/resource.o \
 	 ice_sf_eth.o	\
 	 ice_sf_vsi_vlan_ops.o \
 	 ice_ddp.o	\
diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.h b/drivers/net/ethernet/intel/ice/devlink/resource.h
new file mode 100644
index 000000000000..a41bda0ff6c8
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/resource.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/* Copyright (c) 2026, Intel Corporation. */
+
+#ifndef _ICE_DEVL_RESOURCE_H_
+#define _ICE_DEVL_RESOURCE_H_
+
+#include <linux/types.h>
+
+struct devlink;
+struct ice_adapter;
+struct ice_hw;
+struct ice_pf;
+
+void ice_devl_pf_resources_register(struct ice_pf *pf);
+void ice_devl_whole_dev_resources_register(const struct ice_hw *hw,
+					   struct ice_adapter *adapter);
+
+bool ice_rss_lut_is_reassigned(struct ice_pf *pf);
+int ice_take_rss_lut_pf(struct ice_pf *pf);
+void ice_release_rss_lut_pf(struct ice_pf *pf);
+void ice_prepare_rss_luts_for_reset(struct ice_pf *pf);
+int ice_rebuild_rss_luts(struct ice_pf *pf);
+void ice_free_rss_lut_flr(struct ice_pf *pf);
+
+#endif /* _ICE_DEVL_RESOURCE_H_ */
diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 89a2bdbecf60..85e154a66420 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -596,6 +596,7 @@ struct ice_pf {
 	struct mutex tc_mutex;		/* lock to protect TC changes */
 	struct mutex adev_mutex;	/* lock to protect aux device access */
 	struct mutex lag_mutex;		/* protect ice_lag struct in PF */
+	struct mutex rss_lut_lock;	/* protect VSI RSS LUT config */
 	u32 msg_enable;
 	struct ice_ptp ptp;
 	struct gnss_serial *gnss_serial;
@@ -1113,7 +1114,7 @@ extern const struct xdp_metadata_ops ice_xdp_md_ops;
  * Acceleration Complex) configuration variant, false otherwise
  * (always false for non-E825 devices).
  */
-static inline bool ice_is_dual(struct ice_hw *hw)
+static inline bool ice_is_dual(const struct ice_hw *hw)
 {
 	return hw->mac_type == ICE_MAC_GENERIC_3K_E825 &&
 	       (hw->dev_caps.nac_topo.mode & ICE_NAC_TOPO_DUAL_M);
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
index cdad45e8e81b..c243c896649c 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.h
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
@@ -16,6 +16,40 @@
 struct pci_dev;
 struct ice_pf;
 
+enum ice_devl_resource_id {
+	/* keep parent IDs prior to children, because we register in order */
+	ICE_TOP_RESOURCE = DEVLINK_RESOURCE_ID_PARENT_TOP,
+	ICE_RSS_LUT_BOTH,
+	ICE_RSS_LUT_GLOBAL,
+	ICE_RSS_LUT_PF,
+	ICE_DEVL_RESOURCES_COUNT
+};
+
+#define ICE_MAX_DEVL_RESOURCE_UNITS 16
+
+/**
+ * struct ice_devl_resource - driver data for devlink resource, config & runtime
+ *
+ * @owner: entity that owns given resource (like ptr to ice_pf or ice_vf)
+ * @pf_id: on which PF the VF is (or just PF id when PF is the owner)
+ * @name: name of the resource to register it with
+ * @get: occ getter callback
+ * @set: occ setter callback
+ * @start_size: starting size of the resource
+ * @max_size: max size of the resource, to present in the uAPI/validate against
+ * @parent_id: ID of the parent resource
+ */
+struct ice_devl_resource {
+	void *owner[ICE_MAX_DEVL_RESOURCE_UNITS];
+	u8 pf_id[ICE_MAX_DEVL_RESOURCE_UNITS];
+	const char *name;
+	devlink_resource_occ_get_t *get;
+	devlink_resource_occ_set_t *set;
+	u32 start_size;
+	u32 max_size;
+	u32 parent_id;
+};
+
 /**
  * struct ice_port_list - data used to store the list of adapter ports
  *
@@ -44,6 +78,9 @@ struct ice_port_list {
  *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
  * @ctrl_pf: Control PF of the adapter
  * @ports: Ports list
+ * @resources: array of ice's data for devlink resources
+ * @sec_nac_global_luts: global RSS LUTs of the secondary NAC, its FW numbers
+ *			 them from 0 too
  */
 struct ice_adapter {
 	struct devlink *devlink;
@@ -57,9 +94,15 @@ struct ice_adapter {
 
 	struct ice_pf *ctrl_pf;
 	struct ice_port_list ports;
+
+	struct ice_devl_resource resources[ICE_DEVL_RESOURCES_COUNT];
+	struct ice_devl_resource sec_nac_global_luts;
 };
 
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev);
 void ice_adapter_put(struct ice_adapter *adapter);
 
+DEFINE_GUARD(ice_adapter_devl, struct ice_adapter *,
+	     devl_lock((_T)->devlink), devl_unlock((_T)->devlink))
+
 #endif /* _ICE_ADAPTER_H */
diff --git a/drivers/net/ethernet/intel/ice/ice_common.h b/drivers/net/ethernet/intel/ice/ice_common.h
index d1d674ca644f..d019ec759eda 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.h
+++ b/drivers/net/ethernet/intel/ice/ice_common.h
@@ -125,6 +125,7 @@ int ice_read_txq_ctx(struct ice_hw *hw, struct ice_tlan_ctx *tlan_ctx,
 int ice_write_txq_ctx(struct ice_hw *hw, struct ice_tlan_ctx *tlan_ctx,
 		      u32 txq_index);
 
+enum ice_lut_size ice_lut_type_to_size(enum ice_lut_type type);
 int
 ice_aq_get_rss_lut(struct ice_hw *hw, struct ice_aq_get_set_rss_lut_params *get_params);
 int
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index 49454d98dcfe..15b65a757beb 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -47,6 +47,9 @@ int ice_vsi_cfg_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi);
 
+int ice_vsi_update_rss_lut(struct ice_vsi *vsi, enum ice_lut_type lut_type,
+			   u8 global_lut_id);
+
 void ice_vsi_cfg_netdev_tc(struct ice_vsi *vsi, u8 ena_tc);
 
 struct ice_vsi *
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.h b/drivers/net/ethernet/intel/ice/ice_switch.h
index 99b593b68bd0..991b61b0d26a 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.h
+++ b/drivers/net/ethernet/intel/ice/ice_switch.h
@@ -361,7 +361,8 @@ int ice_remove_mac(struct ice_hw *hw, struct list_head *m_lst);
 bool ice_vlan_fltr_exist(struct ice_hw *hw, u16 vlan_id, u16 vsi_handle);
 int ice_add_eth_mac(struct ice_hw *hw, struct list_head *em_list);
 int ice_remove_eth_mac(struct ice_hw *hw, struct list_head *em_list);
-int ice_cfg_rdma_fltr(struct ice_hw *hw, u16 vsi_handle, bool enable);
+int ice_cfg_rdma_fltr(struct ice_hw *hw, u16 vsi_handle,
+		      const struct ice_aqc_vsi_props *info, bool enable);
 void ice_remove_vsi_fltr(struct ice_hw *hw, u16 vsi_handle);
 
 /* Promisc/defport setup for VSIs */
diff --git a/drivers/net/ethernet/intel/ice/devlink/resource.c b/drivers/net/ethernet/intel/ice/devlink/resource.c
new file mode 100644
index 000000000000..b0b2b1adae0c
--- /dev/null
+++ b/drivers/net/ethernet/intel/ice/devlink/resource.c
@@ -0,0 +1,662 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2026, Intel Corporation. */
+
+#include "resource.h"
+#include "ice_adapter.h"
+#include "ice.h"
+#include "ice_lib.h"
+
+#define ICE_NUM_GLOBAL_LUTS	16
+#define ICE_ANY_SLOT		-1
+
+/* each NAC numbers its PFs from 0, secondary NAC ones go after primary ones */
+static int ice_devl_pf_id(struct ice_pf *pf)
+{
+	struct ice_hw *hw = &pf->hw;
+
+	if (ice_is_primary(hw))
+		return hw->logical_pf_id;
+
+	return hw->logical_pf_id + ICE_PORTS_PER_QUAD;
+}
+
+/* each NAC has its own global LUTs, with IDs given by its FW */
+static struct ice_devl_resource *
+ice_devl_res_tbl(struct ice_pf *pf, enum ice_devl_resource_id res_id)
+{
+	if (res_id == ICE_RSS_LUT_GLOBAL && !ice_is_primary(&pf->hw))
+		return &pf->adapter->sec_nac_global_luts;
+
+	return &pf->adapter->resources[res_id];
+}
+
+static u32 ice_devl_res_cnt(const struct ice_devl_resource *res)
+{
+	u32 sum = 0;
+
+	for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
+		sum += res->owner[i] != NULL;
+
+	return sum;
+}
+
+static int ice_devl_res_take(struct ice_pf *pf,
+			     enum ice_devl_resource_id res_id, int slot,
+			     void *owner)
+{
+	struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
+	int beg, end, new_id = ICE_ANY_SLOT;
+	u16 lut_id;
+
+	if (res_id == ICE_RSS_LUT_GLOBAL) {
+		int err;
+
+		WARN_ON_ONCE(slot != ICE_ANY_SLOT);
+
+		err = ice_alloc_rss_global_lut(&pf->hw, &lut_id);
+		if (err)
+			return err;
+
+		slot = lut_id;
+	}
+
+	end = slot == ICE_ANY_SLOT ? ARRAY_SIZE(res->owner) : slot + 1;
+	beg = slot == ICE_ANY_SLOT ? 0 : slot;
+	for (int id = beg; id < end; id++) {
+		if (!res->owner[id]) {
+			new_id = id;
+			break;
+		}
+	}
+	if (new_id == ICE_ANY_SLOT) {
+		if (WARN_ON(res_id == ICE_RSS_LUT_GLOBAL))
+			ice_free_rss_global_lut(&pf->hw, lut_id);
+
+		return -ENOSPC;
+	}
+
+	res->owner[new_id] = owner;
+	res->pf_id[new_id] = ice_devl_pf_id(pf);
+	return new_id;
+}
+
+static int ice_devl_res_free(struct ice_pf *pf,
+			     enum ice_devl_resource_id res_id, void *owner)
+{
+	struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
+	int err = 0, id_to_free = ICE_ANY_SLOT;
+
+	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
+		if (res->owner[i] == owner) {
+			id_to_free = i;
+			break;
+		}
+	}
+	if (id_to_free == ICE_ANY_SLOT)
+		return 0;
+
+	if (res_id == ICE_RSS_LUT_GLOBAL) {
+		err = ice_free_rss_global_lut(&pf->hw, id_to_free);
+		if (err)
+			dev_warn(ice_pf_to_dev(pf), "failed to free global RSS LUT %d, leaked until PF reset: %d\n",
+				 id_to_free, err);
+	}
+
+	res->owner[id_to_free] = NULL;
+	return err;
+}
+
+static void ice_free_rss_lut_flr_locked(struct ice_pf *pf)
+{
+	struct ice_devl_resource *res, *resources = pf->adapter->resources;
+	int pf_id = ice_devl_pf_id(pf);
+
+	devl_assert_locked(pf->adapter->devlink);
+	resources[ICE_RSS_LUT_PF].owner[pf_id] = NULL;
+
+	res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
+	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
+		/* On FLR/PFR resources assigned to PF are cleared by FW,
+		 * reflect that in the SW table.
+		 * VFs on given PF must be de-programmed too.
+		 */
+		if (res->pf_id[i] == pf_id)
+			res->owner[i] = NULL;
+	}
+}
+
+void ice_free_rss_lut_flr(struct ice_pf *pf)
+{
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		ice_free_rss_lut_flr_locked(pf);
+}
+
+static int ice_devl_res_owned_idx(struct ice_pf *pf,
+				  enum ice_devl_resource_id res_id, void *owner)
+{
+	const struct ice_devl_resource *res = ice_devl_res_tbl(pf, res_id);
+
+	for (int i = 0; i < ARRAY_SIZE(res->owner); i++) {
+		if (res->owner[i] == owner)
+			return i;
+	}
+
+	return -ENXIO;
+}
+
+static bool ice_is_devl_res_owned_by(struct ice_pf *pf,
+				     enum ice_devl_resource_id res_id,
+				     void *owner)
+{
+	return ice_devl_res_owned_idx(pf, res_id, owner) >= 0;
+}
+
+static u64 ice_rss_lut_whole_dev_occ_get_global(void *priv)
+{
+	struct ice_adapter *adapter = priv;
+
+	return ice_devl_res_cnt(&adapter->resources[ICE_RSS_LUT_GLOBAL]) +
+	       ice_devl_res_cnt(&adapter->sec_nac_global_luts);
+}
+
+static u64 ice_rss_lut_whole_dev_occ_get_pf(void *priv)
+{
+	struct ice_adapter *adapter = priv;
+
+	return ice_devl_res_cnt(&adapter->resources[ICE_RSS_LUT_PF]);
+}
+
+static u64 ice_rss_lut_whole_dev_occ_get_both(void *priv)
+{
+	return ice_rss_lut_whole_dev_occ_get_global(priv) +
+	       ice_rss_lut_whole_dev_occ_get_pf(priv);
+}
+
+static u64 ice_rss_lut_pf_occ_get_global(void *priv)
+{
+	struct ice_pf *pf = priv;
+
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, pf);
+}
+
+static u64 ice_rss_lut_pf_occ_get_pf(void *priv)
+{
+	struct ice_pf *pf = priv;
+
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, pf);
+}
+
+static u64 ice_rss_lut_pf_occ_get_both(void *priv)
+{
+	struct ice_pf *pf = priv;
+
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		return ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, pf) +
+		       ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, pf);
+}
+
+static int ice_devl_resource_deny_occ_set(u64 size,
+					  struct netlink_ext_ack *extack,
+					  void *priv)
+{
+	NL_SET_ERR_MSG_MOD(extack,
+		"can not change directly, parent/aggregate resource just adds up children data");
+	return -EPERM;
+}
+
+enum ice_rss_lut_resource_state {
+	ICE_HAS_NO_LUT = 0,
+	ICE_HAS_GLOBAL_LUT = BIT(ICE_RSS_LUT_GLOBAL),
+	ICE_HAS_PF_LUT = BIT(ICE_RSS_LUT_PF),
+	ICE_HAS_BOTH_LUTS = ICE_HAS_GLOBAL_LUT | ICE_HAS_PF_LUT,
+};
+
+/** ice_rss_lut_resource_state - compute opaque resource state for given owner
+ * @pf: the PF the @owner is on
+ * @owner: the entity to compute state of resources for
+ *
+ * Return: computed current state of the RSS resources the @owner has.
+ */
+static enum ice_rss_lut_resource_state
+ice_rss_lut_resource_state(struct ice_pf *pf, void *owner)
+{
+	enum ice_rss_lut_resource_state ret = ICE_HAS_NO_LUT;
+
+	if (ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_GLOBAL, owner))
+		ret |= ICE_HAS_GLOBAL_LUT;
+	if (ice_is_devl_res_owned_by(pf, ICE_RSS_LUT_PF, owner))
+		ret |= ICE_HAS_PF_LUT;
+
+	return ret;
+}
+
+static int ice_maybe_change_rss_lut(struct ice_pf *pf, void *owner,
+				    enum ice_rss_lut_resource_state old,
+				    enum ice_rss_lut_resource_state new,
+				    struct netlink_ext_ack *extack)
+{
+	struct ice_aq_get_set_rss_lut_params params = {};
+	struct ice_hw *hw = &pf->hw;
+	enum ice_lut_type lut_type;
+	int err, lut_size, lut_id;
+	struct ice_vsi *vsi;
+	u8 *lut;
+
+	if (old & new & ICE_HAS_PF_LUT)
+		return 0;
+
+	if (new & ICE_HAS_PF_LUT) {
+		lut_type = ICE_LUT_PF;
+	} else if (new & ICE_HAS_GLOBAL_LUT) {
+		lut_id = ice_devl_res_owned_idx(pf, ICE_RSS_LUT_GLOBAL, owner);
+		if (lut_id < 0)
+			return lut_id;
+
+		lut_type = ICE_LUT_GLOBAL;
+		params.global_lut_id = lut_id;
+	} else {
+		lut_type = ICE_LUT_VSI;
+		if (owner == pf) {
+			NL_SET_ERR_MSG_FMT(extack, "cannot change PF to use LUT_VSI (sized 64)");
+			return -EDOM;
+		}
+	}
+
+	if (pf == owner) {
+		vsi = ice_get_main_vsi(pf);
+	} else {
+		return -EOPNOTSUPP;
+	}
+
+	lut_size = ice_lut_type_to_size(lut_type);
+	lut = kzalloc(lut_size, GFP_KERNEL);
+	if (!lut)
+		return -ENOMEM;
+	params.lut = lut;
+	params.lut_size = lut_size;
+	params.lut_type = lut_type;
+	params.vsi_handle = vsi->idx;
+	mutex_lock(&pf->rss_lut_lock);
+	/* PF with RXHASH disabled keeps its LUT zeroed */
+	if (!vsi->netdev || vsi->netdev->features & NETIF_F_RXHASH)
+		ice_fill_rss_lut(lut, lut_size, vsi->rss_size);
+	err = ice_aq_set_rss_lut(hw, &params);
+	if (err) {
+		NL_SET_ERR_MSG_FMT(extack, "AQ failed: %s", libie_aq_str(hw->adminq.sq_last_status));
+		goto out;
+	}
+
+	err = ice_vsi_update_rss_lut(vsi, lut_type, params.global_lut_id);
+	if (err)
+		goto out;
+
+	devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
+	vsi->rss_lut_user = NULL;
+	if (lut_type == ICE_LUT_GLOBAL)
+		vsi->global_lut_id = params.global_lut_id;
+	vsi->rss_table_size = lut_size;
+	vsi->rss_lut_type = lut_type;
+out:
+	mutex_unlock(&pf->rss_lut_lock);
+	kfree(lut);
+	/* the user RSS LUT was dropped above, rtnl is held for the PF */
+	if (!err && vsi->netdev && netif_is_rxfh_configured(vsi->netdev))
+		ethtool_rxfh_indir_lost(vsi->netdev);
+	return err;
+}
+
+static int ice_devl_res_change(bool take, enum ice_devl_resource_id res_id,
+			       struct ice_pf *pf, void *owner, int slot,
+			       struct netlink_ext_ack *extack)
+{
+	enum ice_rss_lut_resource_state old, new, change;
+	int err, rel_err;
+
+	change = BIT(res_id);
+	old = ice_rss_lut_resource_state(pf, owner);
+	new = old;
+	if (take)
+		new |= change;
+	else
+		new &= ~change;
+	if (new == old)
+		return 0;
+
+	/* reset rebuilds the table and the VSIs, see ice_rebuild_rss_luts(),
+	 * pairs with adapter devl taken in ice_prepare_rss_luts_for_reset()
+	 */
+	if (ice_is_reset_in_progress(pf->state)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "reset in progress, try again later");
+		return -EBUSY;
+	}
+
+	/* pairs with set_bit() under adapter devl in ice_setup_tc_mqprio_qdisc() */
+	if (test_bit(ICE_FLAG_TC_MQPRIO, pf->flags)) {
+		NL_SET_ERR_MSG_MOD(extack, "ADQ configured, can't change RSS LUTs");
+		return -EOPNOTSUPP;
+	}
+
+	if (pf == owner && !take && old != ICE_HAS_BOTH_LUTS) {
+		NL_SET_ERR_MSG_MOD(extack,
+			"at least one of 512+ sized LUTs must be assigned to PF device at all times");
+		return -EDOM;
+	}
+
+	if (take) {
+		int slot_id;
+
+		slot_id = ice_devl_res_take(pf, res_id, slot, owner);
+		if (slot_id < 0)
+			return slot_id;
+	}
+
+	err = ice_maybe_change_rss_lut(pf, owner, old, new, extack);
+	if (err) {
+		NL_SET_ERR_MSG_WEAK_MOD(extack, "failed to change RSS LUT");
+		if (!take)
+			/* We have not released the resource, so we don't free
+			 * it, to avoid freeing LUT still in use or assigning it
+			 * to other entity.
+			 */
+			return err;
+
+		goto undo_res_take;
+	}
+
+	if (!take) {
+undo_res_take:
+		rel_err = ice_devl_res_free(pf, res_id, owner);
+		if (rel_err) {
+			NL_SET_ERR_MSG_FMT(extack,
+				"could not free resource, err: %d", rel_err);
+			if (!err)
+				err = rel_err;
+		}
+	}
+
+	return err;
+}
+
+/* ethtool core sizes RSS buffers by rss_table_size under rtnl, and the new
+ * LUT is filled based on NETIF_F_RXHASH, which is also changed under rtnl
+ */
+static int ice_rss_lut_pf_occ_set(u64 size, enum ice_devl_resource_id res_id,
+				  struct ice_pf *pf, int slot,
+				  struct netlink_ext_ack *extack)
+{
+	int err;
+
+	rtnl_lock();
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		err = ice_devl_res_change(size, res_id, pf, pf, slot, extack);
+	rtnl_unlock();
+
+	return err;
+}
+
+static int ice_rss_lut_pf_occ_set_pf(u64 size, struct netlink_ext_ack *extack,
+				     void *priv)
+{
+	struct ice_pf *pf = priv;
+
+	return ice_rss_lut_pf_occ_set(size, ICE_RSS_LUT_PF, pf,
+				      ice_devl_pf_id(pf), extack);
+}
+
+static int ice_rss_lut_pf_occ_set_global(u64 size,
+					 struct netlink_ext_ack *extack,
+					 void *priv)
+{
+	return ice_rss_lut_pf_occ_set(size, ICE_RSS_LUT_GLOBAL, priv,
+				      ICE_ANY_SLOT, extack);
+}
+
+/**
+ * ice_rss_lut_is_reassigned - check if RSS LUTs of PF are in non-default state
+ * @pf: the PF to check
+ *
+ * Return: true if @pf lost its PF LUT, or @pf or any of its VFs owns a
+ * global LUT. Caller must hold the adapter devlink lock.
+ */
+bool ice_rss_lut_is_reassigned(struct ice_pf *pf)
+{
+	struct ice_devl_resource *res, *resources = pf->adapter->resources;
+	int pf_id = ice_devl_pf_id(pf);
+
+	devl_assert_locked(pf->adapter->devlink);
+	if (resources[ICE_RSS_LUT_PF].owner[pf_id] != pf)
+		return true;
+
+	res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
+	for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
+		if (res->owner[i] && res->pf_id[i] == pf_id)
+			return true;
+
+	return false;
+}
+
+/**
+ * ice_take_rss_lut_pf - allocate PF RSS LUT for PF
+ * @pf: the PF device that PF LUT is physically on, and to allocate it for
+ *
+ * Acquire PF RSS LUT for the caller.
+ *
+ * Return: 0 on success, negative on error.
+ */
+int ice_take_rss_lut_pf(struct ice_pf *pf)
+{
+	int ret, pf_id = ice_devl_pf_id(pf);
+
+	scoped_guard(ice_adapter_devl, pf->adapter) {
+		ret = ice_devl_res_take(pf, ICE_RSS_LUT_PF, pf_id, pf);
+		if (ret >= 0)
+			return 0;
+
+		return ret;
+	}
+}
+
+/**
+ * ice_release_rss_lut_pf - release PF RSS LUT of PF
+ * @pf: the PF device that PF LUT is physically on, and to release it from
+ *
+ * Release PF RSS LUT for the caller.
+ *
+ * No need to call this function in normal operation, provided for error path.
+ */
+void ice_release_rss_lut_pf(struct ice_pf *pf)
+{
+	scoped_guard(ice_adapter_devl, pf->adapter)
+		ice_devl_res_free(pf, ICE_RSS_LUT_PF, pf);
+}
+
+/**
+ * ice_prepare_rss_luts_for_reset - drop global RSS LUTs of PF from the table
+ * @pf: the PF that is about to be reset
+ *
+ * FW frees global RSS LUTs of the PF and its VFs on reset, and other PFs may
+ * get them from FW before ice_rebuild_rss_luts() of @pf, so drop them from
+ * the table now. Taking the lock also waits for RSS LUT changes that checked
+ * for reset just before it was requested.
+ */
+void ice_prepare_rss_luts_for_reset(struct ice_pf *pf)
+{
+	int pf_id = ice_devl_pf_id(pf);
+	struct ice_devl_resource *res;
+
+	scoped_guard(ice_adapter_devl, pf->adapter) {
+		if (ice_rss_lut_is_reassigned(pf))
+			dev_info(ice_pf_to_dev(pf),
+				 "reset restores the default RSS LUT assignment\n");
+
+		res = ice_devl_res_tbl(pf, ICE_RSS_LUT_GLOBAL);
+		for (int i = 0; i < ARRAY_SIZE(res->owner); i++)
+			if (res->pf_id[i] == pf_id)
+				res->owner[i] = NULL;
+	}
+}
+
+/**
+ * ice_rebuild_rss_lut_pf - restore default RSS LUT assignment after reset
+ * @pf: the PF that was reset
+ *
+ * FW drops RSS LUT assignments of the PF on reset, so give the PF LUT back to
+ * the PF, and make the PF VSI use it.
+ * Must be called before the VSIs are rebuilt.
+ *
+ * Return: 0 on success, negative on error.
+ */
+static int ice_rebuild_rss_lut_pf(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	struct ice_adapter *adapter = pf->adapter;
+	int err;
+
+	devl_lock(adapter->devlink);
+	ice_free_rss_lut_flr_locked(pf);
+	err = ice_devl_res_take(pf, ICE_RSS_LUT_PF, ice_devl_pf_id(pf), pf);
+	if (err < 0)
+		goto unlock;
+
+	mutex_lock(&pf->rss_lut_lock);
+	if (vsi && vsi->rss_lut_type != ICE_LUT_PF) {
+		devm_kfree(ice_pf_to_dev(pf), vsi->rss_lut_user);
+		vsi->rss_lut_user = NULL;
+		vsi->rss_table_size = ice_lut_type_to_size(ICE_LUT_PF);
+		vsi->rss_lut_type = ICE_LUT_PF;
+	}
+	mutex_unlock(&pf->rss_lut_lock);
+	err = 0;
+unlock:
+	devl_unlock(adapter->devlink);
+
+	return err;
+}
+
+/**
+ * ice_rebuild_rss_luts - restore default RSS LUT assignment after reset
+ * @pf: the PF that was reset
+ *
+ * Wrapper of ice_rebuild_rss_lut_pf() that also tells the ethtool core when
+ * the user RSS LUT was dropped. Must be called without rtnl held.
+ *
+ * Return: 0 on success, negative on error.
+ */
+int ice_rebuild_rss_luts(struct ice_pf *pf)
+{
+	struct ice_vsi *vsi = ice_get_main_vsi(pf);
+	int err;
+
+	/* ethtool core sizes RSS buffers by rss_table_size under rtnl */
+	rtnl_lock();
+	err = ice_rebuild_rss_lut_pf(pf);
+	/* the user RSS LUT is dropped when the PF goes back to the PF LUT */
+	if (vsi && vsi->netdev && !vsi->rss_lut_user &&
+	    netif_is_rxfh_configured(vsi->netdev))
+		ethtool_rxfh_indir_lost(vsi->netdev);
+	rtnl_unlock();
+
+	return err;
+}
+
+static void ice_devl_res_register(struct devlink *devlink,
+				  struct ice_devl_resource *resources,
+				  void *occ_priv)
+{
+	struct devlink_resource_size_params size_params;
+
+	devlink_resource_size_params_init(&size_params, 0, 0, 1,
+					  DEVLINK_RESOURCE_UNIT_ENTRY);
+	for (int i = 0; i < ICE_DEVL_RESOURCES_COUNT; i++) {
+		struct ice_devl_resource *res = &resources[i];
+		int err, resource_id = i;
+
+		if (!res->name)
+			continue; /* skip empty entries in config table */
+
+		size_params.size_max = res->max_size;
+		err = devl_resource_register(devlink, res->name,
+					     res->start_size, resource_id,
+					     res->parent_id, &size_params);
+		if (WARN_ONCE(err, "not all resource handlers registered, err: %d, resname: %s\n",
+			      err, res->name))
+			break;
+
+		devl_resource_occ_set_get_register(devlink, resource_id,
+						   res->set, res->get, occ_priv);
+	}
+}
+
+void ice_devl_whole_dev_resources_register(const struct ice_hw *hw,
+					   struct ice_adapter *adapter)
+{
+	struct devlink *devlink = adapter->devlink;
+	int global_lut_cnt = ICE_NUM_GLOBAL_LUTS;
+	int pf_lut_cnt = hw->dev_caps.num_funcs;
+
+	devl_assert_locked(devlink);
+	/* see ice_devl_pf_id() and ice_devl_res_tbl() */
+	if (ice_is_dual(hw)) {
+		global_lut_cnt = 2 * ICE_NUM_GLOBAL_LUTS;
+		pf_lut_cnt = 2 * ICE_PORTS_PER_QUAD;
+	}
+
+	adapter->resources[ICE_RSS_LUT_GLOBAL] = (struct ice_devl_resource) {
+		.name = "lut_512",
+		.parent_id = ICE_RSS_LUT_BOTH,
+		.max_size = global_lut_cnt,
+		.get = ice_rss_lut_whole_dev_occ_get_global,
+		.set = ice_devl_resource_deny_occ_set,
+	};
+	adapter->resources[ICE_RSS_LUT_PF] = (struct ice_devl_resource) {
+		.name = "lut_2048",
+		.parent_id = ICE_RSS_LUT_BOTH,
+		.max_size = pf_lut_cnt,
+		.get = ice_rss_lut_whole_dev_occ_get_pf,
+		.set = ice_devl_resource_deny_occ_set,
+	};
+	adapter->resources[ICE_RSS_LUT_BOTH] = (struct ice_devl_resource) {
+		.name = "rss",
+		.parent_id = ICE_TOP_RESOURCE,
+		.max_size = pf_lut_cnt + global_lut_cnt,
+		.get = ice_rss_lut_whole_dev_occ_get_both,
+		.set = ice_devl_resource_deny_occ_set,
+	};
+
+	ice_devl_res_register(devlink, adapter->resources, adapter);
+}
+
+void ice_devl_pf_resources_register(struct ice_pf *pf)
+{
+	struct ice_devl_resource pf_resources[ICE_DEVL_RESOURCES_COUNT] = {
+		[ICE_RSS_LUT_GLOBAL] = {
+			.name = "lut_512",
+			.parent_id = ICE_RSS_LUT_BOTH,
+			.max_size = 1,
+			.get = ice_rss_lut_pf_occ_get_global,
+			.set = ice_rss_lut_pf_occ_set_global,
+		},
+		[ICE_RSS_LUT_PF] = {
+			.name = "lut_2048",
+			.parent_id = ICE_RSS_LUT_BOTH,
+			.max_size = 1,
+			.get = ice_rss_lut_pf_occ_get_pf,
+			.set = ice_rss_lut_pf_occ_set_pf,
+			.start_size = 1,
+		},
+		[ICE_RSS_LUT_BOTH] = {
+			.name = "rss",
+			.parent_id = ICE_TOP_RESOURCE,
+			.max_size = 2,
+			.get = ice_rss_lut_pf_occ_get_both,
+			.set = ice_devl_resource_deny_occ_set,
+		},
+	};
+	struct devlink *devlink = priv_to_devlink(pf);
+
+	devl_assert_locked(devlink);
+	ice_devl_res_register(devlink, pf_resources, pf);
+}
diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c b/drivers/net/ethernet/intel/ice/ice_adapter.c
index 0cdb13e7bd89..ce0b7ebf0c30 100644
--- a/drivers/net/ethernet/intel/ice/ice_adapter.c
+++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
@@ -9,6 +9,8 @@
 #include "ice_adapter.h"
 #include "ice.h"
 
+#include "devlink/resource.h"
+
 #define ICE_ADAPTER_FIXED_INDEX	BIT_ULL(63)
 
 #define ICE_ADAPTER_INDEX_E825C	\
@@ -38,8 +40,10 @@ static u64 ice_adapter_index(struct pci_dev *pdev)
 
 static int ice_adapter_init(void *priv, void *init_param)
 {
+	const struct ice_hw *hw = init_param;
 	struct ice_adapter *adapter = priv;
 	struct devlink *devlink;
+	int err;
 
 	devlink = shd_priv_to_devlink(adapter);
 	adapter->devlink = devlink;
@@ -52,12 +56,22 @@ static int ice_adapter_init(void *priv, void *init_param)
 	spin_lock_init(&adapter->ports.lock);
 	INIT_LIST_HEAD(&adapter->ports.list);
 
-	return init_srcu_struct(&adapter->ports.srcu);
+	err = init_srcu_struct(&adapter->ports.srcu);
+	if (err)
+		return err;
+
+	ice_devl_whole_dev_resources_register(hw, adapter);
+
+	return 0;
 }
 
 static void ice_adapter_fini(void *priv)
 {
 	struct ice_adapter *adapter = priv;
+	struct devlink *devlink;
+
+	devlink = shd_priv_to_devlink(adapter);
+	devl_resources_unregister(devlink);
 
 	WARN_ON(!list_empty(&adapter->ports.list));
 	for (int i = 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
@@ -86,15 +100,16 @@ static const struct devlink_ops ice_adapter_devlink_ops = {
  */
 struct ice_adapter *ice_adapter_get(struct pci_dev *pdev)
 {
+	struct ice_pf *pf = pci_get_drvdata(pdev);
 	struct ice_adapter *adapter;
 	struct devlink *devlink;
 	char devlink_id[32];
 	u64 index;
 
 	index = ice_adapter_index(pdev);
 	snprintf(devlink_id, sizeof(devlink_id), "ice:%llx", index);
 	devlink = devlink_shd_get(devlink_id, &ice_adapter_devlink_ops,
-				  sizeof(*adapter), NULL, pdev->dev.driver);
+				  sizeof(*adapter), &pf->hw, pdev->dev.driver);
 	if (IS_ERR(devlink))
 		return ERR_CAST(devlink);
 
diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index 04633103e3e6..3794555cd849 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -4452,7 +4452,7 @@ ice_aq_sff_eeprom(struct ice_hw *hw, u16 lport, u8 bus_addr,
 	return status;
 }
 
-static enum ice_lut_size ice_lut_type_to_size(enum ice_lut_type type)
+enum ice_lut_size ice_lut_type_to_size(enum ice_lut_type type)
 {
 	switch (type) {
 	case ICE_LUT_VSI:
diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool.c b/drivers/net/ethernet/intel/ice/ice_ethtool.c
index dffa213734f1..822b94f87156 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool.c
@@ -3645,11 +3645,13 @@ ice_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh)
 	if (!rxfh->indir)
 		return 0;
 
-	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
-	if (!lut)
-		return -ENOMEM;
+	scoped_guard(mutex, &pf->rss_lut_lock) {
+		lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
+		if (!lut)
+			return -ENOMEM;
 
-	err = ice_get_rss(vsi, rxfh->key, lut, vsi->rss_table_size);
+		err = ice_get_rss(vsi, rxfh->key, lut, vsi->rss_table_size);
+	}
 	if (err)
 		goto out;
 
@@ -3707,7 +3709,9 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 	if (rxfh->input_xfrm & RXH_XFRM_SYM_XOR)
 		hfunc = ICE_AQ_VSI_Q_OPT_RSS_HASH_SYM_TPLZ;
 
-	err = ice_set_rss_hfunc(vsi, hfunc);
+	/* q_opt_rss also carries the RSS LUT type, that devlink may change */
+	scoped_guard(mutex, &pf->rss_lut_lock)
+		err = ice_set_rss_hfunc(vsi, hfunc);
 	if (err)
 		return err;
 
@@ -3727,29 +3731,31 @@ ice_set_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *rxfh,
 			return err;
 	}
 
-	if (!vsi->rss_lut_user) {
-		vsi->rss_lut_user = devm_kzalloc(dev, vsi->rss_table_size,
-						 GFP_KERNEL);
-		if (!vsi->rss_lut_user)
-			return -ENOMEM;
-	}
+	scoped_guard(mutex, &pf->rss_lut_lock) {
+		if (!vsi->rss_lut_user) {
+			vsi->rss_lut_user = devm_kzalloc(dev,
+							 vsi->rss_table_size,
+							 GFP_KERNEL);
+			if (!vsi->rss_lut_user)
+				return -ENOMEM;
+		}
 
-	/* Each 32 bits pointed by 'indir' is stored with a lut entry */
-	if (rxfh->indir) {
-		int i;
+		/* Each 32 bits pointed by 'indir' is stored with a lut entry */
+		if (rxfh->indir) {
+			int i;
 
-		for (i = 0; i < vsi->rss_table_size; i++)
-			vsi->rss_lut_user[i] = (u8)(rxfh->indir[i]);
-	} else {
-		ice_fill_rss_lut(vsi->rss_lut_user, vsi->rss_table_size,
-				 vsi->rss_size);
-	}
+			for (i = 0; i < vsi->rss_table_size; i++)
+				vsi->rss_lut_user[i] = (u8)(rxfh->indir[i]);
+		} else {
+			ice_fill_rss_lut(vsi->rss_lut_user, vsi->rss_table_size,
+					 vsi->rss_size);
+		}
 
-	err = ice_set_rss_lut(vsi, vsi->rss_lut_user, vsi->rss_table_size);
-	if (err)
-		return err;
+		err = ice_set_rss_lut(vsi, vsi->rss_lut_user,
+				      vsi->rss_table_size);
+	}
 
-	return 0;
+	return err;
 }
 
 static int
@@ -3856,19 +3862,22 @@ static int ice_vsi_set_dflt_rss_lut(struct ice_vsi *vsi, int req_rss_size)
 	if (!req_rss_size)
 		return -EINVAL;
 
-	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
-	if (!lut)
-		return -ENOMEM;
+	scoped_guard(mutex, &pf->rss_lut_lock) {
+		lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
+		if (!lut)
+			return -ENOMEM;
 
-	/* set RSS LUT parameters */
-	if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
-		vsi->rss_size = 1;
-	else
-		vsi->rss_size = ice_get_valid_rss_size(hw, req_rss_size);
+		/* set RSS LUT parameters */
+		if (!test_bit(ICE_FLAG_RSS_ENA, pf->flags))
+			vsi->rss_size = 1;
+		else
+			vsi->rss_size = ice_get_valid_rss_size(hw,
+							       req_rss_size);
 
-	/* create/set RSS LUT */
-	ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
-	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+		/* create/set RSS LUT */
+		ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
+		err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	}
 	if (err)
 		dev_err(dev, "Cannot set RSS lut, err %d aq_err %s\n", err,
 			libie_aq_str(hw->adminq.sq_last_status));
diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c b/drivers/net/ethernet/intel/ice/ice_idc.c
index 102d63c3018b..5187916f37be 100644
--- a/drivers/net/ethernet/intel/ice/ice_idc.c
+++ b/drivers/net/ethernet/intel/ice/ice_idc.c
@@ -207,15 +207,22 @@ int ice_rdma_update_vsi_filter(struct iidc_rdma_core_dev_info *cdev,
 	if (!vsi)
 		return -EINVAL;
 
-	status = ice_cfg_rdma_fltr(&pf->hw, vsi->idx, enable);
-	if (status) {
-		dev_err(ice_pf_to_dev(pf), "Failed to  %sable RDMA filtering\n",
-			enable ? "en" : "dis");
-	} else {
-		if (enable)
-			vsi->info.q_opt_flags |= ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
-		else
-			vsi->info.q_opt_flags &= ~ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
+	/* q_opt_rss also carries the RSS LUT type, that devlink may change */
+	scoped_guard(mutex, &pf->rss_lut_lock) {
+		status = ice_cfg_rdma_fltr(&pf->hw, vsi->idx, &vsi->info,
+					   enable);
+		if (status) {
+			dev_err(ice_pf_to_dev(pf),
+				"Failed to  %sable RDMA filtering\n",
+				enable ? "en" : "dis");
+		} else {
+			if (enable)
+				vsi->info.q_opt_flags |=
+					ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
+			else
+				vsi->info.q_opt_flags &=
+					~ICE_AQ_VSI_Q_OPT_PE_FLTR_EN;
+		}
 	}
 
 	return status;
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index f81b310a98c3..215244a1c043 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -10,6 +10,8 @@
 #include "ice_type.h"
 #include "ice_vsi_vlan_ops.h"
 
+#include "devlink/resource.h"
+
 /**
  * ice_vsi_type_str - maps VSI type enum to string equivalents
  * @vsi_type: VSI type enum
@@ -986,10 +988,10 @@ static void ice_rss_clean(struct ice_vsi *vsi)
 }
 
 /**
- * ice_vsi_set_rss_params - Setup RSS capabilities per VSI type
+ * ice_vsi_set_dflt_rss_params - Setup default RSS capabilities per VSI type
  * @vsi: the VSI being configured
  */
-static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
+static void ice_vsi_set_dflt_rss_params(struct ice_vsi *vsi)
 {
 	struct ice_hw_common_caps *cap;
 	struct ice_pf *pf = vsi->back;
@@ -1004,6 +1006,9 @@ static void ice_vsi_set_rss_params(struct ice_vsi *vsi)
 	max_rss_size = BIT(cap->rss_table_entry_width);
 	switch (vsi->type) {
 	case ICE_VSI_CHNL:
+		if (!vsi->num_rxq)
+			vsi->num_rxq = 1;
+		fallthrough;
 	case ICE_VSI_PF:
 		/* PF VSI will inherit RSS instance of PF */
 		vsi->rss_table_size = (u16)cap->rss_table_size;
@@ -1306,6 +1311,32 @@ static void ice_set_rss_vsi_ctx(struct ice_vsi_ctx *ctxt, struct ice_vsi *vsi)
 		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_HASH_M, hash_type);
 }
 
+int ice_vsi_update_rss_lut(struct ice_vsi *vsi, enum ice_lut_type lut_type,
+			   u8 global_lut_id)
+{
+	struct ice_vsi_ctx *ctx;
+	int err;
+
+	ctx = kzalloc_obj(*ctx);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_Q_OPT_VALID);
+	ctx->info.q_opt_rss = vsi->info.q_opt_rss &
+		~(ICE_AQ_VSI_Q_OPT_RSS_LUT_M | ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M);
+	ctx->info.q_opt_rss |= FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_LUT_M,
+				ice_lut_type_to_aq_qopt_rss_val(lut_type)) |
+		FIELD_PREP(ICE_AQ_VSI_Q_OPT_RSS_GBL_LUT_M, global_lut_id);
+	ctx->info.q_opt_tc = vsi->info.q_opt_tc;
+	ctx->info.q_opt_flags = vsi->info.q_opt_flags;
+
+	err = ice_update_vsi(&vsi->back->hw, vsi->idx, ctx, NULL);
+	if (!err)
+		vsi->info.q_opt_rss = ctx->info.q_opt_rss;
+	kfree(ctx);
+	return err;
+}
+
 static void
 ice_chnl_vsi_setup_q_map(struct ice_vsi *vsi, struct ice_vsi_ctx *ctxt)
 {
@@ -1581,19 +1612,22 @@ void ice_vsi_manage_rss_lut(struct ice_vsi *vsi, bool ena)
 {
 	u8 *lut;
 
-	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
-	if (!lut)
-		return;
+	scoped_guard(mutex, &vsi->back->rss_lut_lock) {
+		lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
+		if (!lut)
+			return;
 
-	if (ena) {
-		if (vsi->rss_lut_user)
-			memcpy(lut, vsi->rss_lut_user, vsi->rss_table_size);
-		else
-			ice_fill_rss_lut(lut, vsi->rss_table_size,
-					 vsi->rss_size);
-	}
+		if (ena) {
+			if (vsi->rss_lut_user)
+				memcpy(lut, vsi->rss_lut_user,
+				       vsi->rss_table_size);
+			else
+				ice_fill_rss_lut(lut, vsi->rss_table_size,
+						 vsi->rss_size);
+		}
 
-	ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+		ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	}
 	kfree(lut);
 }
 
@@ -1645,16 +1679,19 @@ int ice_vsi_cfg_rss_lut_key(struct ice_vsi *vsi)
 		}
 	}
 
-	lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
-	if (!lut)
-		return -ENOMEM;
+	scoped_guard(mutex, &pf->rss_lut_lock) {
+		lut = kzalloc(vsi->rss_table_size, GFP_KERNEL);
+		if (!lut)
+			return -ENOMEM;
 
-	if (vsi->rss_lut_user)
-		memcpy(lut, vsi->rss_lut_user, vsi->rss_table_size);
-	else
-		ice_fill_rss_lut(lut, vsi->rss_table_size, vsi->rss_size);
+		if (vsi->rss_lut_user)
+			memcpy(lut, vsi->rss_lut_user, vsi->rss_table_size);
+		else
+			ice_fill_rss_lut(lut, vsi->rss_table_size,
+					 vsi->rss_size);
 
-	err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+		err = ice_set_rss_lut(vsi, lut, vsi->rss_table_size);
+	}
 	if (err) {
 		dev_err(dev, "set_rss_lut failed, error %d\n", err);
 		goto ice_vsi_cfg_rss_exit;
@@ -2427,6 +2464,18 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 
 	vsi->vsw = pf->first_sw;
 
+	if (vsi->flags & ICE_VSI_FLAG_INIT) {
+		scoped_guard(mutex, &pf->rss_lut_lock) {
+			u16 lut_size = vsi->rss_table_size;
+
+			ice_vsi_set_dflt_rss_params(vsi);
+			if (vsi->rss_table_size != lut_size) {
+				devm_kfree(dev, vsi->rss_lut_user);
+				vsi->rss_lut_user = NULL;
+			}
+		}
+	}
+
 	ret = ice_vsi_alloc_def(vsi, vsi->ch);
 	if (ret)
 		return ret;
@@ -2446,15 +2495,23 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	}
 
 	/* set RSS capabilities */
-	ice_vsi_set_rss_params(vsi);
+	if ((vsi->flags & ICE_VSI_FLAG_INIT) && vsi->type == ICE_VSI_PF) {
+		ret = ice_take_rss_lut_pf(pf);
+		if (ret) {
+			dev_err(dev, "Failed to allocate RSS LUT for PF: %d\n",
+				ret);
+			goto unroll_get_qs;
+		}
+	}
 
 	/* set TC configuration */
 	ice_vsi_set_tc_cfg(vsi);
 
-	/* create the VSI */
-	ret = ice_vsi_init(vsi, vsi->flags);
+	/* create the VSI, its context carries RSS LUT type and global LUT id */
+	scoped_guard(mutex, &pf->rss_lut_lock)
+		ret = ice_vsi_init(vsi, vsi->flags);
 	if (ret)
-		goto unroll_get_qs;
+		goto unroll_pf_rss_lut;
 
 	ice_vsi_init_vlan_ops(vsi);
 
@@ -2566,6 +2623,9 @@ static int ice_vsi_cfg_def(struct ice_vsi *vsi)
 	ice_vsi_free_q_vectors(vsi);
 unroll_vsi_init:
 	ice_vsi_delete_from_hw(vsi);
+unroll_pf_rss_lut:
+	if ((vsi->flags & ICE_VSI_FLAG_INIT) && vsi->type == ICE_VSI_PF)
+		ice_release_rss_lut_pf(pf);
 unroll_get_qs:
 	ice_vsi_put_qs(vsi);
 unroll_vsi_alloc_stat:
@@ -2643,6 +2703,11 @@ void ice_vsi_decfg(struct ice_vsi *vsi)
 	if (vsi->type == ICE_VSI_VF &&
 	    vsi->agg_node && vsi->agg_node->valid)
 		vsi->agg_node->num_vsis--;
+
+	if (vsi->flags & ICE_VSI_FLAG_INIT) {
+		if (vsi->type == ICE_VSI_PF)
+			ice_free_rss_lut_flr(pf);
+	}
 }
 
 /**
diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 6373cd5ac288..1ed6f31865ad 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -15,6 +15,7 @@
 #include "ice_dcb_nl.h"
 #include "devlink/devlink.h"
 #include "devlink/port.h"
+#include "devlink/resource.h"
 #include "ice_sf_eth.h"
 #include "ice_hwmon.h"
 /* Including ice_trace.h with CREATE_TRACE_POINTS defined will generate the
@@ -546,6 +547,8 @@ ice_prepare_for_reset(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (test_bit(ICE_PREPARED_FOR_RESET, pf->state))
 		return;
 
+	ice_prepare_rss_luts_for_reset(pf);
+
 	synchronize_irq(pf->oicr_irq.virq);
 
 	ice_unplug_aux_dev(pf);
@@ -3873,6 +3876,9 @@ void ice_deinit_pf(struct ice_pf *pf)
 {
 	/* note that we unroll also on ice_init_pf() failure here */
 
+	/* ice_vsi_decfg() skips it if the last VSI rebuild was NO_INIT */
+	ice_free_rss_lut_flr(pf);
+	mutex_destroy(&pf->rss_lut_lock);
 	mutex_destroy(&pf->lag_mutex);
 	mutex_destroy(&pf->adev_mutex);
 	mutex_destroy(&pf->sw_mutex);
@@ -3978,6 +3984,7 @@ int ice_init_pf(struct ice_pf *pf)
 	mutex_init(&pf->tc_mutex);
 	mutex_init(&pf->adev_mutex);
 	mutex_init(&pf->lag_mutex);
+	mutex_init(&pf->rss_lut_lock);
 
 	INIT_HLIST_HEAD(&pf->aq_wait_list);
 	spin_lock_init(&pf->aq_wait_lock);
@@ -4963,6 +4970,7 @@ static void ice_deinit_devlink(struct ice_pf *pf)
 	ice_devlink_unregister(pf);
 	ice_devlink_destroy_regions(pf);
 	ice_devlink_unregister_params(pf);
+	devl_resources_unregister(priv_to_devlink(pf));
 }
 
 static int ice_init(struct ice_pf *pf)
@@ -5284,6 +5292,7 @@ ice_probe(struct pci_dev *pdev, const struct pci_device_id __always_unused *ent)
 	err = ice_init_devlink(pf);
 	if (err)
 		goto unroll_load;
+	ice_devl_pf_resources_register(pf);
 	devl_unlock(priv_to_devlink(pf));
 
 	return 0;
@@ -7769,6 +7778,12 @@ static void ice_rebuild(struct ice_pf *pf, enum ice_reset_req reset_type)
 	if (ice_is_feature_supported(pf, ICE_F_GNSS))
 		ice_gnss_init(pf);
 
+	err = ice_rebuild_rss_luts(pf);
+	if (err) {
+		dev_err(dev, "RSS LUT rebuild failed: %d\n", err);
+		goto err_vsi_rebuild;
+	}
+
 	/* rebuild PF VSI */
 	err = ice_vsi_rebuild_by_type(pf, ICE_VSI_PF);
 	if (err) {
@@ -7926,6 +7941,8 @@ int ice_set_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size)
 	params.lut_size = lut_size;
 	params.lut_type = vsi->rss_lut_type;
 	params.lut = lut;
+	if (params.lut_type == ICE_LUT_GLOBAL)
+		params.global_lut_id = vsi->global_lut_id;
 
 	status = ice_aq_set_rss_lut(hw, &params);
 	if (status)
@@ -7979,6 +7996,8 @@ int ice_get_rss_lut(struct ice_vsi *vsi, u8 *lut, u16 lut_size)
 	params.lut_size = lut_size;
 	params.lut_type = vsi->rss_lut_type;
 	params.lut = lut;
+	if (params.lut_type == ICE_LUT_GLOBAL)
+		params.global_lut_id = vsi->global_lut_id;
 
 	status = ice_aq_get_rss_lut(hw, &params);
 	if (status)
@@ -9193,8 +9212,14 @@ static int ice_setup_tc_mqprio_qdisc(struct net_device *netdev, void *type_data)
 				   ret);
 			return ret;
 		}
+		scoped_guard(ice_adapter_devl, pf->adapter) {
+			if (ice_rss_lut_is_reassigned(pf)) {
+				dev_err(dev, "RSS LUTs reassigned via devlink, can't configure ADQ\n");
+				return -EOPNOTSUPP;
+			}
+			set_bit(ICE_FLAG_TC_MQPRIO, pf->flags);
+		}
 		memcpy(&vsi->mqprio_qopt, mqprio_qopt, sizeof(*mqprio_qopt));
-		set_bit(ICE_FLAG_TC_MQPRIO, pf->flags);
 		/* don't assume state of hw_tc_offload during driver load
 		 * and set the flag for TC flower filter if hw_tc_offload
 		 * already ON
diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index e6f08fe9b5c2..2423446a1698 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -1876,10 +1876,12 @@ ice_update_vsi(struct ice_hw *hw, u16 vsi_handle, struct ice_vsi_ctx *vsi_ctx,
  * ice_cfg_rdma_fltr - enable/disable RDMA filtering on VSI
  * @hw: pointer to HW struct
  * @vsi_handle: VSI SW index
+ * @info: current VSI properties, the rest of the Q_OPT section is kept
  * @enable: boolean for enable/disable
  */
 int
-ice_cfg_rdma_fltr(struct ice_hw *hw, u16 vsi_handle, bool enable)
+ice_cfg_rdma_fltr(struct ice_hw *hw, u16 vsi_handle,
+		  const struct ice_aqc_vsi_props *info, bool enable)
 {
 	struct ice_vsi_ctx *ctx, *cached_ctx;
 	int status;
@@ -1892,9 +1894,10 @@ ice_cfg_rdma_fltr(struct ice_hw *hw, u16 vsi_handle, bool enable)
 	if (!ctx)
 		return -ENOMEM;
 
-	ctx->info.q_opt_rss = cached_ctx->info.q_opt_rss;
-	ctx->info.q_opt_tc = cached_ctx->info.q_opt_tc;
-	ctx->info.q_opt_flags = cached_ctx->info.q_opt_flags;
+	/* not from the cached ctx, that misses RSS LUT changes */
+	ctx->info.q_opt_rss = info->q_opt_rss;
+	ctx->info.q_opt_tc = info->q_opt_tc;
+	ctx->info.q_opt_flags = info->q_opt_flags;
 
 	ctx->info.valid_sections = cpu_to_le16(ICE_AQ_VSI_PROP_Q_OPT_VALID);
 
-- 
2.54.0

