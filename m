Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A1A5EDF17E
	for <intel-wired-lan@archiver.kernel.org>; Fri, 13 Feb 2026 16:00:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BC91C41DB1;
	Fri, 13 Feb 2026 16:00:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4_NvM_iwrAIv; Fri, 13 Feb 2026 16:00:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EE7B841DA7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770998412;
	bh=umAF/ss9ZcJMBNAXS2atoM4+Zm2UxJfpsD4eEBlFQgU=;
	h=In-Reply-To:References:From:To:Cc:Date:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=pXj2Reemm7eoJ01zCzLWUgJ1V2r1+Zdb7G3OWf002V2+0VmrVHFa84/hXJcJAcaCL
	 vPvcqKp4orr5aTl19vfVbnn4gboEw9Aa2CvZoWADNHGE8VrKYdoSOybOrRFUTT5v5m
	 Q62AZK4leBMobf+nTgzVZakMNdsQvR4uQ+uBbzPFPEBbxZqzKRN2qVgajLogKfkD8g
	 32t23qiLrU4TdgurmO1A3MKO8xU6yDlpAADX37YKGkQFNMs8PbOI/trsmg4+5wNSZr
	 HLT06sOClmTIHQ42OH2wkHTpeoJsO5IdKKxMqyor3LgxYp0sypkPd9bps7PTw+9G0H
	 C6g/t5Uef+lxg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EE7B841DA7;
	Fri, 13 Feb 2026 16:00:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 80901255
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6ED0A821F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ZJxROLfEFzxX for <intel-wired-lan@lists.osuosl.org>;
 Fri, 13 Feb 2026 16:00:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bot+bpf-ci@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 9CF9181EC8
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9CF9181EC8
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9CF9181EC8
 for <intel-wired-lan@lists.osuosl.org>; Fri, 13 Feb 2026 16:00:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 807CB6132F;
 Fri, 13 Feb 2026 16:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCFFEC116C6;
 Fri, 13 Feb 2026 16:00:07 +0000 (UTC)
Content-Type: multipart/mixed; boundary="===============2200788076600515838=="
MIME-Version: 1.0
Message-Id: <2b50829f1fb3dd6374d7f7a3bd10073560752f79b56029e9ab1d02e0d7febdcd@mail.kernel.org>
In-Reply-To: <20260213-bpf-xdp-meta-rxcksum-v2-3-a82c4802afbe@kernel.org>
References: <20260213-bpf-xdp-meta-rxcksum-v2-3-a82c4802afbe@kernel.org>
From: bot+bpf-ci@kernel.org
To: lorenzo@kernel.org, donald.hunter@gmail.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 ast@kernel.org, daniel@iogearbox.net, hawk@kernel.org,
 john.fastabend@gmail.com, sdf@fomichev.me, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 aleksander.lobakin@intel.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, haoluo@google.com, jolsa@kernel.org, shuah@kernel.org,
 maciej.fijalkowski@intel.com
Cc: jakub@cloudflare.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-kselftest@vger.kernel.org,
 lorenzo@kernel.org, ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, eddyz87@gmail.com, yonghong.song@linux.dev,
 clm@meta.com, ihor.solodrai@linux.dev
Date: Fri, 13 Feb 2026 16:00:07 +0000 (UTC)
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770998408;
 bh=umAF/ss9ZcJMBNAXS2atoM4+Zm2UxJfpsD4eEBlFQgU=;
 h=In-Reply-To:References:Subject:From:To:Cc:Date:From;
 b=dOCDmnZvocrVImcWNhWqNPAF4totSSPUucNKUsGS7iDIJta2veoCndZ0s6FbWPuUQ
 z+rFcHPQPQGHBT6YTqMj86RNJPFcgaW2oFmdcclf9R/+taQlTcD/YwhcwC0K7JwYMA
 P22PZjf6e0c+YJhILTjngzjfr3h9P2yHkdnZHyYN7iha8HW0XRdCfMK2tXCqSJWB9b
 nf2wV82FA1iTdsjNArs7z8cUTOkqxSro3B9bgCcX1IwY21obnbDpEVyV42fLNjU6r4
 MSQI6U5Avn5BZDkGuctNOgDmD2QsKsE5RH8zrwZdIl4R+Y1ltsbpkUaAwZElq1F9EP
 jXlcOsROuQGHA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=dOCDmnZv
Subject: Re: [Intel-wired-lan] [PATCH bpf-next v2 3/5] net: ice: Add
 xmo_rx_checksum callback
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

--===============2200788076600515838==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> Implement xmo_rx_checksum callback in ice driver to report RX checksum
> result to the eBPF program bounded to the NIC.
> Introduce ice_get_rx_csum utility routine in order to rx cksum codebase
> available in ice_rx_csum().

This isn't a bug, but the second sentence appears to have missing words.
Should it read something like "in order to make the rx checksum code
reusable from ice_rx_csum()"?


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/21992879200

AI-authorship-score: low
AI-authorship-explanation: Garbled commit message sentence and non-native English errors are characteristic of human authorship; AI tools typically produce grammatically correct output.
issues-found: 1
issue-severity-score: low
issue-severity-explanation: The only issue found is a garbled sentence in the commit message; no functional code regressions were identified.

--===============2200788076600515838==--
