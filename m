Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA44606A31D
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Oct 2026 08:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=zXeMdLcM;
	dkim=pass (2048-bit key, unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256 header.s=protonmail header.b=bdhdNk62
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E096F80E18;
	Wed, 28 Oct 2026 08:35:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YJ7oRx29rTjG; Wed, 28 Oct 2026 08:35:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1EC2280E09
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793176520;
	b=Tb9x84U9JqO+4O4ouqobsFCVLqV3RNWvh2R1JLGJHqXZcCaECZPrGnwt8HC526zMI1O0
	 XFDDs4eBdXSfKuOijTjVo3wI5CZdw3dEsA+bvV2hXm3GwYJX0KQcznxMSJYlv1GwPA6rN
	 V7hI5IIKKHG8tY0CB71mL8jPmVbA8SuRrX2ybLsWUgU4NZr0k+cMTMAW4CleVlxUsmf8C
	 wkYW3eD5FCzC7pj2L3OIS1m5d8O6HC5llTW+PppdEaSCWL6j+BRkhrC0wT4G74Woo6slr
	 lOLymy3v9wlCl4r3iiV7UTu/kzFMV52egczggFpMSqsVx4mC675lsF5JpRkv162qP/Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793176520;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:In-Reply-To:
	 References:Feedback-ID:X-Pm-Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
	b=syEs0lPXQcsaSTtHWvyP65rz+29PRt6Z8FDiCN62mu4XPlO+FNdw48LE9JoJHInLaYtj
	 0U+OzeD2mdweJCXNxJhZFycVhwDuhrViTKbyFPNwn3/IFHE4qoe6MTe45SfQJN73QJ0UM
	 7OggC/7lT0zGw/utNTGlufR6rUeB9YVQl/4IZ4V/WAEwzdbw1wQP5wthXkd5gjDfnPwvB
	 iRRVG+SBHzAL0kWIQqr5OhccnxfoVFoUSzHYrjr+NYvKe2exmOZS0qnshe1bBXzognrrg
	 LGz8pSyTc5/EFXvQY9ifzLuhxoxG+0/CSE14mV2vKRFSNU2jVU29p6ImsPOVa7GW6LA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793176520;
	bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
	h=Date:To:From:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=zXeMdLcMpZSSuqZSoYyQWwD+fm513cJ3hYpJP2yKWt2U+d/LGxfZsj0Gx+7QfoiX0
	 kwZV/WQCoWVWA/yy//RF5igVHg/g0sFXF6fa8dvjG9SAm6Z1Anfb0XxtzSbnYwCUqM
	 mnrfACqnNAf3ZKPvHHdtlqbo89i6I1tbikTVOBFOC3dgj6X1gxdkN62ad6O+rLDIba
	 XESXvuqS6D6KKmfuiMjl1l3G4gORLqkZlkMTxOq82h3zPH7sfdRdiT6T65JGvvVlwG
	 jmY1K8CPoKi45qPPvfyBywwiSmNWPCv6IfO6CRbbgRDptKBjuL8cTB9lKxAgKyQdGh
	 KHQhXH2FIQBkw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1EC2280E09;
	Wed, 28 Oct 2026 08:35:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id BD4A44D1
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE288405E6
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ll_NeNnxG9qH for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Oct 2026 08:35:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 03A3940305
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=185.70.43.20
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793176515;
 b=Yl6vBAtOahnDQts54s4RPa0gTO7D+nSETieqYrfeOiG6g1CQAYpQMG3lgWBEu4DYJKpM
 +IEgTgVR6N7xIQQhpVgeYAol0cdOxhy08ZnWmgjlmlUPBhnx1SkvskWvmzgiHf5FIiQmo
 6VcxtnjpVv9LyNMwOMbSL35wkV2B/fSZu9HQQ6ncwbRKsWL7SrSoZTA9tpo7qYSY9z3nS
 Qnnn/ZqXNEtnZVBbGmJrZ41D/VUHTiaCpC+bpwdw5shR5ezjejnf84NgmIt7ja1foNoIh
 vkqHU6ngQadeTAaqE7D5R2uywkSd3YYHYvI1+/iyXCmlD2EEies5uGac3gbjXBRmrjg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793176515;
 h=Received-SPF:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
 Content-Type:Content-Transfer-Encoding;
 bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
 b=XNFeFIr9+39Z2bWU6F9swg5A8kyfHe7tDyWIKUzTidqRVs5VVd4Re4iAzTCUUzWGBUjF
 ecjV+KalJ248Y8Jv9nx/TabCwREb0mdwZ0FHl1cL11zju2HgL5AMtDf5imJPsDwwTBvXg
 5o5/QtIc9kZdPlAX6VBXd7AU3qrFc5eDGHlWAZky3pt19UCDNIpYTJ3aCCHpdxMRbApy/
 prmE0+3YNvj70wz+b5Fbc9pkVdveyK43Aa2P/G3YRZI1xmQ1NlXWr/werULeBGj1xqcsB
 Aidt/TSyGRgpA2WBwwEka1rBu5ca8NurtUOUYQmw8qckddaMdp0RaDztUl92/5pIjhQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
 dmarc=pass header.from=1g4.org;
 dkim=pass header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=bdhdNk62; 
 arc=none smtp.remote-ip=185.70.43.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.70.43.20;
 helo=mail-4320.protonmail.ch; envelope-from=p@1g4.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=1g4.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=1g4.org header.i=@1g4.org header.a=rsa-sha256
 header.s=protonmail header.b=bdhdNk62
Received: from mail-4320.protonmail.ch (mail-4320.protonmail.ch [185.70.43.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 03A3940305
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Oct 2026 08:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=1g4.org;
 s=protonmail; t=1793176510; x=1793435710;
 bh=UNo+eXzNSh5rOTf/o8mUpVqFkAJK/Jk6AobgGaSvO9Q=;
 h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
 Message-ID:BIMI-Selector;
 b=bdhdNk62ShXcE4vfNoNpelK+ePMQ7CaeyV9eENrdPR7raYWPe7iazd3Di02s/Rwck
 b8oDPiduOF1fk9apXdjblHLtfefgMij3/LKYqykyjUACePLRyxlkQ7ZczxskF91HZf
 /aigJxFx2xq9tpG6Htrh//zd156buw1eDgjWJQ1GqPTjJN4YL9nhImvKp0u92X3Zm6
 nf2y4XlehouLCG2BoFtBJIY3Zhsaxjk5iQMxHogCQihKd0KlQ9Rzy7kTtSg8BhrnXV
 X7N/xuO19JCHKFjzxSShghF0PweHvCwYW+03Ma2/k9fuqVKQJxROpC8crnZ+PH/h3g
 Vn7mt6xE5zOxA==
Date: Wed, 28 Oct 2026 08:35:03 +0000
To: intel-wired-lan@lists.osuosl.org
From: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 sdf@fomichev.me, vedang.patel@intel.com, jithu.joseph@intel.com,
 maciej.fijalkowski@intel.com, andre.guedes@intel.com,
 aleksandr.loktionov@intel.com, avigailx.dahan@intel.com,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH net v3 1/2] igc: only strip RX timestamp header from first
 buffer
Message-ID: <20261028083344.3047350-2-p@1g4.org>
In-Reply-To: <20261028083344.3047350-1-p@1g4.org>
References: <20261028083344.3047350-1-p@1g4.org>
Feedback-ID: 8253658:user:proton
X-Pm-Message-ID: 751edead275447b3dfb11a0c783ab0a93eaecd8f
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-15.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

igc_clean_rx_irq() strips IGC_TS_HDR_LEN whenever a descriptor reports
IGC_RXDADV_STAT_TSIP. For multi-buffer packets, continuation descriptors
retain TSIP even though the inline timestamp is present only in the first
RX buffer.

Subtracting the header length from each continuation buffer truncates
jumbo packets by 16 bytes per continuation and leaves the packet length
larger than the received data.

Only consume the timestamp header when skb is NULL, which identifies the
first buffer of a new packet. An skb carried in rx_ring->skb remains
non-NULL when packet assembly resumes in a later NAPI poll.

Link: https://lore.kernel.org/all/20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@=
aweta.nl/
Fixes: e1ed4f92a625 ("igc: Refactor Rx timestamp handling")
Cc: stable@vger.kernel.org
Signed-off-by: Paul Moses <p@1g4.org>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Tested-by: Avigail Dahan <avigailx.dahan@intel.com>
---

 drivers/net/ethernet/intel/igc/igc_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethern=
et/intel/igc/igc_main.c
index 1fb5f3cbe..41b293dc1 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -2639,7 +2639,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_ve=
ctor, const int budget)
=20
 =09=09pktbuf =3D page_address(rx_buffer->page) + rx_buffer->page_offset;
=20
-=09=09if (igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
+=09=09if (!skb &&
+=09=09    igc_test_staterr(rx_desc, IGC_RXDADV_STAT_TSIP)) {
 =09=09=09ctx.rx_ts =3D pktbuf;
 =09=09=09pkt_offset =3D IGC_TS_HDR_LEN;
 =09=09=09size -=3D IGC_TS_HDR_LEN;
--=20
2.56.GIT

