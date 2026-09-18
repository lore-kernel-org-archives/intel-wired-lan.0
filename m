Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58E64C982D8
	for <intel-wired-lan@archiver.kernel.org>; Fri, 18 Sep 2026 13:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 288D860DD9;
	Fri, 18 Sep 2026 13:33:18 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FPJr_nQApbC6; Fri, 18 Sep 2026 13:33:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 7F01060DF1
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789738397;
	b=gEBJXrs23XRi0+tKXN5AGkLwVf5fwON7d/FrgprWuoj5OtW7ebJd8Buxaps40VZTx+Yl
	 ktqCw/MIrVLSPWCDEmgvWeyYHSLKbkpktodbo5RNXPlWSoY75gF4mYExg8l6Bu9pBiCcH
	 Xj1QI1Xn0PtJ6KOZ54ZzqlzOV6oNOXr1oK1//isg3m/i+PbFNCTksq6jLm23onPDG4Kck
	 kWaWJogTB3kwu6R6sF8G/IhAxLBpcMvRvmZFhXoQuzZMUm1RFTXp3cjBhT1zZ7PLKDRqw
	 BN2Vik1q/vaBrGy4n2gRxsafSGClMMuZqfP/CbLUV3dh2u/AZnWIWQHjXjnx3BiAOug==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789738397;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=DeaW3XuwqoZgITd4ZXH9yLfvCyHIR2KUhlo9XeZzr/A=;
	b=FOfUEWic8IrenkgB4fEnf6eGlz8y8LStOLY7j4A4N40zcmC8pCWuU+ChsEGMvKB5jcUo
	 NOcojLsRzO5O3MTlEWkpIh6Zh5fWT/6NxEmdTG/be9VnFINRMcSlgDOoPyCHXWIRzeuce
	 1glj1IawdWzKxDlJ/ECuYlsBAxXRTufHOnX+NE+Z7KrG05Q9lMPLdceOgjOYU66ep+nQq
	 hPcBgjy0DoJdGtMEi6U9eCdqFJVNgGObE1wV1A+smLE0bDPgh9eI9C/y8fYaykTG4TBKK
	 PTkmTqFhGU/UTradB1tHFR6Re+UetZEBxxyuOunuGcxf+F6KpnfN5NRAiE+DSc2j84w==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=pass header.from=intel.com;
	dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=X1J7XtQ0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789738397;
	bh=DeaW3XuwqoZgITd4ZXH9yLfvCyHIR2KUhlo9XeZzr/A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=HJM6Y6CAOAz0xSqb+ZTGog05450wQBI3SLxBM1io0XvTay/5QB8Kscd9Qyh5Z9QqP
	 qV4d5aLHxoucrWIyZY1G9ThOgRWDAVqDJ5D2rEqvrcxoCeMc+CSH/0tj1dW7YCJx6R
	 V85R0TOirIgWxblbBQp3swhQ/UoGaUFatcwNBa1NGuiY/OHcLhYvZ8dTgS8mG7ESL6
	 6SvSy4SGkHbaVkVzhvZcz0wO+ohXk2Ae1jtfSOiPWBt6t9qgy1faVCF47QezN6OoTJ
	 AX8MQa8mReamccPientKW6uP2koMxc1lC0BYhhKbzvKNE5sNnTy6/zO3har+z4waSV
	 E/Y3LJX39GZBw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7F01060DF1;
	Fri, 18 Sep 2026 13:33:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B919E224
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B650660DF1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2LS5sR4ExknF for <intel-wired-lan@lists.osuosl.org>;
 Fri, 18 Sep 2026 13:33:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 17D3C60DD9
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=192.198.163.11
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789738395;
 b=ApyfBCLK+xifcql2LA1VZoimAcXnc6BqdeaoMXtCvg0f7Z2Q1etUE8rJi4ELbYW6MAxB
 Q0rUNwhCdC8K34GLP+lKpV+JLBni8kF/W685wvV3S9oWHozOhM1dzF9skj1nNvVPcoTZz
 /XKOpPheTb3uEd54oiQAvpLQlYTSnkucv8aeGjiHXWS/AtAKGzO+o1o098WO7MwhJoGwO
 rT5tZ+swIvgvqCyT3NWQK4To6BdDywdZGKpuHrjxYJj6dapRPseaLyK3/COUv7yvthy/t
 jEWPmYoUmxPIcJ0eCPi+QOKiftsUTH1kdkijA34KcdWPOQWRGTJWKbIbtoHJnlsjTWg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789738395;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=DeaW3XuwqoZgITd4ZXH9yLfvCyHIR2KUhlo9XeZzr/A=;
 b=jSYapXdPDF7tyCu+hMUybQW46RkmvBcYfR4ZX85mW0hAaEfQ+t05HIz4Xf7nVdqAPKaQ
 7/Vy8hIZOVTyZP+Y1B297b9Z4NxYOt6NCnFDiqTsMhQMIB0iSbvdTabAbnF8UREv1PrZp
 0zZQwpWwYMzUpFsX3+nXsVRS46EGXkFMdifNe8nTFlLEucmzIGFwUhhO0v7Ygkv98I8gU
 hi8fwCe1r9ChG+zG68IuHtS8Rs8PXCibosssr4V9PpcP8dQ6tt19PgjVBRn7S156SHmj2
 vUXJeZsYqPZ+upxgc80cjl/6h+pbWIbiy2gBTad1M1W5QpafKJ14zJv6X+IcdjhT+8Q==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=X1J7XtQ0; 
 arc=none smtp.remote-ip=192.198.163.11
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=192.198.163.11;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=X1J7XtQ0
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 17D3C60DD9
 for <intel-wired-lan@lists.osuosl.org>; Fri, 18 Sep 2026 13:33:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789738395; x=1821274395;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2E9Pez/JNLraDd7GK5S27b+3RfEH+WKJa5e0tkfg4gc=;
 b=X1J7XtQ0mN+DKj6+ByLo9Tfpp6XUYqOib1xmhUEMaqUwER4j7GSa/syN
 7DvHEN4Bfy5POiTcMwBzchahYtrXE9iBIMXX530AhIggJp/3H1tYduTPJ
 ROVf1MU5o1Zz5zlTxRb4fnt9e1nweu2KuR0M9rviVpNVW2G2ACIAvDFSt
 W8EDrwgxvRn6f+KKvVamF8cr6RCcaeRftfMGIoRHvrE6/ERuOwhJVzGxd
 uCpKczpn9E/qBz/VfrMKk76a6HLMLa3l2Rp5Lg2AFLZnECEPHQUhCXzYh
 NPB6dwdUSoDc4r6Krd/Qm2fx/RR0TWpfTcTfmq/074NE4a+tA65SjDzQV w==;
X-CSE-ConnectionGUID: kdaGXj+wRgavzhDEuNz9iw==
X-CSE-MsgGUID: lm/KHmP6RGeF/ojr7vFv6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11908"; a="100840860"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="100840860"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 06:33:14 -0700
X-CSE-ConnectionGUID: RNK8oiaHTQSLgF5z+UutGg==
X-CSE-MsgGUID: ic1ULgAIT4iZ45/TNly+NQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="270717889"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by fmviesa010.fm.intel.com with ESMTP; 18 Sep 2026 06:33:12 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-net v3] ice: fix bound parser hash offset before reading
 packet data
Date: Fri, 18 Sep 2026 15:33:11 +0200
Message-ID: <20260918133311.4169756-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
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

ice_rt_ho_set() uses the HO register as the starting offset of an
ICE_GPR_HV_SIZE-byte memcpy() out of rt->pkt_buf. Potentially HO can
be advanced by user-controlled data reachable through
ice_parse_raw_rss_pattern() -> ice_parser_run() ->
ice_parser_rt_execute() -> ice_rt_gpr_set() -> ice_rt_ho_set(), i.e. a
VF-supplied raw RSS pattern (virt/rss.c), with no bound against the
size of pkt_buf.

Clamp HO to the last offset from which ICE_GPR_HV_SIZE bytes can still
be read out of pkt_buf, deriving the limit from sizeof(rt->pkt_buf)
so it stays correct if the packet buffer layout changes.

ice_parser_rt_pktbuf_set() stores the caller's raw pkt_len in
rt->pkt_len, even though it only ever copies min(ICE_PARSER_MAX_PKT_LEN,
pkt_len) bytes into rt->pkt_buf. Both ice_parse_raw_rss_pattern() and
ice_vc_fdir_parse_raw() pass a VF-supplied pkt_len of up to
VIRTCHNL_MAX_SIZE_RAW_PACKET (1024), i.e. larger than
ICE_PARSER_MAX_PKT_LEN (504). With HO now capped at 504, the
"HO >= pkt_len" loop exit in ice_parser_rt_execute() would never be
reached for such an oversized pkt_len. Store the already-clamped
length instead, so rt->pkt_len always matches what was actually copied
into rt->pkt_buf and the loop-exit check remains a valid bound
regardless of the caller-supplied pkt_len.

Fixes: 9a4c07aaa0f5 ("ice: add parser execution main loop")
Cc: stable@vger.kernel.org
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2:
- also clamp rt->pkt_len in ice_parser_rt_pktbuf_set() to the same
  ICE_PARSER_MAX_PKT_LEN bound already used for the rt->pkt_buf copy,
  so the "HO >= pkt_len" loop-exit in ice_parser_rt_execute() can't be
  bypassed by an oversized pkt_len from the raw RSS/FDIR VF paths
  (reported in review)
- dropped Przemek's Reviewed-by since the patch changed
v2 -> v3: no code changes, resending to pick up Reviewed-by.
---
 drivers/net/ethernet/intel/ice/ice_parser_rt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_parser_rt.c b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
index 3995d66..b330005 100644
--- a/drivers/net/ethernet/intel/ice/ice_parser_rt.c
+++ b/drivers/net/ethernet/intel/ice/ice_parser_rt.c
@@ -10,6 +10,8 @@ static void ice_rt_tsr_set(struct ice_parser_rt *rt, u16 tsr)
 
 static void ice_rt_ho_set(struct ice_parser_rt *rt, u16 ho)
 {
+	/* keep the ICE_GPR_HV_SIZE-byte read below within pkt_buf */
+	ho = min_t(u16, ho, sizeof(rt->pkt_buf) - ICE_GPR_HV_SIZE);
 	rt->gpr[ICE_GPR_HO_IDX] = ho;
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
@@ -106,7 +108,7 @@ void ice_parser_rt_pktbuf_set(struct ice_parser_rt *rt, const u8 *pkt_buf,
 	u16 ho = rt->gpr[ICE_GPR_HO_IDX];
 
 	memcpy(rt->pkt_buf, pkt_buf, len);
-	rt->pkt_len = pkt_len;
+	rt->pkt_len = len;
 
 	memcpy(&rt->gpr[ICE_GPR_HV_IDX], &rt->pkt_buf[ho], ICE_GPR_HV_SIZE);
 }
-- 
2.52.0

