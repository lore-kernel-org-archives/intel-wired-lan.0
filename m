Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3D0606A329
	for <intel-wired-lan@archiver.kernel.org>; Mon, 26 Oct 2026 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=EHRtKRHi;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=TeJjs6IO
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A697D80DEC;
	Mon, 26 Oct 2026 09:41:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4JZTWo9_vZyR; Mon, 26 Oct 2026 09:41:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org ECE3980DE9
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793007666;
	b=M2vUvmAsP5ZQ6Uqqfydca3Uexs9AKUYR0iEy6s+P7NP6RAZFUlKjrzzng6ggvxwD+8F8
	 tsKy+YBPId1ZKY/5cUdWP05uP68Xb+A1rm0qvw0HBOskvjeqJpL23TWC4FFDSpCJ20A0S
	 20VGN6lV7MPEPt+ckw9SC1xzaoweZDvBveL5jwpvHDoiQYggpTFFRxGQUkjOrsFDJZ/Ma
	 GjdOTr14Cep3bMuFTHwsir2pbivbMkB3ufkBLp/XYZLT3M1cB1tZN5HEL7WQWl1p3L/hl
	 /XbZLDI88Wh1i6WPufGu930Y7k7y1hJ0DFCeIbAxlciuEk+4v1/i08uEj+dd8VEPqpQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793007666;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=/nWOBQ3UDQ/W3CXsSI8TJZhVNJdyXVEnyxKpoZ3u7HQ=;
	b=BXq4Vc+likGSIdq5IrrfMcgq/vzp0j5kaQyUaJ66gz6eFIrAIqk7/A/6cTXM2tkCkNdq
	 +7/+iSf5JvZZyw8q8ciH3dsM1UhGXWHTxt6ggQHqrsXV2bZ6IdZhjM8n1arW+pE2jiIpJ
	 WhhrA+aKNF5qohesPP4kTF5heKhI2L4vGS6LTVnlrAB+CK7UMmaEg42Fjlc1YhKe522+S
	 cpddIHKhe8W25Jbl3EBcmPHC3pnFm6P7XcXfUWaU3goGKQeWBVxwVMDGPvhe4npQ96IB4
	 eQQINrmIKotzsqGRfu+OABAsuzbLXJwo3K6808/qzsR51hKQ9KHYTSy3lzBGVI5gqYQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793007666;
	bh=/nWOBQ3UDQ/W3CXsSI8TJZhVNJdyXVEnyxKpoZ3u7HQ=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=EHRtKRHizqViJD/TSJ2cKPz+4j+MtmM7kWr6PAo6ICb5Nsul9BkACzdS0I49ws8e2
	 SOx2+aY0vzVv9hyWSpCL/VVmy0wI1ZM+lfjaEPtjQ1kP+pzu7eQMY7rC1iQ/2PjOcG
	 J0m1dPkkK+ppC6n1qY6rrpN/yRTL3hLkxLFxmRhN0EF6nLmGeXU4LjOJzf22JtmG2Z
	 GPJFxBBNyduYg9pVCYj90YDd5274A8F1Jk+jYjvSqWaEvUB75pNhka6HDBMg2dZRam
	 0vu0mh6VWNTp/cllwfCMwZJ/OAbfFOWKD8kFpcqMGsh3QujTvIAgI9BfWdsIUPxwl+
	 +rMRc3FW818yw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECE3980DE9;
	Mon, 26 Oct 2026 09:41:05 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 46C20279
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:41:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3836360649
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:41:04 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id PCbIF68-wdRy for <intel-wired-lan@lists.osuosl.org>;
 Mon, 26 Oct 2026 09:41:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 859B460645
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=109.224.244.22
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793007663;
 b=F4aromOPNwBf04eFGCCoZP9yo4lplDQwvMGXX6Gmf4d13a+pzPaSbBX2tdBYdI9uoptI
 jem/+IxLp+5xz1OZEu1WY7Rw8D2jb8VXfShbfLjBc1tUZKlCTv970Yd0oWW1RdN8TXvJP
 7vaR+wBmGHkWryfGEa/9MuQrDO75fI9qRliPHD9T1L5llMRDQ5jSK5wVIQ6kfwRSNniRI
 BVOKCASJpI2U7F9IdSGZlijRuN1kb+VGZKfRFtrvijRMTwEYN1wuQzohfzAtO7jvC2VzN
 +n9vE7liPNryzNroiWN3jU+uAcizTXIIu8NUg5J5L9/6n3WfS9SWQcQRDNpeOSnUBHA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793007663;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=/nWOBQ3UDQ/W3CXsSI8TJZhVNJdyXVEnyxKpoZ3u7HQ=;
 b=MV3jvF7i9Q0bpbUFqEnj8yF46SzQkSa/oIx07gmIEqmpdBlBRioDlyd5Al/0ilG63bTq
 QozW1suGHpbHJs7gZZ8Jcm11foWJHE6Ll67UYCBEpX7HpukrmsxuSSrsxRrt+wWH3mvjo
 ub1uEWi1kZq9npLpNML9WoOCTjqvKIb/yeS80uh9/AWjMjLUUu5+c1CY8vpf/g8mpb+d4
 rHQ8/8Qj0rmvagH41ao2PXEXAJkiST1c+jvoYnLiU1oHpUt105v0fpmp4jCz12IyDtFyZ
 jDGzue1HEcdb9V2RBZcct9WI+phtmGAQA5spxjoQhX9nf3rjrTqBEu7DusBcy0oWhtg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=TeJjs6IO; 
 arc=none smtp.remote-ip=109.224.244.22
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=109.224.244.22;
 helo=mail-24422.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=TeJjs6IO
Received: from mail-24422.protonmail.ch (mail-24422.protonmail.ch
 [109.224.244.22])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 859B460645
 for <intel-wired-lan@lists.osuosl.org>; Mon, 26 Oct 2026 09:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793007659; x=1793266859;
 bh=/nWOBQ3UDQ/W3CXsSI8TJZhVNJdyXVEnyxKpoZ3u7HQ=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=TeJjs6IOIwZpClCo4meJBUSSPrqDvTiJ8nX/MjDosrh2Y+p7rdfzxkjr45DaZ8whY
 mkUbj+d3/sj3ab6ahDzSVZHAVhpLMMpEynczxJp1cfCDQQz8BS/9z+v7dbsG2g1wnB
 uNCYcjom3hKmMhG2GH4pPIT8KeeGUNocZ2OaaytvkP7PC+fYBBPN0aKmSmR9in7XYI
 SrLhYTaILK66LLHj134udSfhgNakF2pByv9cy7+yHD3FDVlTs71yfLXWXo6eGajf/3
 w310BVKdRcPHvfeWN7oXygdnDIQdhHzgoMg9m9hGoviKvvzLZUM/Mja0aZpvzCkeIQ
 8DFi2H/OEmHSQ==
Date: Mon, 26 Oct 2026 09:40:53 +0000
To: netdev-bot+sinfo@kernel.org
From: Paul Moses <p@1g4.org>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 aleksandr.loktionov@intel.com, chwee.lin.choong@intel.com,
 faizal.abdul.rahim@linux.intel.com, horms@kernel.org, vinicius.gomes@intel.com,
 sasha.neftin@intel.com, matthew.vick@intel.com, aduyck@mirantis.com
Subject: Re: [PATCH net 1/3] igc: pad preemptible packets before reserving TX
 timestamps
Message-ID: <Gpz1_ooVsWcYe5XIAt4D2Ci9b7genCxdtNHc0zJLEkcIZiTFzBA07YuMtFwb0V-VGIaVsM8EsE8qV9pvqkVnoD-sjMhSTcWUD0LuWCb_LGY=@1g4.org>
In-Reply-To: <179300642756.3327.8776904148998915275@kernel.org>
References: <20261026091549.605810-1-p@1g4.org>
 <179300642756.3327.8776904148998915275@kernel.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 0e7f36d84194ab5ae11f27d107ee9c4340588d66
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1





On Monday, October 26th, 2026 at 4:20 AM, netdev-bot+sinfo@kernel.org <netd=
ev-bot+sinfo@kernel.org> wrote:

> Hi!
>=20
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>=20
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
>=20
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>=20
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>=20
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>=20
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
>=20

Originally found during igc development.

[11865.112180] kernel BUG at pskb_expand_head+0x3f3/0x400 [verbose debug in=
fo unavailable]
[11865.112206] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[11865.324662] CPU: 7 UID: 0 PID: 91702 Comm: t Not tainted 7.3.0-rc6-nokas=
an+ #5 PREEMPT
[11865.429202] RIP: 0010:pskb_expand_head+0x3f3/0x400
[11865.486782] Code: 00 48 83 c7 08 e8 dd da ab ff e9 d2 fd ff ff 4c 8b ab =
c0 00 00 00 44 8b b3 bc 00 00 00 43 0f b6 44 35 00 e9 89 fd ff ff 0f 0b <0f=
> 0b 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90
[11865.712331] RSP: 0018:ffffaaf3029077e8 EFLAGS: 00010202
[11865.775131] RAX: 0000000000000002 RBX: ffff9e3260c92920 RCX: 00000000000=
00820
[11865.860902] RDX: 00000000ffffffc6 RSI: 0000000000000000 RDI: ffff9e3260c=
92920
[11865.946667] RBP: 0000000000000001 R08: 0000000000000003 R09: 00000000000=
00001
[11866.032435] R10: 0000000000000000 R11: ffffffffc060c8e0 R12: ffff9e3260c=
92994
[11866.118206] R13: 0000000000000140 R14: 0000000000000005 R15: 00000000000=
0003c
[11866.203979] FS:  00007860e5343e78(0000) GS:ffff9e3770bd5000(0000) knlGS:=
0000000000000000
[11866.301224] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[11866.370293] CR2: 00007860e531ac90 CR3: 00000005a7e60002 CR4: 0000000000f=
70ef0
[11866.456051] PKRU: 55555554
[11866.488599] Call Trace:
[11866.518015]  <TASK>
[11866.543266]  __skb_pad+0xbf/0x130
[11866.583116]  igc_xmit_frame+0x428/0xec0 [igc]
[11866.635491]  ? netif_skb_features+0x230/0x330
[11866.687859]  dev_hard_start_xmit+0x9e/0x1b0
[11866.738142]  sch_direct_xmit+0xde/0x260
[11866.784249]  ? __dev_queue_xmit+0x99/0xf20
[11866.833495]  __dev_queue_xmit+0x77d/0xf20
[11866.881698]  ip_finish_output2+0x310/0x390
[11866.930951]  ip_output+0x64/0x100
[11866.970811]  __ip_queue_xmit+0x485/0x4a0
[11867.017973]  ? __skb_clone+0x2a/0x120
[11867.062009]  __tcp_transmit_skb+0xa79/0xc80
[11867.112299]  tcp_write_xmit+0x849/0x1090
[11867.159463]  __tcp_push_pending_frames+0x32/0xc0
[11867.214967]  tcp_sendmsg_locked+0xeb3/0x1110
[11867.266312]  tcp_sendmsg+0x2c/0x50
[11867.307211]  __sock_sendmsg+0x67/0x90
[11867.351251]  __sys_sendto+0x242/0x290
[11867.395277]  __x64_sys_sendto+0x26/0x30
[11867.441393]  do_syscall_64+0xdb/0x310
[11867.485420]  ? do_syscall_64+0x42/0x310
[11867.531533]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[11867.592248] RIP: 0033:0x7860e532f19d
[11867.635231] Code: c0 0f 85 24 00 00 00 49 89 fb 48 89 f0 48 89 d7 48 89 =
ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3=
> e9 1d bb ff ff cc cc cc cc cc cc cc cc cc cc cc cc cc 41 56 53
[11867.860798] RSP: 002b:00007ffdb9a150e8 EFLAGS: 00000246 ORIG_RAX: 000000=
000000002c
[11867.951782] RAX: ffffffffffffffda RBX: 000000000000002c RCX: 00007860e53=
2f19d
[11868.037552] RDX: 0000000000000001 RSI: 00007ffdb9a1514f RDI: 00000000000=
00003
[11868.123327] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[11868.209105] R10: 0000000000000000 R11: 0000000000000246 R12: 00007860e53=
43e78
[11868.294873] R13: 00007ffdb9a151c0 R14: 0000000000000000 R15: 00007860e53=
43eb4
[11868.380648]  </TASK>

Tested on I210 and I225-V
