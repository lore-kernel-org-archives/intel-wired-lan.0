Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6CCC79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 17:11:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 341EE40AFA;
	Thu, 10 Sep 2026 17:11:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jv_GczSaS5Yx; Thu, 10 Sep 2026 17:11:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 1CB0940AFB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789060305;
	b=JIuYKc1j3Gu6cCQrJQb4bNRD8E+pkd9zqUTAXslYT7eGs3/qYbBklcWlBWDS33DpOUvF
	 1eWt0oRjI9bjFt/LGBJ5Z7C4QPD26KFj2WzH9tbkDu3Ch37d6xv1tyEk46Cx90PuzW460
	 ub977+cIasolsbIxoAbF9tRetzbSXRaHsHlkg27hvtm7p/B3bkw5DqTPwp0b9HKekCn0s
	 3c53X37pRqs3jHl6QAFihiFSRTbs+zSmC6j7r2nu0oc2+dg/xhSXdGyUQKfm3c9gNms9M
	 IMk4l4bGaMrPW6JRbvqCdkM5m17DcXUQ/IdoXDFfXcYc9cAHZLfSw1RWvG6isr/TpyA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789060305;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
	b=WhPsB3hhUZxPomZKjgPgVPXzY1Qv+963TMzljmher7fcMRqecivaIGcOgR6pegaWts9D
	 C3ZkLaiZtBzlLv8P5RPnfNi6ieyDEKDQFWe3zhY38qdDOg1E0gLyPOl6itxuOXFF9XVE/
	 oxXKAzctUPgzNSnbHsoCDxlVsfr+IppzscyQD5E7hyWyb/140cVJ5dox4I36oKurugq+k
	 SaCVdmclKzM5iI0w1sg33x309iyRnVAkxu8fV3ZgCfqJbISzIcJx9Jqj4BscWBxa8jFLT
	 E/hAl8w+GiRy2LTpbE4lita3qLAM4DW3qFPDP0gtIdJM6Kb4dsYU5q0ZC0Y8zGq9Y/g==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789060305;
	bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=IEH0fBtRoO9UNH1uimaPFbaCPRt49FnrVaQ8lWNqF4ma8LnBvobudaTCQ8GqhQWjX
	 dPb6x6nKhos8r/P+ubJ3SHdOzZ0TbFBsGeYMEmcloiXENyhHxIPENzITmGPW6t12Xx
	 G1B587i8fH+CQ9kYdYw9Ng4s7ZtmvGb5I6VOVhO3oU26bnMcUIjMDFU7FStT5g39ND
	 cFQC7td/uUUwDFodAgEei9C1FTW2rP59gqZHGDjTGjb4NjkEnQPJUWDN/c4R6nDesZ
	 KWAReWQHQ6pd++PgzS/DSIMH7JrUH6gT8RqII+Tcxl1TwL8XGcUZAnRDU5LoOePPn0
	 1xf8vqJLBHWCg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1CB0940AFB;
	Thu, 10 Sep 2026 17:11:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id CF478268
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:11:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CC05181144
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:11:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1Mn5SEm8dSr9 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 17:11:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org A3D9F810F8
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789060301;
 b=JY3sl4I3mUFH5JnWAUFI6lGPzo83c9yfzU30XDa5RKxiyIlIULSDq2rSy+evwTO5GsJ/
 ZHO33RY5zr8n7srDG7/fe2/4W82FmxI7M3PuyEWJQzAcy4bfWOUPNXfvC/0U2rRxA14/V
 xxWqm7rriDK3KWDTXixGLLUEQx7Ui9EofV+svGKIjvjwl95mQIgqw7hjxHDUGisShQXlw
 EHCyfpfXuyzYHQS/JjVm1ulxlI+NgoB3A4AwmmmoOBkRSs/go0VfIgUuL6ehp8pUBOeaR
 clQF7lWiJdOJcbPT1X3nBtYBrm0bGGx8Mf0tZ2fNZXQOifJTq6RGfgX8QMwiqmQtlTw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789060301;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
 MIME-Version:Content-Transfer-Encoding;
 bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
 b=SyQXQgwxW50xeTG8mqWejR9QI+A2/Ls/DUpuc6vyf/QuaBQ5Xaq8KSdZ4LsPqhwCdj16
 FJcIDDoA2ZIV94WKcNWSYRwrJMrfO5SNJXNWyppqWp1SZpv0ixi5AI9eKAJSllX50Wf7L
 2Agrnj32PoTsI0FM8NEF31sA7MpI+YFLkMLMsTrquGPaaLuFQtE5u6f58pxMLfo/rd3nf
 nbX8L0iBiiQKoIyBcmkFc8yPRExS+XLqBKgBNJk+eKCFs2MDjnZB74EFZSiE158vedhDc
 z4cmDg2OZXH5cahJkclYbJ1OVQnY2/Y98p1GqNfQxXRQsiLJPjAQsmXulJ1cX4Pvhsg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=DAtynGF7; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::b132"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::b132; helo=mail-yx1-xb132.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=DAtynGF7
Received: from mail-yx1-xb132.google.com (mail-yx1-xb132.google.com
 [IPv6:2607:f8b0:4864:20::b132])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A3D9F810F8
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 17:11:41 +0000 (UTC)
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-67124ad7615so33075d50.0
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 10:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789060300; x=1789665100; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
 b=DAtynGF7ZlTmuRF0LRzzprJG5YBv0IfwCsWFYY4NTxaX/wTE70hRhknERUoJ7YBquk
 4cF/l8oh5Yzn4cDSX5wO8gWfA2AdzWRiyuwp57lSTtHVcCEjrQraOfSdZti7sWoqmtBF
 t4HKJHLXLcobpNRshxSTdOQW7dymHJcJ1Q4aiGFxDPbyw8/hAWV0VEZPzG4g6wWTfpJX
 bRh5SZVkvsEieh9Ma97KMNArV8qQ1hk30+VaHVDFKzio0lic5iWCyGo0qAt+V9GbbDJh
 mYqcJBNtOBTOZDEvLhi7PAhqn4pFvIQCs4jY54svarwHeksVaDqNPcocKYpvOIhR/kfb
 SsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789060300; x=1789665100;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=dL4nSkvq/uP2qyvgHqZ6XOcTRLRK6KiP/KdTK4+oACY=;
 b=FNeQ6t1rhKEPnvWMH3r8DuQCcH/cjXrLS56j/3fdBPRUaumZZuzL1da6sexJZEN5Gn
 AwrFMggUNiJJ7NXstUR0URJtrjrn1Ti7SvEoeJKoeTpRj1Vw61ObmEZmSWbwuPa0Is+1
 borvwnf1ya0d/bBBGOWX9c4qQl0w3oH1C6o1KqnENn3HTYEcm2O4cYCihfUpp6luWGvD
 L1QXQCUp/Q4tGpuDdmmiA7Y5VR9JPw9XLpEVgi8bnyUpJ09sBR/MZrmZDMbiSMUes85O
 Ve7IZmqzDsnE0b9rwY7Gf6tD2t/fPf3UpjEMSy6CxaX8OC14ypkoZ7PuOd7Cjh8FSCsg
 fLsA==
X-Forwarded-Encrypted: i=1;
 AKwUvByEGIwNM7FnZdNRKdhdlWp6X5BadhmPcezkn1GffAF9IiDXZ9eeFTRLseVY8I0uj2vPxMtCHlNxtDFMivnOEb8=@lists.osuosl.org
X-Gm-Message-State: AFuF++mvFK0/M7sXKHXb35n6fWc6VOckv8/mgE+5m971A+3AUFO736id
 bWjWSjkJuoiNpEN2dapV6C8FjROKtLeJCRSj6OMxsWUoPQmG0S//8yZV
X-Gm-Gg: AYBFou3bM0ka4z/QoAMOh61g1WuaOtZKC//QwmtT1yhUz3u3g8rzozG0MgkltzdNCvb
 LOhIJ3+w3WDEhJXY//4HtqI3Z44PzEmE8S9yPZdKEZGy1h4dSv8JGlAiyIr8LVZ0HSabsNF1wcy
 XtNlGG1rdd92+x50Mmfd9gF1nOlswm0/bNndHx+0lfy3DewtlTMKqqSoHkSMSFjpPOiZjIpHuhr
 2YqdHTnKMG9LWRgvsOoOwlDn4Jr9Jm1gZVO7JDyYI55+kk1mZ4TYU+ZTtKMR2ZFz754V4+9aOEE
 jPKCJsZA4CbSPY5VX+Wa0QvSdMB2uJ+VefgctG0KOGagpIl33KIHRh6q/lh6spnScLzpbqzQlIT
 LsPgFCHRt0DCjCu7BJKToyG4wF1g0LrGZt8DmMLHyeXKkYCLjzWsMzig7UKyLRtj9D+isJsUa4v
 EH0ZvliLABVUxq+e1jCXYCYORm0hgPm2CSDr4VRyGqbeuF7nQE7pIfQHmCOgAILg+dwtuTABAwi
 Vxj4JCC6Ve7ToS0uRcG8YEprZcp0iMTFxv23g94ujBImAtJRK4yqppl3NIr703/0Y6O0D5aRgb4
 /D/bVtW6cw==
X-Received: by 2002:a05:690e:4852:20b0:670:4baf:c493 with SMTP id
 956f58d0204a3-671246c1565mr108731d50.55.1789060299867; 
 Thu, 10 Sep 2026 10:11:39 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
 by smtp.gmail.com with ESMTPSA id
 956f58d0204a3-66fb48ee9easm14059834d50.8.2026.09.10.10.11.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 10:11:39 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, andrew+netdev@lunn.ch,
 Willem de Bruijn <willemb@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Joshua A Hay <joshua.a.hay@intel.com>, intel-wired-lan@lists.osuosl.org,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v9 4/7] idpf: support pacing offload
Date: Thu, 10 Sep 2026 13:10:23 -0400
Message-ID: <20260910171131.2532487-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.1007.g17ff1f9808-goog
In-Reply-To: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
References: <20260910171131.2532487-1-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Willem de Bruijn <willemb@google.com>

If skb->tstamp is in the future, program this future delivery txtime
in the transmit descriptor.

TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
the FQ offload_horizon is configured. But device support for pacing
offload must be more robust: it can also be reached through SO_TXTIME.

Bounds check txtime. Only packets with timestamp between now and the
horizon (max_pacing_offload_horizon) are offloaded when pacing offload
is enabled on the device via pacing_offload.

Negotiate the feature with the device using virtchnl. Support is
conditional on
- splitq mode, where tx and tx completion queues are separate, so
  completions can be returned out of order.
- flow scheduling mode, where completions can arrive out of order.
- PTP to ensure the NIC clock is synced to CLOCK_TAI.

These features are negotiated per adapter, but expect all vports to
uniformly request splitq (req_[rt]x_splitq) and flow scheduling
(flow_sch_en) when available.

Packets beyond the horizon are sent immediately with the overflow bit
set.

On device reset, EDT capabilities are re-negotiated with firmware.
If re-negotiation succeeds, dev->max_pacing_offload_horizon is refreshed.
If pacing offload is no longer supported, dev->max_pacing_offload_horizon is set to 0.

Must not be called from netpoll due to ktime_get. But netpoll does not
generate packets with EDT, so no explicit test is needed.

Do not fail device initialization on EDT init error. Log an error, but
continue without EDT, similar to PTP.

Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Joshua A Hay <joshua.a.hay@intel.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>

---

Changes
  v8 -> v9
    - on device reset, re-evaluate and refresh pacing horizons
    - check boolean pacing_offload and use max_pacing_offload_horizon
    - update commit message regarding reset re-negotiation
    - small typo in changelog
  v7 -> v8
    - remove unused variable np in idpf_tx_splitq_set_txtime
  v6 -> v7
    - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
    - only set horizon if splitq with flow scheduling
    - fail on illegal granularity 0, rather than use hardcoded default
    - zero edt_caps on negotation error, in case of call after reset
    - cache ts_gran_pow2 in idpf_tx_queue to be in hot cache line
    - similar to FQ, add offload slack to avoid pacing < 400ns of now
    - remove now superfluous include netpoll.h
    - reverse xmas tree (1x)
  v5 -> v6
    - move EDT caps from virtchnl2_edt_caps_ilog2 to idpf_edt_caps_ilog2
    - do not fail device init if EDT init failed, same as PTP
    - replace netpoll branch with commit-msg comment
    - add commit-msg comment about device reset
    - add commit-msg about behavior beyond horizon
    - add commit-msg about trusting EDT capability response
  v4 -> v5
    - fix kdoc: idpf.h:738 struct member 'edt_caps' not described..
  v3 -> v4
    - add EDT virtchnl negotiation
    - move endianness fix to its own iwl-net patch
    - update commit-msg: check is against pacing_offload_horizon, not max_..
    - simplify assignment, avoid the le32 assignment in favor of u8 inits
    - replace open coded constant with IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M
    - (minor) fix 24b timestamp comment: is 23b + overflow bit
    - (minor) remove unused parameter
  v2 -> v3
    - use READ_ONCE and read pacing_offload_horizon only once
  v1 -> v2
    - move special zero case up and return early
---
 drivers/net/ethernet/intel/idpf/idpf.h        | 12 ++++
 drivers/net/ethernet/intel/idpf/idpf_lib.c    | 19 +++++
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 69 ++++++++++++++++++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  8 ++-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 60 +++++++++++++++-
 5 files changed, 165 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index 470bc23c844c..f214023095ee 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -604,6 +604,16 @@ struct idpf_vport_config {
 	DECLARE_BITMAP(flags, IDPF_VPORT_CONFIG_FLAGS_NBITS);
 };
 
+/**
+ * struct idpf_edt_caps_ilog2 - Host parsed EDT capabilities.
+ * @time_horizon_ns: Total time window in nanoseconds.
+ * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
+ */
+struct idpf_edt_caps_ilog2 {
+	u32 time_horizon_ns;
+	u8 tstamp_granularity_pow2;
+};
+
 #define idpf_for_each_vport(adapter, iter) \
 	for (struct idpf_vport **__##iter = &(adapter)->vports[0], \
 	     *iter = (adapter)->max_vports ? *__##iter : NULL; \
@@ -657,6 +667,7 @@ struct idpf_vport_config {
  * @stats_task: Periodic statistics retrieval task
  * @stats_wq: Workqueue for statistics task
  * @caps: Negotiated capabilities with device
+ * @edt_caps: Negotiated EDT capabilities with device
  * @dev_ops: See idpf_dev_ops
  * @cdev_info: IDC core device info pointer
  * @num_vfs: Number of allocated VFs through sysfs. PF does not directly talk
@@ -720,6 +731,7 @@ struct idpf_adapter {
 	struct delayed_work stats_task;
 	struct workqueue_struct *stats_wq;
 	struct virtchnl2_get_capabilities caps;
+	struct idpf_edt_caps_ilog2 edt_caps;
 
 	struct idpf_dev_ops dev_ops;
 	struct iidc_rdma_core_dev_info *cdev_info;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 827c795afcb6..cd1b173e3b27 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -817,6 +817,21 @@ static void idpf_attach_and_open(struct idpf_adapter *adapter)
 	}
 }
 
+static void idpf_vport_set_pacing_offload(struct idpf_vport *vport,
+					  struct net_device *netdev)
+{
+	struct idpf_adapter *adapter = vport->adapter;
+	u32 max_horizon = 0;
+
+	if (adapter->edt_caps.time_horizon_ns &&
+	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
+	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
+			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
+		max_horizon = adapter->edt_caps.time_horizon_ns;
+
+	WRITE_ONCE(netdev->max_pacing_offload_horizon, max_horizon);
+}
+
 /**
  * idpf_cfg_netdev - Allocate, configure and register a netdev
  * @vport: main vport structure
@@ -850,6 +865,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 		np->max_tx_hdr_size = idpf_get_max_tx_hdr_size(adapter);
 		vport->netdev = netdev;
 
+		idpf_vport_set_pacing_offload(vport, netdev);
+
 		return idpf_init_mac_addr(vport, netdev);
 	}
 
@@ -890,6 +907,8 @@ static int idpf_cfg_netdev(struct idpf_vport *vport)
 	netdev->min_mtu = ETH_MIN_MTU;
 	netdev->max_mtu = vport->max_mtu;
 
+	idpf_vport_set_pacing_offload(vport, netdev);
+
 	dflt_features = NETIF_F_SG	|
 			NETIF_F_HIGHDMA;
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 24b91be25676..97e23ff9faf6 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1742,6 +1742,7 @@ static int idpf_txq_group_alloc(struct idpf_vport *vport,
 			q->desc_count = rsrc->txq_desc_count;
 			q->tx_max_bufs = idpf_get_max_tx_bufs(adapter);
 			q->tx_min_pkt_len = idpf_get_min_tx_pkt_len(adapter);
+			q->ts_gran_pow2 = adapter->edt_caps.tstamp_granularity_pow2;
 			q->netdev = vport->netdev;
 			q->txq_grp = tx_qgrp;
 			q->rel_q_id = j;
@@ -2408,7 +2409,12 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
+	desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+
+	desc->flow.qw1.ts[0] = params->offload.desc_ts[0];
+	desc->flow.qw1.ts[1] = params->offload.desc_ts[1];
+	desc->flow.qw1.ts[2] = params->offload.desc_ts[2];
+
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
@@ -3011,6 +3017,63 @@ static bool idpf_tx_splitq_need_re(struct idpf_tx_queue *tx_q)
 	return gap >= IDPF_TX_SPLITQ_RE_MIN_GAP;
 }
 
+static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
+				      const struct idpf_tx_queue *tx_q,
+				      struct idpf_tx_splitq_params *tx_params)
+{
+	const int offload_slack_ns = 400;
+	u64 ts, now, horizon;
+
+	if (!tx_q->netdev->pacing_offload)
+		return;
+
+	horizon = READ_ONCE(tx_q->netdev->max_pacing_offload_horizon);
+	if (!horizon)
+		return;
+
+	switch (skb->tstamp_type) {
+	case SKB_CLOCK_REALTIME:
+		ts = ktime_to_ns(ktime_add(skb->tstamp,
+					   ktime_mono_to_any(0, TK_OFFS_TAI) -
+					   ktime_mono_to_any(0, TK_OFFS_REAL)));
+		break;
+	case SKB_CLOCK_MONOTONIC:
+		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
+		break;
+	case SKB_CLOCK_TAI:
+		ts = ktime_to_ns(skb->tstamp);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		return;
+	}
+
+	now = ktime_get_clocktai_ns();
+	if (ts < now + offload_slack_ns)
+		return;
+
+	/* beyond offload horizon? set overflow bit only */
+	if (ts > now + horizon) {
+		tx_params->offload.desc_ts[2] =
+			IDPF_TXD_FLOW_SCH_HORIZON_OVERFLOW_M;
+		return;
+	}
+
+	ts >>= tx_q->ts_gran_pow2;
+
+	/* 0 is valid 23b timestamp, but also means field unset.
+	 * Increase by one to avoid this case
+	 */
+	if ((ts & 0x7fffff) == 0) {
+		tx_params->offload.desc_ts[0] = 1;
+		return;
+	}
+
+	tx_params->offload.desc_ts[0] = ts & 0xff;
+	tx_params->offload.desc_ts[1] = (ts >> 8) & 0xff;
+	tx_params->offload.desc_ts[2] = ((ts >> 16) & 0x7f);
+}
+
 /**
  * idpf_tx_splitq_frame - Sends buffer on Tx ring using flex descriptors
  * @skb: send buffer
@@ -3097,6 +3160,10 @@ static netdev_tx_t idpf_tx_splitq_frame(struct sk_buff *skb,
 
 		tx_params.dtype = IDPF_TX_DESC_DTYPE_FLEX_FLOW_SCHE;
 		tx_params.eop_cmd = IDPF_TXD_FLEX_FLOW_CMD_EOP;
+
+		if (skb->tstamp)
+			idpf_tx_splitq_set_txtime(skb, tx_q, &tx_params);
+
 		/* Set the RE bit periodically to "clean" the descriptor ring */
 		if (idpf_tx_splitq_need_re(tx_q)) {
 			tx_params.eop_cmd |= IDPF_TXD_FLEX_FLOW_CMD_RE;
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 93547597efd2..fe0c913f9bb9 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -161,6 +161,7 @@ union idpf_tx_flex_desc {
  * @tso_segs: Number of segments to be sent
  * @tso_hdr_len: Length of headers to be duplicated
  * @td_cmd: Command field to be inserted into descriptor
+ * @desc_ts: Flow scheduling offload timestamp
  */
 struct idpf_tx_offload_params {
 	u32 tx_flags;
@@ -174,6 +175,7 @@ struct idpf_tx_offload_params {
 	u16 tso_hdr_len;
 
 	u16 td_cmd;
+	u8 desc_ts[3];
 };
 
 /**
@@ -608,6 +610,7 @@ libeth_cacheline_set_assert(struct idpf_rx_queue,
  *	 hot path TX pointers stored in vport. Used in both singleq/splitq.
  * @desc_count: Number of descriptors
  * @tx_min_pkt_len: Min supported packet length
+ * @ts_gran_pow2: Txtime timestamp granularity in nanoseconds (log2).
  * @thresh: XDP queue cleaning threshold
  * @netdev: &net_device corresponding to this queue
  * @next_to_use: Next descriptor to use
@@ -666,7 +669,10 @@ struct idpf_tx_queue {
 	u16 desc_count;
 
 	union {
-		u16 tx_min_pkt_len;
+		struct {
+			u16 tx_min_pkt_len;
+			u8 ts_gran_pow2;
+		};
 		u32 thresh;
 	};
 
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 1caf52706973..928de868fa62 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -3,6 +3,7 @@
 
 #include <linux/export.h>
 #include <linux/net/intel/libie/pci.h>
+#include <linux/log2.h>
 #include <net/libeth/rx.h>
 
 #include "idpf.h"
@@ -553,7 +554,8 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 			    VIRTCHNL2_CAP_SPLITQ_QSCHED		|
 			    VIRTCHNL2_CAP_PROMISC		|
 			    VIRTCHNL2_CAP_LOOPBACK		|
-			    VIRTCHNL2_CAP_PTP);
+			    VIRTCHNL2_CAP_PTP			|
+			    VIRTCHNL2_CAP_EDT);
 
 	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
 	if (err)
@@ -573,6 +575,54 @@ static int idpf_send_get_caps_msg(struct idpf_adapter *adapter)
 	return err;
 }
 
+/**
+ * idpf_send_get_edt_caps_msg - Send virtchnl get EDT caps msg
+ * @adapter: Driver specific private struct
+ *
+ * Return: 0 on success or error code on failure.
+ */
+static int idpf_send_get_edt_caps_msg(struct idpf_adapter *adapter)
+{
+	struct libie_ctlq_xn_send_params xn_params = {
+		.timeout_ms	= IDPF_VC_XN_DEFAULT_TIMEOUT_MSEC,
+		.chnl_opcode	= VIRTCHNL2_OP_GET_EDT_CAPS,
+	};
+	struct virtchnl2_edt_caps caps = {};
+	u64 gran_ns, horizon_ns;
+	int err;
+
+	err = idpf_send_mb_msg_stack(adapter, &xn_params, &caps);
+	if (err)
+		return err;
+
+	if (xn_params.recv_mem.iov_len < sizeof(caps)) {
+		err = -EIO;
+		goto free_rx_buf;
+	}
+
+	memcpy(&caps, xn_params.recv_mem.iov_base, sizeof(caps));
+	horizon_ns = le64_to_cpu(caps.time_horizon_ns);
+	gran_ns = le64_to_cpu(caps.tstamp_granularity_ns);
+	if (horizon_ns > U32_MAX) {
+		dev_warn(&adapter->pdev->dev, "EDT horizon exceeds U32\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+	if (!gran_ns || !is_power_of_2(gran_ns)) {
+		dev_warn(&adapter->pdev->dev, "Invalid EDT granularity\n");
+		err = -EINVAL;
+		goto free_rx_buf;
+	}
+
+	adapter->edt_caps.time_horizon_ns = horizon_ns;
+	adapter->edt_caps.tstamp_granularity_pow2 = ilog2(gran_ns);
+
+free_rx_buf:
+	libie_ctlq_release_rx_buf(&xn_params.recv_mem);
+
+	return err;
+}
+
 /**
  * idpf_mmio_region_non_static - Check if region is not static
  * @mmio_info: PCI resources info
@@ -3085,6 +3135,14 @@ int idpf_vc_core_init(struct idpf_adapter *adapter)
 		}
 	}
 
+	memset(&adapter->edt_caps, 0, sizeof(adapter->edt_caps));
+	if (idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS, VIRTCHNL2_CAP_EDT)) {
+		err = idpf_send_get_edt_caps_msg(adapter);
+		if (err)
+			dev_err(&adapter->pdev->dev,
+				"EDT init failed, err=%d\n", err);
+	}
+
 	pci_sriov_set_totalvfs(adapter->pdev, idpf_get_max_vfs(adapter));
 	num_max_vports = idpf_get_max_vports(adapter);
 	adapter->vports = kzalloc_objs(*adapter->vports, num_max_vports);
-- 
2.55.0.1007.g17ff1f9808-goog

