Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC2FBCD98C5
	for <intel-wired-lan@archiver.kernel.org>; Thu, 11 Jun 2026 02:08:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 53DBA4080C;
	Thu, 11 Jun 2026 02:08:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HhJRSeFlrWSk; Thu, 11 Jun 2026 02:08:09 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A2B244080E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1781143689;
	bh=LsfLRl7OuI64QZa7FWNmdbCqTIV71pSU3+SydKKbDjw=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=sY19lcr7YRYZbbgiDDwDTiTwURldkvRWuNrCvVru+7MtTJnPC5TPk0Cv6TzUM+GWd
	 7EgI1ywFB0BgtY+Jlc2Eu6WIYjajC2c6lB8Wa/rsCYRM5TvtHJoKJSBGg9kiBvJZgP
	 DX1NKbyIAlGs0FBhDhlz2Pg/MCuHEYfvpUtaCkcqfM5598sN8nfVObsOx2Zor5LFfG
	 bBgcmQTdeYlRpTMwIqMF/MtBPFHJkj+caHyVa8w4OED6i7+HkFweuKWxmS+0lJ/7nT
	 szLY+i4cl3NxyO73J18Wuqi9j2SPISd5ysJ+mFnQs7ZUzW5zuSvLmPmUayJo3rME7r
	 zEbCiGK58Ruhw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A2B244080E;
	Thu, 11 Jun 2026 02:08:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8A57B237
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 02:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7BCE140119
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 02:08:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id S_us5bRwn4ry for <intel-wired-lan@lists.osuosl.org>;
 Thu, 11 Jun 2026 02:08:07 +0000 (UTC)
X-Greylist: delayed 305 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 11 Jun 2026 02:08:05 UTC
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 31B5A40108
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 31B5A40108
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=103.209.128.204;
 helo=mail-m128204.netease.com; envelope-from=dawei.feng@seu.edu.cn;
 receiver=<UNKNOWN> 
Received: from mail-m128204.netease.com (mail-m128204.netease.com
 [103.209.128.204])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 31B5A40108
 for <intel-wired-lan@lists.osuosl.org>; Thu, 11 Jun 2026 02:08:04 +0000 (UTC)
Received: from DESKTOP-SUEFNF9.taila7e912.ts.net (unknown [221.228.238.82])
 by smtp.qiye.163.com (Hmail) with ESMTP id 41eb56573;
 Thu, 11 Jun 2026 10:02:53 +0800 (GMT+08:00)
From: Dawei Feng <dawei.feng@seu.edu.cn>
To: jacob.e.keller@intel.com
Cc: andrew+netdev@lunn.ch, anthony.l.nguyen@intel.com, davem@davemloft.net,
 dawei.feng@seu.edu.cn, edumazet@google.com,
 intel-wired-lan@lists.osuosl.org, jianhao.xu@seu.edu.cn, kuba@kernel.org,
 linux-kernel@vger.kernel.org, marcin.szycik@linux.intel.com,
 netdev@vger.kernel.org, pabeni@redhat.com, przemyslaw.kitszel@intel.com,
 stable@vger.kernel.org, zilin@seu.edu.cn
Date: Thu, 11 Jun 2026 10:02:54 +0800
Message-Id: <20260611020254.308446-1-dawei.feng@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <00f5f6e3-e80f-4c16-8d2f-f8148bcddfa8@intel.com>
References: <00f5f6e3-e80f-4c16-8d2f-f8148bcddfa8@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eb46b072103a2kunm4f921c24193a19
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDTkJKVh9NGkkZSE4aHRlJHlYeHw
 5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
 9ITFVKS0tVSkJLS1kG
X-Mailman-Original-DKIM-Signature: a=rsa-sha256;
 b=PUswkuEQxvP5C6A3S2B092O9Wh4MekFk1hfTk5VwxKgi1I6czgSuBzRYEDnO3wZPmVmONgPCZ4AGzHDYk1dfkYVv1DZD/mfu2tnfMqQIIfFJapZp5LsCaqa9M5WJ/fvP9OOLyNBoPWxn97LZswaohUtIGp3sHHY2AM5J88n9z2o=;
 c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1; 
 bh=LsfLRl7OuI64QZa7FWNmdbCqTIV71pSU3+SydKKbDjw=;
 h=date:mime-version:subject:message-id:from;
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=seu.edu.cn
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key,
 unprotected) header.d=seu.edu.cn header.i=@seu.edu.cn header.a=rsa-sha256
 header.s=default header.b=PUswkuEQ
Subject: Re: [Intel-wired-lan] [PATCH net] ice: fix memory leak in
 ice_lbtest_prepare_rings()
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

Hi Marcin,

Thanks for your review.

On Tue, 9 Jun 2026 at 16:27:20 Marcin Szycik wrote:
> IMO last two paragraphs should not be included in commit message,
> rather after ---.

The reason the manual inspection and testing commentary was placed above
the `---` line is that we were strictly following the example template
provided in Documentation/process/researcher-guidelines.rst. 

In the researcher-guidelines[1], the example explicitly places the build
and hardware testing disclaimer before the Signed-off-by tags, which is
why we included it directly in the commit message.

Please let me know if you would like a v2 to adjust the position of the
mentioned commit log details.

> Correct me if I'm wrong, but looks like unroll order is reversed:
> ice_vsi_stop_lan_tx_rings() unrolls ice_vsi_cfg_lan()
> ice_vsi_free_rx_rings() unrolls ice_vsi_setup_rx_rings()
> (was reversed before this patch too, but since we're fixing it, might as well)

You are right. I'll update it in v2.

[1] https://docs.kernel.org/process/researcher-guidelines.html

Best regards,
Dawei
