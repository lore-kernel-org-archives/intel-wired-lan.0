Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 223F5CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 13:50:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4EA6F406FD;
	Sun, 11 Oct 2026 13:50:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id I0UwlXW2ozge; Sun, 11 Oct 2026 13:50:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 6F0DF40782
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791726623;
	b=VS1j3gemJGMnpyoKsUoxJHOCOEkS22vduolSIEe/pyHbOo4fvQFPBP4QBeRvVXPYbyZH
	 I+4MYi+iYJxCT4eQXZWp8ZkT3SsgXd31/zhRaB36KOgB/kaWGH+edpsqA7lFgkkv/g4di
	 3UiPVtxbqnYpXZstJXMMRAF0fInArhpdpoASEfvLXLtkII6BTsVMTjIKgAPoz14PTuXPZ
	 FR3x2vgT21dTxKDHI7VaIplcG/ZO1FJxI+JuRiHBlECepsl+0FiffUpji9cDkajYAoJ4w
	 DuAa7zJ84AYA8Hk7jyVvRjYJeEZ1EVKJFIKAVSACxLOiCkP8k5s8eWjT5EMPdjYO9EA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791726623;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
	b=eORApvSHoQu8dgXiWWGkcqzRBr0uTcla4VIwchRxzX917Eg7ie11kFEV/cXHRIniDyP/
	 shmFnSXsjQpze/bHN7aC7B+CNk6VHTbIPkUYv1wuwsjE6jtPcha86LQkvhNg6zaJoM5eK
	 UY8L+dCP85hdMAB92ux8bURX2FJEqk4Kkus0Bq7bajtBUk7FMh5K4IrPA0rhfOo/889Ps
	 +BJhHwQvFgpj7h2M2L7Tq8wuv3A9LVT6dYg/TlFaWZI0WfpgJaZf4OnafFsgWEnISTqYm
	 EviRZnvKe6uKFqFVWSVw9W3RhZ5LKZvSPZqlTRo4DUiTwu8BkbUf7LhKYm85qKlf6dw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791726623;
	bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Wt0Ryibt+JHOQzL48VYI9EjrfCBas82BUV4DvGPQljxlFC8KZfkLU+N6HcDYDmWXb
	 vvEjQend+E4P3CLgERl3HJbKfopW95zfhYY0tFNqNSdK+egyaxiDx9CG9/iJkHeitv
	 WanJeTK7mkebmViyDVea1FSOqjy14Mctk1m+/HUOepvaXAkR/cczmfL4KRm/+G4K+g
	 1rAPifjMtHP7f4TkYuGsJsq7YIZaLaYxY4Fla24x+kfQbgrZwTnbjL64yF6zmHA36S
	 g+DVa1W3yl73vsA6VHVpGXrNgU809OFeQlpfEAB5brCIW1Y5kDz5h5zW8lQISaGnzQ
	 FgAtIAp0I5WSw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F0DF40782;
	Sun, 11 Oct 2026 13:50:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 107482E0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EA62280D34
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:21 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OsPWPEu0xp0z for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 13:50:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org CDCF480CCE
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791726621;
 b=q0iuB+uZU/oJ6P0FuJ7pw2OGoHmOK+Y4VPSE2N2wN4/HULR/3pVt/FOU53X6czk/jnZA
 H8AbpkN8hBwCgkCv+4kndrK5AIhLn2k+mPVKLG+b9At/g6dQNB0aUXZzC+O08dmCNrZ0S
 WnW5SOu9+N7PKQ+szs6j1rMV+EyWmZKiYUAsY+iNwtDUetk0/py1JfHDarfUuZWVwmtGb
 XAAAfI8YlQhFFINcxfZxO4UadVYJ8PrO5946AkfmEOe9UB/YRmnvjaVsLBjalXpQpuSwv
 CYkfFR1yY64I2XPSlUgw/TddOZcNDuMqjydkMjg1m5zQ7p10cO3leIWVHP8ZMX0MBfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791726621;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
 b=TzBscFS6OJexDWx4RPVJmeZJJTVf3r0Il3jAkP/d/z3rboUVbk5YOeRYCVRkEpXggEVC
 2vRQjg4qWsk0/Cw8EDrE/dJfsEhsL7dJNxBfPqV7uhkQtlKqdZb7Wn6Uc8WxcvGpmj2C/
 SsDJyOmldCOo79VOQKTIz7Tdn9A/8ap0t0bQVJ1o+Bq8c9W5jqUCKbS4k2EWOAli9zSIG
 SSQpVZXL35zGb1PTxmBAX8mnE3sxWo1pcvG433Av+Y9o0d/tmQsjC45i5IEY3McNr6bp5
 2v/bE2ExepXWakL5GUtm1nAgfHNdSKr3PdbahbC3J+WSe5VVBso9kdVzqwluZafXkHA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PuqoWUrT; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=mheib@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=PuqoWUrT
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTP id CDCF480CCE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 13:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791726619;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
 b=PuqoWUrTKjP0YCrZfk74MNYS2LJeXrYfrM5TweMvYwfI/1bTBJOdUPcBCJGFWGbn74bbEY
 M0nnwIRtp0ohwAJBf4NnUneOEzY6qBng6WWJD3Cz11cw2gVwoaGl06/5idzo+8fUgRBw7D
 8D+V6fbv82cbEWlDaTFQW3LCYnibr2g=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-9hQmOCgNNQKNJdLjhZQX6g-1; Sun, 11 Oct 2026 13:50:17 +0000
X-MC-Unique: 9hQmOCgNNQKNJdLjhZQX6g-1
X-Mimecast-MFC-AGG-ID: 9hQmOCgNNQKNJdLjhZQX6g_1791726616
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a1813fea7dso18021615e9.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 06:50:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791726616; x=1792331416;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hFShVyPUqxQREGkQTuaTht58xKUWf1ITzFTMxIHNK3o=;
 b=JwF0e+B7/KY7oP/6XqJf30zAvuQOPE7nvWxuQrkYVgmWW502rl4Bl6ocC7wdNj3DH4
 vZ5JDJPoYevRs9wDU4RHN+rQe7AAGuSLfRI2dQG/Ea70ucXZv84LzQSjiQWKzC0jpoN1
 /aA2jXUjALMsQx+5EOquuzEwpjSejwwxxHIIyZQBU98PeEOfebgDFlsO+apb7HEGL3yS
 11FY4K/oEZipjJPzix9oG1B4beXgzFsh8oeZ35a22EMjM3F2SrToDZ55/vRPC5k8VKLV
 g8s5080YWWoNMRD750fTufRSHdd2AvfAo1+frbWKFpdBQ/LkfUtujT1/vQiHcaJ1AXs2
 wBbw==
X-Gm-Message-State: AFq9FYIu0iOQZ6X6Dem/f56wD5pJxeJzmH+j84uI5lgqkMjDxZ0rraXP
 pmcDgRQiLtlpfe5ukHfSt52UzAKhJQtIziSaGWOYmjcFhbY1BHYKkSlGgx+lp+k9zTH4xCYYClx
 B7orGoimqdbz+F9a4Nt0OeqLkGoSUV+vhq5jtZVXJlLAB9haOD3JKkHc0h6MkzsOrUFbZB/vh53
 4RYoMrxWiL9QKcOh+n3EfEhF2/dwFgFVTjEd+B+YmL9KP8utwq0rg03Q==
X-Gm-Gg: AYBFou1/5FcNQykgl2lidZmEGD+Llcewu1LGlyueDpDqk03rT1U8a/gOn75Ag6PgCcn
 7os2zmw3hHZ2Erid4bo7PIB3NrE/WdpX3eMlLZ5R9auBHOfAan4pdqGGAU4ALlmgE+vPqZ7+WFX
 s5UAmi/Byq9AyhReZ95d0ucv9mXm29Ia6xmnbvbHP4RHGz8MzwfpyMF4WsN+FYt8pL1RQ2AYGZy
 La209+wCTw3fMtAbWZO2ZbmW7iXpCdtwzDeCjN9bZdikPaV1c/fJvqoILC7qHghJ2Vn8eCb7xI3
 kmFPXTbveusA89+vbW+JdLvsfwrLrAsAix8wzPiw2uMOlu67uq8sy3P0ZVgwZQ0LhHDTD0xXqT3
 nNKs6AC5udUurf+5i5L4AuPcA/chqg7Ir
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a18e48d45cmr139042915e9.16.1791726616107; 
 Sun, 11 Oct 2026 06:50:16 -0700 (PDT)
X-Received: by 2002:a05:600c:608d:b0:49c:cee0:e7c1 with SMTP id
 5b1f17b1804b1-4a18e48d45cmr139042465e9.16.1791726615631; 
 Sun, 11 Oct 2026 06:50:15 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 06:50:15 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, horms@kernel.org, Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v6 1/2] i40e: move ATR sample rate from ring to PF
 level
Date: Sun, 11 Oct 2026 16:49:51 +0300
Message-ID: <20261011134952.54887-2-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011134952.54887-1-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BRklJg7Pg-bMTqEAuZw4cC9gUKOIdTsfguhw1_mZLj4_1791726616
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

From: Mohammad Heib <mheib@redhat.com>

The ATR sample rate is currently stored per-ring and initialized when each
TX ring is configured. Since the sample rate is a global policy that
applies uniformly across all rings, it makes more sense to store it at
the PF level.

Move atr_sample_rate from struct i40e_ring to struct i40e_pf and initialize
it once during i40e_sw_init(). Update i40e_atr() to reference the PF-level
field. Change atr_count from u8 to u32 to match the sample rate type.

This also changes a user-visible behavior: previously, re-enabling ATR via
"ethtool --set-priv-flags ethX flow-director-atr on" did not resume
sampling until an ifdown/ifup or PF reset, because the per-ring sample
rate was latched at ring configuration time. With the PF-level rate always
initialized, the flag takes effect immediately.

Trigger a PF reset when re-enabling ATR so that fd_ena is re-evaluated
in the TX queue HW context.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e.h         |  1 +
 drivers/net/ethernet/intel/i40e/i40e_ethtool.c | 12 +++++++++++-
 drivers/net/ethernet/intel/i40e/i40e_main.c    |  9 +++------
 drivers/net/ethernet/intel/i40e/i40e_txrx.c    |  6 ++++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h    |  3 +--
 5 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e.h b/drivers/net/ethernet/intel/i40e/i40e.h
index a9d79bbd3ea7..528ef329a647 100644
--- a/drivers/net/ethernet/intel/i40e/i40e.h
+++ b/drivers/net/ethernet/intel/i40e/i40e.h
@@ -486,6 +486,7 @@ struct i40e_pf {
 	u16 rss_size_max;          /* HW defined max RSS queues */
 	u16 fdir_pf_filter_count;  /* num of guaranteed filters for this PF */
 	u16 num_alloc_vsi;         /* num VSIs this driver supports */
+	u32 atr_sample_rate;
 	bool wol_en;
 
 	struct hlist_head fdir_filter_list;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
index 0ae50d7f3465..bc9b4a2bc23b 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_ethtool.c
@@ -5300,6 +5300,16 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 	    test_bit(I40E_FLAG_SOURCE_PRUNING_DIS, changed_flags))
 		reset_needed = BIT(__I40E_PF_RESET_REQUESTED);
 
+	/* Re-enabling ATR requires a reset to reprogram fd_ena in the
+	 * TX queue HW context. Skip when FD_SB (ntuple) is already
+	 * enabled, since i40e_configure_tx_ring() sets fd_ena when
+	 * either FD flag is active.
+	 */
+	if (test_bit(I40E_FLAG_FD_ATR_ENA, changed_flags) &&
+	    test_bit(I40E_FLAG_FD_ATR_ENA, new_flags) &&
+	    !test_bit(I40E_FLAG_FD_SB_ENA, new_flags))
+		reset_needed |= BIT(__I40E_PF_RESET_REQUESTED);
+
 	/* Before we finalize any flag changes, we need to perform some
 	 * checks to ensure that the changes are supported and safe.
 	 */
@@ -5431,7 +5441,7 @@ static int i40e_set_priv_flags(struct net_device *dev, u32 flags)
 				case LIBIE_AQ_RC_EEXIST:
 					dev_warn(&pf->pdev->dev,
 						 "FW LLDP agent is already running\n");
-					reset_needed = 0;
+					reset_needed &= ~I40E_PF_RESET_AND_REBUILD_FLAG;
 					break;
 				case LIBIE_AQ_RC_EPERM:
 					dev_warn(&pf->pdev->dev,
diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index 774bfc595aa9..98d2fcdcee68 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -3459,12 +3459,7 @@ static int i40e_configure_tx_ring(struct i40e_ring *ring)
 		ring->xsk_pool = i40e_xsk_pool(ring);
 
 	/* some ATR related tx ring init */
-	if (test_bit(I40E_FLAG_FD_ATR_ENA, vsi->back->flags)) {
-		ring->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
-		ring->atr_count = 0;
-	} else {
-		ring->atr_sample_rate = 0;
-	}
+	ring->atr_count = 0;
 
 	/* configure XPS */
 	i40e_config_xps_tx_ring(ring);
@@ -12750,6 +12745,8 @@ static int i40e_sw_init(struct i40e_pf *pf)
 		}
 	}
 
+	pf->atr_sample_rate = I40E_DEFAULT_ATR_SAMPLE_RATE;
+
 	if ((pf->hw.func_caps.fd_filters_guaranteed > 0) ||
 	    (pf->hw.func_caps.fd_filters_best_effort > 0)) {
 		set_bit(I40E_FLAG_FD_ATR_ENA, pf->flags);
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.c b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
index 2032465c9b7c..acb47a9fd86f 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.c
@@ -2887,6 +2887,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	struct tcphdr *th;
 	unsigned int hlen;
 	u32 flex_ptype, dtype_cmd;
+	u32 sample_rate;
 	int l4_proto;
 	u16 i;
 
@@ -2898,7 +2899,8 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 		return;
 
 	/* if sampling is disabled do nothing */
-	if (!tx_ring->atr_sample_rate)
+	sample_rate = READ_ONCE(pf->atr_sample_rate);
+	if (!sample_rate)
 		return;
 
 	/* Currently only IPv4/IPv6 with TCP is supported */
@@ -2950,7 +2952,7 @@ static void i40e_atr(struct i40e_ring *tx_ring, struct sk_buff *skb,
 	if (!th->fin &&
 	    !th->syn &&
 	    !th->rst &&
-	    (tx_ring->atr_count < tx_ring->atr_sample_rate))
+	    (tx_ring->atr_count < sample_rate))
 		return;
 
 	tx_ring->atr_count = 0;
diff --git a/drivers/net/ethernet/intel/i40e/i40e_txrx.h b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
index bb741ff3e5f2..be587f804e7a 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_txrx.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_txrx.h
@@ -372,8 +372,7 @@ struct i40e_ring {
 	u16 next_to_clean;
 	u16 xdp_tx_active;
 
-	u8 atr_sample_rate;
-	u8 atr_count;
+	u32 atr_count;
 
 	bool ring_active;		/* is ring online or not */
 	bool arm_wb;		/* do something to arm write back */
-- 
2.56.0

