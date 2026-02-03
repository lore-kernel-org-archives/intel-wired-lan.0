Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E52EE83040
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Feb 2026 03:24:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0A29B607D5;
	Tue,  3 Feb 2026 03:24:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id btxnZ4SJZVM5; Tue,  3 Feb 2026 03:24:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 77EE3607D0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770089055;
	bh=r8R9mdHzi1BanaqnL4M8yh0UPiyKYCb+NNWJzWjF+Sw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=LKJJiO3JOhclmHkPJaGBD6+rWbaa/Kd3JLpEC7sKfyy6vFUWBE+p4LZZc+l/1U358
	 zfaqSlG5jptFYKbQ9HX674ELl6ONlMGV78HMk8L96nGGhF78iAcrXUvGGA9P5cPW3q
	 Nf2MuLDE75rsR+zMsjQej439zUQ9CBGuctZUTpugfoYl0dBmNDrPd/yUCsIauQBxNP
	 aMkPuAa+c+6+jd3CHeIkDj+GSGOsgZX0957nER3P5XUA9ZOtz7+VcyfyEGvIfSK0Ep
	 hL6fLtjtotSJENIe5xIqvRSPVd3GoEq8GaxFN3mf88LBSink6FWQ+Ik4CUDlcvt3cD
	 cPtnIK5reak/w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 77EE3607D0;
	Tue,  3 Feb 2026 03:24:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 40D991A6
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 03:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 231D8607D0
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 03:24:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YGpDHrA2Imb1 for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Feb 2026 03:24:13 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=49.212.198.91;
 helo=www2881.sakura.ne.jp; envelope-from=kohei@enjuk.jp; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 27C47607AB
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 27C47607AB
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 27C47607AB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Feb 2026 03:24:12 +0000 (UTC)
Received: from ms-a2 (182.51.30.125.dy.iij4u.or.jp [125.30.51.182])
 (authenticated bits=0)
 by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 6133NoIm047314
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Tue, 3 Feb 2026 12:23:51 +0900 (JST) (envelope-from kohei@enjuk.jp)
From: Kohei Enju <kohei@enjuk.jp>
To: jacob.e.keller@intel.com
Cc: aleksander.lobakin@intel.com, aleksandr.loktionov@intel.com,
 andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 edumazet@google.com, intel-wired-lan@lists.osuosl.org,
 kohei.enju@gmail.com, kohei@enjuk.jp, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com
Date: Tue,  3 Feb 2026 03:23:35 +0000
Message-ID: <20260203032350.3221-1-kohei@enjuk.jp>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <bcefc3ee-4704-483a-8271-01677e47eb8b@intel.com>
References: <bcefc3ee-4704-483a-8271-01677e47eb8b@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 bh=r8R9mdHzi1BanaqnL4M8yh0UPiyKYCb+NNWJzWjF+Sw=; 
 c=relaxed/relaxed; d=enjuk.jp;
 h=From:To:Subject:Date:Message-ID;
 s=rs20251215; t=1770089031; v=1;
 b=d66njHCGVShvbGRQ+ySH/5sqN0sBG/oUj2nU5hUCNmMhxM1IWjZJEZsQl1PGHdAr
 XFTvXL7d/+sjRHIgqLH4NqE/oS9lxoqeKj/Pm6Q4QFdFbiu82tQ25vYsnf+Yd17R
 p6SGkOPXlUYFcPUxO8OyHynb//4vMgAvVLNZvv43O68lfMR+CcoiHpQJMEBX39Lr
 Vif60gGuZxinMi5PvrhjGeZeEp1A96PS5t/i0PPdqB5+kmDS3RZcWv1MLCOjqRHQ
 8gRqx65KyZ/qXxRa6hcl96OqdcYzTRnhgo8Nrf/0aWeW1jSH/BbTHOE0iM+l5Abz
 n8xTh37bqSowjEV0XoN2YA==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=enjuk.jp
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=enjuk.jp header.i=@enjuk.jp header.a=rsa-sha256
 header.s=rs20251215 header.b=d66njHCG
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

On Mon, 2 Feb 2026 16:31:39 -0800, Jacob Keller wrote:

> > I see the Fixes: commit exists in only tnguy/next-queue.git, so I'm
> > sending this patch to iwl-next, not iwl-net.
> > 
> > Also IIUC dev-queue in tnguy/next-queue.git is rebased continuously, so
> > the commit hash will be stale soon, and I don't know how to handle this.
> > 
> 
> Yea. Including the full subject line should be sufficient for Tony to 
> find this.

I see :)

> 
> > I'd appreciate it if iwl-folks know the way to handle it. Thanks!
> 
> Ideally we can squash this in with the implementation patches and 
> include your Co-developed-by and Signed-off-by tags if you would agree 
> to that?

That sounds good, and I agree to do so.
If I need to take some actions, please let me know.
