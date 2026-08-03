Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EDCBC55182
	for <intel-wired-lan@archiver.kernel.org>; Mon,  3 Aug 2026 21:07:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 02AA380BFB;
	Mon,  3 Aug 2026 21:07:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id grol09WofCGy; Mon,  3 Aug 2026 21:07:19 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3399980B9C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1785791239;
	bh=xs6AeFC6wzPPBL4PftXRtu7W3n9YFR5yhGm6HKUzTww=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wNWS3E6F8yOqQWOf9lyL64iKhiJd/DNk/qZTIdEbPDQiqmVO0EQmahWFWWEWEiT1y
	 +eXNXqtCbqLrEScPWu+ryIXZuHYVBsy7GWBhgA05XD2Ljm8h0KFRqAMzEbzoSyfgaR
	 AieGuzC58ZFyc+iG0ZVxP6KR70H0w29OA8kXosvQsGyW+wOvt4NmzES8Dtbd2wRSOj
	 7DQRSZ2R0DqTQK/zw/I/nhY6OxHIopdRtGzR8skuXfb8hX9tH3ogwVmo2objanHqqZ
	 PhJgSJlbSM6oxi1i+1O/g3oc0xHTHwrdZStaoIKD1dAuW16eCsNBoPN6ha3vo1UuVI
	 8bhnZLbTKw15g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3399980B9C;
	Mon,  3 Aug 2026 21:07:19 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 2403F28F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 21:07:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0A9F34062F
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 21:07:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MmosF0MMlFJ8 for <intel-wired-lan@lists.osuosl.org>;
 Mon,  3 Aug 2026 21:07:17 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1132; helo=mail-yw1-x1132.google.com;
 envelope-from=willemdebruijn.kernel@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 197B640591
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 197B640591
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com
 [IPv6:2607:f8b0:4864:20::1132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 197B640591
 for <intel-wired-lan@lists.osuosl.org>; Mon,  3 Aug 2026 21:07:16 +0000 (UTC)
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-81ed2a06b9eso33450797b3.3
 for <intel-wired-lan@lists.osuosl.org>; Mon, 03 Aug 2026 14:07:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785791236; x=1786396036;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xs6AeFC6wzPPBL4PftXRtu7W3n9YFR5yhGm6HKUzTww=;
 b=eleyu1fQxJ3CWA/2pQ1uh1O98405/L0wdOFfkrzE6xJaFPy5h+UqvEUXtOVBTowaMl
 utGkBqFsQ9t7mHpfr0NAxRUnEKTWLPnLXJ1am+RZ3rTcl7cUAWUP6MOn5T8br+WIPCfx
 gtwaP5NkM6wk5zanAage5k9jGHv8YMTzmZ9SLXCSczAeE3ELdIHzjxqrVuOvPHjfFqGj
 t5/Yb85f3ZRNhNDm6AyDApmoMyqxen7hMN0l49lsiQmGgJk9cI8qabel3WPo6q8nFDV2
 s2tUzQXPK/70dp2yj5MW0z1OZzKK+E0tKlrVcLil8a/qFDDkaBo6Gg6hIfhpurTbjtNf
 q9iQ==
X-Gm-Message-State: AOJu0YxN+Kv7oEYyrGK4tw6q6hEya7bnOtZ7HKTBbEoAGkwJF3lWaoD+
 gfBfRkiTTvkFhcGB8NFl+FHDqejI8iadWwQ5BOS4ZcYliZchY4sqtEe3
X-Gm-Gg: AR+sD10UcpS0PZ5genwdXBgKy/xUsRBNkbre3rtdRa0wW190iWf3tafqMgqBGxyEZPU
 oYn++Comw+mAOZX9O9WDmS827IZdMnrtDXd9MRBLqgb1TOu8TmlLUP7qbT1fMgKTI82wiyOX92t
 xeD7J038lXm6jXCrI8j1TiUgBQLG/+HkN0nNNOSxGLoE/KBpfRr1V2jTBehRGy54o3rf0yXw8xo
 jhCvyZjaitBQFRn+csxcgdyI7seqs/T7CSjbPEu2cxMt1I0Uxmx0PVXSouiAMbJA11Iy70YzIFv
 xP/VdTEbXbX4lS91W4Umy849D72vVqocN9iu7HmIhMmOSm070OXYJbtkb/7wX3Q82RbkJY4tf2C
 l6VD9d6A3O5yn6wJDG9VyZalJV08Xrm0fHaP2IAeqPbXDQf8/WLA0au+WFSYPKUgDRnAZIuBuc/
 NrlfNxqfc4IcJuoSYHxEM9t7Xe1qbx8HILbsD1JSbwJkmyR1grA4B57U6YGWomoCXzVXa2C3f0+
 n7oncI+oD/GO6ouOd2Vdc6lU6IsHeWVmPi/Yn6+6DHGxECSj9Zknlg2ziM=
X-Received: by 2002:a05:690c:c91:b0:81e:abe2:e01b with SMTP id
 00721157ae682-81fd4b8c96emr131532957b3.26.1785791235798; 
 Mon, 03 Aug 2026 14:07:15 -0700 (PDT)
Received: from willemb.c.googlers.com.com
 (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-81fcd0f87efsm62099257b3.33.2026.08.03.14.07.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 14:07:14 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 joshua.a.hay@intel.com, przemyslaw.kitszel@intel.com,
 Willem de Bruijn <willemb@google.com>
Date: Mon,  3 Aug 2026 17:06:23 -0400
Message-ID: <20260803210707.1912217-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.55.0.629.g250fe7f194-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785791236; x=1786396036; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xs6AeFC6wzPPBL4PftXRtu7W3n9YFR5yhGm6HKUzTww=;
 b=O/CL+gOEHQuVzQrHV8k1lhuxi0/VQUmVXwU2HKJcpONNaINnwT1NsBlyfwaq1AZzpd
 ofXwI3X01BOQNwcSws717goBf9OCs6g8gQ2zCLa8lqJKRIPx5Yw+/dy1egz8MWFcTFXi
 24CnCmrow52KrLINey/YDDzZDkDvgFveVAKsR/nXjxckDNVgtBHUmMgxJn/rI5xUjJa8
 cDHN7JpedMe9025Nu98MELMmjXY3DMiaDlLfSyesWreDFAgJVK7unkoHNmv6KmHgX4Sm
 9BEZQkBG/h+aeno3vFTz6DuE1xEMJaYchte1Ip9CLaj7Z9meR6+oWi2avOBuHylcYky5
 yNhw==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=gmail.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=O/CL+gOE
Subject: [Intel-wired-lan] [PATCH iwl-net v2] idpf: add missing cpu_to_le32
 in idpf_tx_splitq_build_flow_desc
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

From: Willem de Bruijn <willemb@google.com>

idpf_tx_splitq_build_flow_desc performs a 32-bit store to &cmd_dtype
to set the 8-bit cmd_dtype and zero the adjacent 3-byte timestamp
field in a single operation.

Descriptors are in little endian. Add missing cpu_to_le32 and cast to
__le32 to ensure the fields are written correctly also on big endian
platforms.

Fixes: 1a49cf814fe1 ("idpf: add Tx timestamp flows")
Signed-off-by: Willem de Bruijn <willemb@google.com>
Reviewed-by: Tony Nguyen <anthony.l.nguyen@intel.com>

---

Changes
  v1 -> v2
  - add Fixes tag, Tony's Reviewed-by and Cc: intel-wired-lan@lists.osuosl.org
  v1: https://lore.kernel.org/netdev/20260731103137.4000876-1-willemdebruijn.kernel@gmail.com/
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index c724d429a7aa..91ca75e45463 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -2408,7 +2408,7 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
 				    struct idpf_tx_splitq_params *params,
 				    u16 td_cmd, u16 size)
 {
-	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
+	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
 	desc->flow.qw1.rxr_bufsize = cpu_to_le16((u16)size);
 	desc->flow.qw1.compl_tag = cpu_to_le16(params->compl_tag);
 }
-- 
2.55.0.629.g250fe7f194-goog

