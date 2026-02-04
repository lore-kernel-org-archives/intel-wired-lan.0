Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9BBE95392
	for <intel-wired-lan@archiver.kernel.org>; Wed,  4 Feb 2026 13:07:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5D999827FA;
	Wed,  4 Feb 2026 13:07:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Lr8hNoPQ6FRu; Wed,  4 Feb 2026 13:07:13 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 816A382521
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770210433;
	bh=VdXwBKcrE9BrvSzYjCxLIeWWc0bH8ZFH76JP/NHx/1g=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=5YbinseJtgrRfwkw3u60jmBf8seUgHGywFgb0RQwhgh0haUBljtmCteeUGEKkKO09
	 pz4G1lMVN+/M9WPbggQZKRe9IdPuDbC8yN4t4cwNeckqLXLPJyDLSQ9I+bmYdvmbwB
	 /kMYzcTX5oIpRD5QuRa6MF6Ag/ku1j5ks/DfTWfrwm8CMbmsc0dl3NC93kMkI3QQgz
	 op9w/oodMgEYI3BJD07o6FyFh8aSItXiq1rmvCzx6otyjQvzV1EW6cPp0gMjuLrgQC
	 /CYxgUCDry9J1fxUGdeJ5AiB7iAt7rHs88RuD/t/RD8LIV1UrP6TzIK119ubcwa0Zc
	 etOYnyxKYbqbQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 816A382521;
	Wed,  4 Feb 2026 13:07:13 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0F160F4
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 13:07:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3585405F0
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 13:07:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fPG4ph1sYlg5 for <intel-wired-lan@lists.osuosl.org>;
 Wed,  4 Feb 2026 13:07:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org E729440363
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E729440363
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E729440363
 for <intel-wired-lan@lists.osuosl.org>; Wed,  4 Feb 2026 13:07:10 +0000 (UTC)
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 614D6exD077301
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 4 Feb 2026 22:06:40 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: aleksander.lobakin@intel.com
Cc: aleksandr.loktionov@intel.com, andrew+netdev@lunn.ch,
 anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jacob.e.keller@intel.com,
 kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com
Date: Wed,  4 Feb 2026 13:06:40 +0000
Message-ID: <20260204130640.3597-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cfa11f8e-7207-4bea-843c-d111038c63c0@intel.com>
References: <cfa11f8e-7207-4bea-843c-d111038c63c0@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=VdXwBKcrE9BrvSzYjCxLIeWWc0bH8ZFH76JP/NHx/1g=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1770210401; v=1;
 b=ucRnCnyEEfDxN0RHzFIGClBjpdvjSfNjKnK/LC24pVLFJKxGYZ0xdHfmjYBav7s+
 F9AMB4KKM3QaCuKlxQWrci4cFDPF/6dcxRA1m5x16rM3b6TJB2Z/zOFXeMZ8I/A8
 Gt1NKknr8E6PcDB75qYtK8qoaRV3U27lnm+vW0XNRLqiYCMnxt8BpB2X6siXmfgb
 f4EKjNJJHEol6q+094RrCLGdX4UTkTRS6rZZkBTR9kBsHExYPY8XEkDLAs7CiXvg
 4vUgBlEPJ2Ub+vhBQTIVAphx7yfyXYHHep+2wjxVdOZjaZBjPy98miO2/LkEMiEb
 VHXhr7TBjrGOGHis4xa54Q==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=ucRnCnyE
Subject: Re: [Intel-wired-lan] [PATCH v1 iwl-next] ice: fix NULL pointer
 dereference when
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

On Wed, 4 Feb 2026 12:52:19 +0100, Alexander Lobakin wrote:

> > Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
> > the commit hash will be stale soon, and I don't know how to handle this.
> > 
> > I'd appreciate it if iwl-folks know the way to handle it. Thanks!
> I either way need to respin the series once the window opens, I'll take
> your fix into the series with the appropriate credits. Thanks!
> 
> Olek

Hi Olek, acknowledged.
Thank you for taking a look!

Kohei
