Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0EACC982CC
	for <intel-wired-lan@archiver.kernel.org>; Sun, 20 Sep 2026 07:21:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A6DCB81088;
	Sun, 20 Sep 2026 07:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BwVmxD7jeQmG; Sun, 20 Sep 2026 07:21:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B678E810AA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789888896;
	b=BF9WeIbqnVMDzDvHheTIc8pNlx1hfpy9pZC4L2vt+s+x0jacYvxfdhO307mia1bl9ouz
	 W0tuaZ6yCaj2W/A3TPT56fJr/RXZ19RR6N8TPHzEDxUH/Xx/IOxv+MjrqSUgM9E1NXENu
	 n1zx4RTERHcvGQYt4TPmubyp4Jhw8YM35kcvlVqKoP95GXF520IJwFXvy7ITiJqzn2Xyo
	 kFtm+Mqi6gydZ2VEBj8+wCn72GIX6zMFybrtLvEeu9hd9qHA48VvBtUmw6zYq3xSJJRgb
	 NCAbG0qNLPx+AARCur5xbYVW3+jJK/Rfn2uKvGeIWlnTk9i66lEg0gT7IsrIfdIfrUw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789888896;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
	b=ELHa0VPQC4M8TT6Jlt9ZTxJlQg8njCKzlbXARwdJEgY2H0VC/xL68C8EFBwtqQRPOrto
	 S7aUsAnS0cnnQxEsgIYUCWx7aP6RjNG9fPc5nCeTuprsaQtJSM5FZZqNwFJ8MYxLc++Ts
	 ckeVoSaN3u8r32kpjBz8He9ZgSEpe+O0kwrlCGsXlhFdoKCXbbMwnZjusolohjNDCrUd1
	 pVvFaixOdEuqnHv7fJb4rL8pcJAMU7jaXgnqoxHITbUpl2Bc5uzXB2g6LX3vDSEPqTXwj
	 lWyrgOtO5HmXKdpPKxN7nD79jBidA5tZiP/2k30Zv6LGE145Rq5rQkW7jOqgHs1iLug==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789888896;
	bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=BqlcOfNIm70tqJ0qYELLb2VzrzGzxOG9Ev+siZdcqNvE5rjqysknnNSWBB/JzVB1H
	 2GwMFIEF8eivZfIqd2fs32Z2H2jitAPrgZPodH+HnkV+6ZF7XX/BySXsNKnc5E2TP3
	 MjJHLbW+poLYmj0W0QRgGqed/auRFmw1loKdDAwRrM/w0wABfl/uDbvG6kwhlhnYXA
	 zX5XZvKSBltOtJw9k9nfmAH8IqJLdlVWIFK9M4Pl7j+imrjZ95VCuOfscZkItfrMiD
	 4FlyQKXo2oX6ZgluQj3RbteodDwHiGVzTTYVwXmD8mBxzxdZU6gMjmUl4re91hbZlR
	 vn58fr3OnQxgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B678E810AA;
	Sun, 20 Sep 2026 07:21:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id E4354392
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:21:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C9E0460658
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:21:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SYA-3QLFzkW7 for <intel-wired-lan@lists.osuosl.org>;
 Sun, 20 Sep 2026 07:21:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E19D060653
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789888894;
 b=Sz3zLqmbpPcoWpQPkcZwDz13IN0jhcj5TOrSEwSbvSJD0fQZuCBQ69a9G3MSIqf3fNzJ
 qpgI+7DzIUYJVvcNAVak0nB9kotEf2mGlarK7PSjmm1DliOOZy15l5GhHqDEK9kMzktHK
 O+tJuhp8ujDUm9O+jmaFxp/yW4lae4qBZ4nVEKQgOvsVBFa8LNwvDrP80p77ITGZEP7O1
 TMmDSnFHz2pR1fjFR7Dbq+yz5jhBKp3pp671SHtoSijB2h/9e7ST7GCrewOSy+whua6ZU
 a9LD0k6ddKmiaCjL+xKjHB3oIctlSPa4r0j9V5UX+CKfXrYkKH7QGNWCxs7lZEAQ29A==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789888894;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
 bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
 b=QMVj69EUFxZ5c3y0mFDYvq9o6MzZfmfnDldBRtLd/Qtua6u93GWek38NWsgCeMJuhprY
 ye8gQZsf2RlcECQmb7M5GH4mWe8SPcSDKAGIJRPeecnmpX5Yd01GQPIAWKAS4dwKkfNMM
 hiMVa2WdaULLlqy6+A6of+serxxOJvUNdQx1GUPD8W3d9GJv14vYRFfYrY32cCbT1Fth2
 /Bz16xDczDaT7si1iiNOFI21sR8KQpERN2mObQF4Dt/yqKVbREKWmN4+z+01MDTrLBunh
 7cE1IiydZTe7dGPs+lundybBD1aDRrV1BYw3dfS50sKC0P/qygqT0pTILesU3wBunmw==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=gmail.com; 
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KWPWh3f+; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::635"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::635; helo=mail-pl1-x635.google.com;
 envelope-from=hayatake396@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KWPWh3f+
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com
 [IPv6:2607:f8b0:4864:20::635])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E19D060653
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 07:21:33 +0000 (UTC)
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2caced6038eso17613175ad.0
 for <intel-wired-lan@lists.osuosl.org>; Sun, 20 Sep 2026 00:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789888893; x=1790493693; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
 b=KWPWh3f+by4zu8Z9Cz0Adbga+CnWoqEQoIGB0COFWjqkIhyRNcwK5w1glMr7klVkqA
 DPKcD3+AjCQ6BnGzgcX+hdaBE5mbUeq7S11ZLy3LTVwoGvnDfBc9xgcTKo2Tj1cjE6lI
 L9TFHatBniwBxtzavnFv1TlFc0ZOIkxQyGwcUE0ZLUo1rObK/fYrEzXiCANNTWEpOVdi
 jn4/FbzwOSlcZ5NhpctiezrQMKWITGCHS/cd+AFQNCEYxIcC8Hq56Ab6+6X0OLplItqc
 GBOuAMg01WhMRaolXfMC3CIcHyHH4Z5zRHuE0j9DJAd6xlLhRXTzHXYUua4YKNs9nTbR
 n+ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789888893; x=1790493693;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+N4HCSxx6xxbL7mCL5k/pdd9D0OqiBm4AMjPhjGc6A=;
 b=gtt0+4lnlRLWuw4VGx2b6wDn0W+Nfgnap+sdHNv5Y56VrFuUIHYZ6qqAG9KAHpNd68
 TWJKAs7niG/IkUVYEMIG9AVj164ZprsyvQMfdvHsiRe1kAMCxlQnVQ7ofX3xKSYG79/i
 tOcUvfDmVsiwcaGjGUVEZdrQMoCsrheT2i/4Z6Gs+xrU2EU3wDyvIlx9/25C2s5UEnZf
 nj+Uu2gSoLNQnOhLep5QBv6z9unBVRol+AGoWKaG1kF8IWmpDROMwmvfXjPTreTs/9Ln
 UgwWJt1Pu7b5xEIv2SDbZ5YxxnqxnQNNupupTvORTJAjUWoGj4rS7heylZ5JnAx6Dl9j
 KoxA==
X-Gm-Message-State: AFuF++m4EY3nsc6zj+BgG3dv59cV42eu/HxfBuL2rFiXfjtgoPAHgDQg
 HhkCh+elPJ3KsgiUM3Xc4ExwZyYxWcqy1lRMoMaAM0pDKNHhnAV1aNMjPqCeLA==
X-Gm-Gg: AYBFou2ne/SFJVmixtZHDfW9Kq/LrJLcwrQKu7QiDajYUfvweKnV6VA+85L/1C4o3nJ
 jH9JvXrQpq23bGDPqzH59MSq9hmZAlVqDiv9q2D3hJC5DT2nJAb0tv9afsni7a5VQh7MxZb4nb7
 xMeKH3peqG06m80WT4hRl1wJS6LloNMkm4y7aO6/PdRoRFOaAr5FLCk9jfrB2DgZrPuYM3yIeYE
 YqQ3vCsZHp6IBpSUYt7j0WJyiGj9KUUQCthzfPakbXJAONSHLQ+QX4faarCJ2Dv3xFyZSGtIJGA
 n+NSKMBB3q88Af2/5JcgScT2mCsUkE6Su78Me6q84gtbj4TtzzKLzhRyMio2jh7294O2S2+ex6r
 6UqXWI+8+ICor/v5zSwt+HdquyCkelq4UtqnhLS0ExCBmo/P5go7MzLkFCepvjNbHJinNfVL7yW
 wp1eR/cQBB9eeGcb2cEEfqFcGrwkNICcoDjLlAxuxF6ubD7TarCBO2evs9GJ4MNsjYkrO7Gzs/2
 U0YaDmJCGbpeV++V1PWip0oI5t5UMR5hg80jJtOv0dQlk3QhBB3j5qwB1nn/EMuZyMtO+pb1z7E
 /zyupA==
X-Received: by 2002:a17:902:db0f:b0:2bd:2c3a:2a36 with SMTP id
 d9443c01a7336-2dd9c5e9b98mr143166245ad.0.1789888892689; 
 Sun, 20 Sep 2026 00:21:32 -0700 (PDT)
Received: from lab-kiba-ocxma-dut-01.. (191.68.231.218.rev.ocx2915.net.
 [218.231.68.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2de217b3a97sm16542345ad.31.2026.09.20.00.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 20 Sep 2026 00:21:32 -0700 (PDT)
From: Takeru Hayasaka <hayatake396@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 netdev@vger.kernel.org, marcin.szycik@linux.intel.com,
 alexander.nowlin@intel.com, Takeru Hayasaka <hayatake396@gmail.com>
Subject: [PATCH iwl-net v2] ice: fix empty PTYPE set for GTP RSS profiles
Date: Sun, 20 Sep 2026 07:21:14 +0000
Message-ID: <20260920072127.1278984-1-hayatake396@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Configuring RSS for GTP flows via ethtool, e.g.

  ethtool -N <if> rx-flow-hash gtpu4 sde

is accepted but has no effect: the hash of GTP-U packets does not
include the TEID, so all traffic between a given SGW/PGW pair lands on
a single Rx queue. The GTP RSS configurations the driver installs by
default at VSI init are affected the same way.

ice_flow_set_rss_seg_info() does not set IPV_OTHER on GTP segments, and
such a segment carries no L4 header bit either. ice_flow_proc_seg_hdrs()
therefore takes the "no L4" branch and ANDs the PTYPE set with
ice_ptypes_ipv4_ofos_no_l4, or ice_ptypes_ipv4_il_no_l4 for the inner
segment. Neither holds a GTP PTYPE, so ANDing with ice_ptypes_gtpu
leaves the set empty: the profile matches no packet at all and the
configured TEID field never enters the hash.

Set IPV_OTHER on GTP segments so that the tunnel-inclusive PTYPE sets
are selected instead, which do contain the GTP PTYPEs. Skip segments
that carry an L4 header bit, because the VF path strips IPV_OTHER from
those on purpose.

Verified on E810 (kernel 7.2-rc2, COMMS DDP 1.3.63.0) by reading the RSS
hash from the Rx descriptor: GTP-U traffic varying only the TEID goes
from one constant hash on a single Rx queue to 4096 distinct hashes
across all Rx queues. The same holds for inner IPv6 (gtpu6) and for a
PDU session container extension header (gtpu4e); plain UDP flows are
unaffected.

Signed-off-by: Takeru Hayasaka <hayatake396@gmail.com>
---
v2:
 - Ignore IPV_OTHER in ice_get_rss_cfg() so "ethtool -n" reports the
   GTP fields again (reported by Intel validation)
 - Do not set IPV_OTHER on GTP segments that carry an L4 header bit
v1: https://lore.kernel.org/intel-wired-lan/20260714192302.631428-1-hayatake396@gmail.com/

 drivers/net/ethernet/intel/ice/ice_flow.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
index 121552c644cd..27de6048ebcc 100644
--- a/drivers/net/ethernet/intel/ice/ice_flow.c
+++ b/drivers/net/ethernet/intel/ice/ice_flow.c
@@ -2088,6 +2088,15 @@ ice_flow_set_rss_seg_info(struct ice_flow_seg_info *segs, u8 seg_cnt,
 
 	ICE_FLOW_SET_HDRS(seg, cfg->addl_hdrs);
 
+	/* A GTP segment without an L4 header bit would select the "no L4"
+	 * PTYPE sets, which hold no GTP PTYPE at all. VF requests that do
+	 * carry an L4 bit drop IPV_OTHER on purpose, so leave those alone.
+	 */
+	if ((seg->hdrs & (ICE_FLOW_SEG_HDR_GTPU | ICE_FLOW_SEG_HDR_GTPC |
+			  ICE_FLOW_SEG_HDR_GTPC_TEID)) &&
+	    !(seg->hdrs & ICE_FLOW_SEG_HDRS_L4_MASK_NO_OTHER))
+		seg->hdrs |= ICE_FLOW_SEG_HDR_IPV_OTHER;
+
 	/* set outer most header */
 	if (cfg->hdr_type == ICE_RSS_INNER_HEADERS_W_OUTER_IPV4)
 		segs[ICE_RSS_OUTER_HEADERS].hdrs |= ICE_FLOW_SEG_HDR_IPV4 |
@@ -3002,9 +3011,10 @@ u64 ice_get_rss_cfg(struct ice_hw *hw, u16 vsi_handle, u32 hdrs, bool *symm)
 		return ICE_HASH_INVALID;
 
 	mutex_lock(&hw->rss_locks);
+	/* IPV_OTHER is set on GTP segments internally, ethtool never asks for it */
 	list_for_each_entry(r, &hw->rss_list_head, l_entry)
 		if (test_bit(vsi_handle, r->vsis) &&
-		    r->hash.addl_hdrs == hdrs) {
+		    (r->hash.addl_hdrs & ~ICE_FLOW_SEG_HDR_IPV_OTHER) == hdrs) {
 			rss_hash = r->hash.hash_flds;
 			*symm = r->hash.symm;
 			break;

base-commit: 1cd23ca80784223fa2204e16203f754da4e821f8
-- 
2.43.0

