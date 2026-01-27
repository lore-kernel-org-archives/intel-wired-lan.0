Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D09BD3409E
	for <intel-wired-lan@archiver.kernel.org>; Tue, 27 Jan 2026 16:17:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EFED0822D2;
	Tue, 27 Jan 2026 16:17:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jn4chV-cHXeX; Tue, 27 Jan 2026 16:17:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2822E822BC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769530632;
	bh=ImWgDxvuF3PfCxAFBpCTagRl1yCUKxpwhQcbdzUaido=;
	h=From:Date:To:Cc:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=sGozm7P9z16gqJK42MMIkqCo+jX40PTWKJylBKbbbAQJy5NjFhl9TH2ZCkTb1vVR3
	 G5xdb+UxkHFn1Dl1PwXaDmZY5ewg959Qso4R+vP0CIrMUBbwP/TqqIEx30Gx3Qozqm
	 HrcbeL+4f8O3BBax2DObWunqA4hmXrUd6isO6vMDX5zkanHA4oZrmtxHJvBGVJlEnr
	 piRaMnTgD2wGN4eEpd1384bat++jSolRv1Ua0ZkDTZMJG0vpjg8tf3OeL3Vp4+0Nbj
	 X7cYWDHl7qpBzJkzb1IpqqzAV0Rgf0D86USkAlkOHx+UXLcrTUIe+umFU/6L9VgXKn
	 OoAQoL8EMl13w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2822E822BC;
	Tue, 27 Jan 2026 16:17:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 857DF118
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:17:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 68D7F40BF0
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:17:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id agzxKjolkkx1 for <intel-wired-lan@lists.osuosl.org>;
 Tue, 27 Jan 2026 16:17:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=horms@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 9BF9C40260
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9BF9C40260
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BF9C40260
 for <intel-wired-lan@lists.osuosl.org>; Tue, 27 Jan 2026 16:17:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 113056013B;
 Tue, 27 Jan 2026 16:17:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA186C116D0;
 Tue, 27 Jan 2026 16:17:06 +0000 (UTC)
From: Simon Horman <horms@kernel.org>
Date: Tue, 27 Jan 2026 16:16:55 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260127-const-name-v1-1-9c84615c55a4@kernel.org>
X-B4-Tracking: v=1; b=H4sIAPbkeGkC/x3MSwqAMAwA0atI1gba+gG9irioNWpAo7RFBfHuF
 pdvMfNAIM8UoM0e8HRy4F0SdJ6BW6zMhDwmg1GmVtrU6HYJEcVuhI0yzg5DUemihBQcnia+/1k
 HfK0odEfo3/cD4OmOBGYAAAA=
X-Change-ID: 20260126-const-name-902cabb35134
To: intel-wired-lan@lists.osuosl.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
X-Mailer: b4 0.14.2
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769530627;
 bh=WU3PWO8MGnvuCjUuzy5ZCcTuhPmzibJYY7sZ+sUEuGM=;
 h=From:Date:Subject:To:Cc:From;
 b=bgMgpG0GX5YumL2WfrfXQJi4LH60lD5EdnN9vgvoYuhR+bxMecTD41F2rxNBS1o9j
 MkTKc0LwKr8J4dE2PZKIlTh6LvfO7KYil4Bob/lEM8mvLOsPnMIyq8HXYpd3g+aXQD
 nHJPjrQmdKAieWJyPwqeVj5YzFIZu82IF4EmV6j51FO5b3+F+I4cl1vDMmMQqTQl0i
 ntMip3n8ZlZXJsfN07n3TcHU7Xn4GhN/aSaxOb7lalIsJ+3Th7c0TMfu4+5u9Tgfq/
 07IpoLEXkRHIH1JYRxEFu5ag307WstWfrruuhngbOgE56F0syGw+aptIF6FV93CxuK
 DE4u7hEdGB+Xg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=bgMgpG0G
Subject: [Intel-wired-lan] [PATCH iwl-next] ice: Make name member of struct
 ice_cgu_pin_desc const
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

The name member of struct ice_cgu_pin_desc never modified.
Make it const.

Found by inspection.
Compile tested only.

Signed-off-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
index 93901bccf1c4ae1e1782e7a2af4322a6777d0b6c..87aa4cfc5a463f74509ecc4cfbc00e06f26cab5c 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.h
@@ -258,7 +258,7 @@ enum ice_si_cgu_out_pins {
 };
 
 struct ice_cgu_pin_desc {
-	char *name;
+	const char *name;
 	u8 index;
 	enum dpll_pin_type type;
 	u32 freq_supp_num;



