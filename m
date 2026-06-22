Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93264CDB46B
	for <intel-wired-lan@archiver.kernel.org>; Mon, 22 Jun 2026 07:31:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4448A4092A;
	Mon, 22 Jun 2026 07:31:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id STe4W06LuI_W; Mon, 22 Jun 2026 07:31:06 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A19C2407BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1782113466;
	bh=dMPvIEI+w93HiuN2NS/tC8/gWcQxei3DMqgg6cViNHY=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=L+W8Q2U2/IN6IXAmSGpR0iotAsyF1GC4WXI19ZZNpciTVDDimC8jaSKApn6Xf51x1
	 wdIXnvTwxiw1thIbvslX78hYZzPKmR0ZrKmS2yrsxBVGB2R9k60nvLkXs9B9dE+r9B
	 mLv9GKGmM5dntZqn/8xTiAPuhr9UzSYj6N2KLKsVRrSRvsrtwTAPQtuuTL2nihOfjo
	 vd3Dd0DVU1j/WJLcTDgXmqTud2mrWE/V06urbZlHsz0dnCl/bI1A+U8jxniLToCxSJ
	 BBswLSdJBC2DOL1ZpbbcTUmnN3c6ICmkxxevFvusiC7sXb7RBenkS2RTwlOJ+xt9Ii
	 uey8typAtRipw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A19C2407BC;
	Mon, 22 Jun 2026 07:31:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 555E3367
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 07:31:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 532A38649E
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 07:31:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id znaO94ev7kFr for <intel-wired-lan@lists.osuosl.org>;
 Mon, 22 Jun 2026 07:31:03 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A1D348649D
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A1D348649D
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1D348649D
 for <intel-wired-lan@lists.osuosl.org>; Mon, 22 Jun 2026 07:31:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C114B4434C;
 Mon, 22 Jun 2026 07:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D4EF1F00A3A;
 Mon, 22 Jun 2026 07:31:00 +0000 (UTC)
Date: Mon, 22 Jun 2026 08:30:58 +0100
From: Simon Horman <horms@kernel.org>
To: Emil Tantilov <emil.s.tantilov@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, madhu.chittim@intel.com
Message-ID: <20260622073058.GY827683@horms.kernel.org>
References: <20260618192325.8694-1-emil.s.tantilov@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260618192325.8694-1-emil.s.tantilov@intel.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel.org; s=k20260515; t=1782113462;
 bh=dMPvIEI+w93HiuN2NS/tC8/gWcQxei3DMqgg6cViNHY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=dVPg5kH3s9VjfqirB886mN5sK8U4oSArE0GakJrwBZdxN7EsROvMtOlmeDfNcpuzd
 EPMxpu1PgybMndIJV50HEz3jvtk6zXn8HgJPYfG8ikR91uNWer1My0cikRxUyvD1C2
 SAqNUmZ+cwNOBxNipAStyDqK4LqgEW11ncOe/pDsVg0VyUu7bKa/u+QayZo0uyNRUN
 A21WUieVNdVgY73TFPvXpo48LHai3mKj9dYOSlfGJaofQzmwZhdcQt4vGDTTzwjDTy
 LUYhCuZ6uf9FfWjH7WYVIZK3pzaT1Wl+iO2/tVnhbtMpG/ASsl0KoROUWDxPXZbQf2
 FMEf6WGtiDpwQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=dVPg5kH3
Subject: Re: [Intel-wired-lan] [PATCH iwl-net] idpf: fix max_vport related
 crash on allocation error during init
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Thu, Jun 18, 2026 at 12:23:25PM -0700, Emil Tantilov wrote:
> Set adapter->max_vports only after successful allocation of vports, netdevs
> and  vport_config buffers. This fixes possible crashes on reset or rmmod,
> following failed allocation on init
> 
> [  305.981402] idpf 0000:83:00.0: enabling device (0100 -> 0102)
> [  305.994464] idpf 0000:83:00.0: Device HW Reset initiated
> [  320.416872] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [  320.416918] #PF: supervisor read access in kernel mode
> [  320.416942] #PF: error_code(0x0000) - not-present page
> [  320.416963] PGD 2099657067 P4D 0
> [  320.416983] Oops: Oops: 0000 [#1] SMP NOPTI
> ...
> [  320.417093] RIP: 0010:idpf_remove+0x118/0x200 [idpf]
> [  320.417130] Code: 8b bb 98 09 00 00 e8 17 0f 5b e5 48 8b bb e8 08 00 00 e8 0b 0f 5b e5 66 83 bb 28 06 00 00 00 48 8b bb 20 06 00 00 74 49 31 ed <48> 8b 04 ef 48 85 c0 74 2f 48 8b 78 20 e8 66 58 91 e5 48 8b 83 20
> [  320.417183] RSP: 0018:ff7322212903fdb8 EFLAGS: 00010246
> [  320.417205] RAX: 0000000000000000 RBX: ff4463de40300000 RCX: ff7322212903fd4c
> [  320.417228] RDX: 0000000000000001 RSI: ffffffffa7f7d100 RDI: 0000000000000000
> [  320.417250] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
> [  320.417272] R10: 0000000000000001 R11: ff4463de3a638f58 R12: ff4463be89ac7000
> [  320.417294] R13: ff4463be89ac7198 R14: ff4463be94fc7198 R15: ffffffffc0f10f20
> [  320.417317] FS:  00007f963c0e6740(0000) GS:ff4463fdd65d8000(0000) knlGS:0000000000000000
> [  320.417342] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  320.417362] CR2: 0000000000000000 CR3: 00000020ba674002 CR4: 0000000000773ef0
> [  320.417385] PKRU: 55555554
> [  320.417398] Call Trace:
> [  320.417412]  <TASK>
> [  320.417429]  pci_device_remove+0x42/0xb0
> [  320.417459]  device_release_driver_internal+0x1a9/0x210
> [  320.417492]  driver_detach+0x4b/0x90
> [  320.417516]  bus_remove_driver+0x70/0x100
> [  320.417539]  pci_unregister_driver+0x2e/0xb0
> [  320.417564]  __do_sys_delete_module.constprop.0+0x190/0x2f0
> [  320.417592]  ? kmem_cache_free+0x31e/0x550
> [  320.417619]  ? lockdep_hardirqs_on_prepare+0xde/0x190
> [  320.417644]  ? do_syscall_64+0x38/0x6b0
> [  320.417665]  do_syscall_64+0xc8/0x6b0
> [  320.417683]  ? clear_bhb_loop+0x30/0x80
> [  320.417706]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [  320.417727] RIP: 0033:0x7f963bb30beb
> 
> Fixes: 0fe45467a104 ("idpf: add create vport and netdev configuration")
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

FTR, an AI generated review of this patch is available on sashiko.dev.
I think that the issue raised there can be looked at in the context of
possible follow-up.
