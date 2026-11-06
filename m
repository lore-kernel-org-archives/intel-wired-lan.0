Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347D1606A31B
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Nov 2026 00:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=hkJcM/LK;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=igSjbz6z
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 039AD408E0;
	Fri,  6 Nov 2026 00:25:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 5X8KHBvQs4GP; Fri,  6 Nov 2026 00:25:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 362EE408FC
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793924754;
	b=rHIr6rIlo++7g6aLAXfylYkAaCjPRwuGgcgEJPOvmPOxeXAX1NrKfR4SUXv6kaNu+1B9
	 vS69BM3/+nKuUidrq+j2meE/EBKo0ve96H3snJ9PEMwrXdaPGvYcH62jQXRPwsYJZvlJs
	 i5QA1kAPYQ/2pqzZJ52qj/zdOreve7RByMy9r8v41OiHPjB7d5ih9QFBOJtUzZqzusxqj
	 9mHuWBdjgjNKgEF0SQsy6WsdOCgdm+gtjYnNP3zGU904bJ0niUGvBcDNa7StYce3H/RbB
	 jvN1tlVkvC8WlfoEnJE2JOMQ3XRcsWa2MVZV7I2SS0yarzYSCNFeBkq5rYHxN0qqOXQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793924754;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Received:
	 Date:Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
	b=JJXeyhGFt83thYfeyIf4fT1napzA6fwhTHXJKeZzn7ToeAOwVe7lHzFPKaSMUm/mk1Au
	 18Eu0GrwueXtEmzjMMIld7fHVfxCyi+65Jkfod6c1tY62Us2fd4H9unxLRJrdNjX/htqW
	 lBnPqR6i3B8NvXVkuoj/ZLFkX2NIM1kdVfdUnR8sLYS9PUCP8fSTv33Fd53I94OWG0Yuu
	 aZNKqpkiRrv2n2FbUaRo/wWO5oJjDyTvQQDe6dC3lTBCjCc8SRHcLu3EhkhlsS/jBSY2l
	 4vDmFgQ60CkJlSqTXds4LHnrUa7D4Z9SEXIZ7WarcM5qWdRp1vwO7ch+D7LjReVo2Cg==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1793924754;
	bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
	h=Date:Subject:From:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=hkJcM/LKL2OMu6FtpVXm724m+g9wt8OTnQOM4dVyE80mXgHMquNwTFP9AfglZjEZZ
	 Mep69ohmwSV/yBW1HuxYEgsJkCsPO2DKUVENMPAneiB8hmfslskJmaZw2lFSyms7MI
	 /fxP8/59A1TwT23T1qqh1YVhDkaPwZYPo5Pduar0KslcOkEvv+lhOE+m94gf0txIPr
	 vO0z4E/nPYLRUZfctLqqf/Zs4VhJqCzxQicxWgEN3xzuo+md4QqC0WFTzhzKG6Zp3w
	 xJkBlLi8u5lDths6cbGj5BRxuyc9BknGjLWQXFgk1wuu7Y29XV4UUk7FYQlg48vDvd
	 wOQqIsrGWTl9g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 362EE408FC;
	Fri,  6 Nov 2026 00:25:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 38DE3235
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 00:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AE1D4010C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 00:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id TstdCCHftrip for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Nov 2026 00:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 3F451400F9
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::848"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::848; helo=mail-qt1-x848.google.com;
 envelope-from=3jh7tagskan0m9l9mftk9shfnnfkd.bnl@flex--namangulati.bounces.google.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=google.com header.i=@google.com
 header.a=rsa-sha256 header.s=20260707 header.b=igSjbz6z
Received: from mail-qt1-x848.google.com (mail-qt1-x848.google.com
 [IPv6:2607:f8b0:4864:20::848])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3F451400F9
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Nov 2026 00:25:51 +0000 (UTC)
Received: by mail-qt1-x848.google.com with SMTP id
 d75a77b69052e-536720195ebso1250511cf.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 05 Nov 2026 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1793924751; x=1794529551; darn=lists.osuosl.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
 b=igSjbz6zZ7KMMLoUAGHYQFE67kLl3v02KvYsqi9dJYwbO47fNa0rE5cPvVfUI7vLF5
 /XcQ1YgugInqxW0eO1abDzWfWniOcefekr+4+8K1S2+qZzr9PMU/FfxSP18orm3lJpO5
 A89+BVYLhJi6S/+jt8X1Cu8puoGmeoxh9b14owMTqDi4HWLoOKfUQQizltVsMbzkIHLF
 MwIj/dXJqF7XGyesn3n6qPH1yMLu/w7MRMFhqU4Zh/gHFZ3JM6qyhNeqrOueWzmgEP6T
 OwDmsB6RKz2SVu9+tHEv22NtxWWFxI/34+0mtodb7hfPG9qlvolCAgXvPolSlo3vJ9iv
 I+Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793924751; x=1794529551;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
 b=rJi1GaQgZGJun8Y3EZpNj9duCTiy1TzaWBwSOXmGReinNlChlC28pH7Lf3Jg9eAUq+
 f7VOHZWaFKdSxnsch2AFwnowh4QveWFReA0uXSNr3dfnQ0pxLBBumDzigMJD5p/BTYwq
 kNEknDY3BwZIcjUJFH6qPtvtwByXqvf4Ckctt1qYwiXt63mLYF3z7vtmCGqQt90BiEgZ
 2pB4KLpyCPhRn4KAZhuMe15SUCKuiHIzkBvSW7CQP9T1MWfnDche5brX4ODHkAdYs72T
 KZebyThZ5TREIv6hhWgD9j1bcaV+Z9HwhkJrx1zpsei93oK3KY2aLquafXqgCjnlOeyc
 ZtXg==
X-Gm-Message-State: APuU4Z98hMUxkVAOcSx6MoPGB81wQ0JDrSzlu2mxr4MqX1frQqvi+CV1
 hlQGFJ0J9z2e5dTkPY6Rc5TBdaacz/SpLvRWna549vu5OCO2gY2OgdXeCFNvMfJ/JcK0iaZYWSO
 7CT8CgNsoE0dNhEgkbYa3D8Thd5SkP9bhOxC9wn8/IMHNrldycZ2FKeXbv0ttTZfFZuDf4OjOtZ
 VhgzBQUQCV+dAIsKqrQBX08VCKL7WWE6UUjuXVfMK2VrD2uL3JiJlv1ql28yoawh3KQG7ViMVHj
 B22
X-Received: from qtvx8.prod.google.com ([2002:ac8:4d48:0:b0:542:fcb0:6027])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3c8:b0:535:14f9:3f02 with SMTP id
 d75a77b69052e-54e1566b67cmr16452671cf.58.1793924750173; 
 Thu, 05 Nov 2026 16:25:50 -0800 (PST)
Date: Fri,  6 Nov 2026 00:25:46 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106002546.2100412-1-namangulati@google.com>
Subject: [PATCH iwl-net v2] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
From: Naman Gulati <namangulati@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Brian Vazquez <brianvv@google.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, 
 Naman Gulati <namangulati@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

With header split, idpf_rx_update_bufq_desc() allocates the payload
buffer for a buffer ID first and its header buffer second. If the header
buffer allocation fails, it returns -ENOMEM and leaves the new payload
buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
consuming the refill queue entry, and the next NAPI poll retries the
same buffer ID, again starting with the payload buffer.
libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
buffer is never returned to its page_pool.

Each such failure leaks one payload buffer. The pool's inflight count
never drops to zero, so when the queues are re-created or the device
goes away, the pool never finishes shutting down and
page_pool_release_retry() keeps warning about a stalled pool shutdown.

This happens when the header buffer pool runs dry while the payload pool
still has pages, for example under memory pressure: a header page holds
several header buffers and only goes back to its pool once the skbs
using all of them have been freed. This was hit under high flow count
TCP stream tests with memory pressure causing RX header buffer
allocations to fail, and validated on idpf.

Release the payload buffer when the header buffer cannot be allocated,
as ice_alloc_rx_bufs() already does, so that the retry starts from an
empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
teardown cannot release the buffer a second time.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Naman Gulati <namangulati@google.com>
Tested-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2:
  - Add Cc: stable@vger.kernel.org # 6.11+ (Alexander)
  - Add Reviewed-by (Alexander) and Tested-by (Brian) tags
  - Note how the issue was triggered and validated on idpf in the commit message
  - v1: https://lore.kernel.org/intel-wired-lan/20261104013606.1527767-1-namangulati@google.com/
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..7383d8241ead5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 	fq.truesize = bufq->hdr_truesize;
 
 	addr = libeth_rx_alloc(&fq, buf_id);
-	if (addr == DMA_MAPPING_ERROR)
+	if (addr == DMA_MAPPING_ERROR) {
+		idpf_rx_page_rel(&bufq->buf[buf_id]);
 		return -ENOMEM;
+	}
 
 	buf_desc->hdr_addr = cpu_to_le64(addr);
 
-- 
2.56.0.455.g6c5a503b38-goog

