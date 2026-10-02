Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3FCBCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 447F440C03;
	Fri,  2 Oct 2026 13:08:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qkaNtm8C8BMI; Fri,  2 Oct 2026 13:08:33 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 9E79740CAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946513;
	b=inrg9Ksdq3/bS5PD2aMGhPnWDeBc/PCcUvxOjCsjhxwDdbOUugyy0TDq9P+CGncn2kUm
	 RlDVrxmO3GQStkNNsHVgh0ePf6CWjDMEOUbv3dQspwSrzSA4RRRXamCWDSgKpZ/ysJJPi
	 sVLeBpXRlGBb68ZkoS0icTvJdFVyNTHnRL85W1iCQm9aqBB3N1MP8bltyphWUUv/nPZ04
	 AFhpeT7HPpwqtVx8GHydSnPS6dA5jk1BmtX0/O2LYm+YOLUaciiDqOTUAaqN0VHGve748
	 tA33n10rjN96F/HjvuTHTjV2gY/zmoedVDx+22bt5YXxUXtNxublqs6jFucYyPGymgw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946513;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=W76JwHWwSP5UMXZ3360bvlY9alCmFcEj7PuZV/VZQ+k=;
	b=cChUVVUI+uBQS8BV0kqt8UY29vJKKZY8bK3b44lliQKEXIsxrKBekLmDxIP6/DzPIZ3Y
	 zMZ72wptcsEj5zCvtb0qjPrkDHIaFnu906d/BVq4daqqBSgm+ZXf0bFxZCHgSENtUOFxn
	 4M0xaCHLXqUz4xFaY65cCtt0XW9QVkskbMR/n5KwoBoahXtcJFHsWnQdJYTiNx+eT0llm
	 ub//IsQTrbQEMSG8g7afE6NArjgUhaVeyFv2IaUNiETSI3bjFGXAz5LXpL1b3I6cwTb6S
	 cEQP9IlIR7LpMll2v8YHZiyGkKNgkhDG5vWzrmuWY2V23WN0xE3Qk+TJv4rJmGeDJ6A==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=huX1cSn3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946513;
	bh=W76JwHWwSP5UMXZ3360bvlY9alCmFcEj7PuZV/VZQ+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=e7U9QXtPuoFtBgE8by5INb2xIGSApjy4eQIXQA+fVkk0jXqNULitmE8YDKOy/fJNV
	 pTkEEBX0hX80LfcT7xKyvaZ9pYhGPgNWOzG4gpipV5XnPLpj3+OpluFHKpzGzArwOa
	 jxDd2JhbOKMvNO4wZQWgtheBEVizR6/aqXjTna94rkYep0kh9/+s2k9/5vHU+paNHx
	 Llk+ggJftIVfqw9L/aBSIs7/Zl1RVI1peNQhDUQnwFJHmlhb/hv7NRXHfLY+g+tOoq
	 mK2rWZsp2jd0mPfTNSqadMAjx+OT0Uz9grO96/J6kYWhb5oNs2yivt1MgBBqn77moI
	 uBcG+tzjLmyfQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9E79740CAC;
	Fri,  2 Oct 2026 13:08:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6CF4834D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5E7A540CAC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NQ-YeSlLdWNk for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E7CB640C03
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946511;
 b=LVz8fFTfsvhmqzrIoBMjsTKLgM5Ra9of5KU7SNUmWkeaxtlbwcvUgdTyzW+ebEZ7gA7O
 NabH7Vj/nOp+wbkwny4WOQCVMY6hzyuoRH5faodfPdodgIngBOh4tthXBKuil4WUD6hJU
 zq9/VBoB/FsMzlOMhaWNJTvwT48Xw9pRxIQb1F6j2qjmv4p5hEUUXSIfxgEOpm/v5FVi8
 hCoHaji8JBvFsra8TGu+l1nRLg3iQjQi95sC7MaaIQzgZeT7nh8fjKaqE28Ggdn4L+3bo
 Ui/Q/6CIdHwc+IL0+c1E12e8P20xnKfPtJRqvBJ5yFLJLfTA2YUDOQF5kufVs/3bdBg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946511;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=W76JwHWwSP5UMXZ3360bvlY9alCmFcEj7PuZV/VZQ+k=;
 b=drBXhP1fN25QEtu9Fwmlhu/BhXmhsQlgpjHTdFsPw2kpuTR/Zqer5i5EkQeqI2lpKUiu
 uOipYjq3AtSu5opV7HPEeNzeh+m9VFqD9kJ8g7PsUyTyhyilERaT2Fx/SoCNsuMwCfHLa
 FeW3UAu7YYWl9GdWP2eZN8oU9Je2fBwlHMLpJ0G0TRxEDZ8c7lx1oV67n2wgkaiLINiCu
 Fq9oVk/xOW0OV2H9aqHAyfvW7t6MlqeLV2nNuiQL6EabxuyB3LBJinwv30Hbx/lielTcI
 1fS8WcUdW02bkQrpd0ToEeGyr9zE2j+1A8qRCPRtswIqk04X+5VPlDzx+xq8XUAl8vQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=huX1cSn3; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=huX1cSn3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id E7CB640C03
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W76JwHWwSP5UMXZ3360bvlY9alCmFcEj7PuZV/VZQ+k=;
 b=huX1cSn3U2j4x1l6siduosJ8VXzcD8RlO4sVWsEZeWXEYGrDSuBdttQx/jM/Eo7rKsuQWe
 vfzMgOsdef+HNKuNY+prWhTZNHdPIwicakUJ8A+HEF8RQxYYawdufj+L/SeisQ5p7MJDCm
 8fxNxJ9q15diN2XU0U4VeecgmJB3oEo=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-414-DjAbGEWVPKWUXFJf5YJa2w-1; Fri,
 02 Oct 2026 09:08:21 -0400
X-MC-Unique: DjAbGEWVPKWUXFJf5YJa2w-1
X-Mimecast-MFC-AGG-ID: DjAbGEWVPKWUXFJf5YJa2w_1790946498
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 191BD195423D; Fri,  2 Oct 2026 13:08:18 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id DA267756; Fri,  2 Oct 2026 13:08:11 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>,
 Henry Tieman <henry.w.tieman@intel.com>,
 Anirudh Venkataramanan <anirudh.venkataramanan@intel.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Jesse Brandeburg <jbrandeb@kernel.org>,
 Preethi Banala <preethi.banala@intel.com>,
 Kiran Patil <kiran.patil@intel.com>, Dan Nowlin <dan.nowlin@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
Subject: [PATCH iwl-net 02/10] ice: fix IRQ freeing in ice_vsi_req_irq_msix()
 error path
Date: Fri,  2 Oct 2026 15:07:44 +0200
Message-ID: <20261002130752.2597259-3-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: OCEDlTtXy0dBX_7vV4VtLSGfhohsATs9KQn5hiTLr6w_1790946498
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

The vectors are requested with the q_vector as dev_id, but the error
path frees them with &vsi->q_vectors[vector], which is the address of
the array slot. devm_free_irq() finds no matching devres entry, warns
and leaves the IRQ requested. The unwind also tries to free vectors that
the request loop skipped because they have no rings.

Forcing request_irq to fail on the fourth vector during ndo_open gives:

  ice 0000:04:00.2 enp4s0f2np2: MSIX request_irq failed, error: -16
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40
  WARNING: kernel/irq/devres.c:191 at devm_free_irq+0x30/0x40

and the three IRQs stay registered in /proc/interrupts while the
interface is down.

Pass the q_vector as dev_id and skip the vectors without rings, which
the request loop never requested.

i40e fixed the same mistake in commit 915470e1b44e ("i40e: fix IRQ
freeing in i40e_vsi_request_irq_msix error path").

Fixes: cdedef59deb0 ("ice: Configure VSIs for Tx/Rx")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index f2121e79fca993..d246cde36ae726 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -2582,8 +2582,12 @@ static int ice_vsi_req_irq_msix(struct ice_vsi *vsi, char *basename)
 
 free_q_irqs:
 	while (vector--) {
-		irq_num = vsi->q_vectors[vector]->irq.virq;
-		devm_free_irq(dev, irq_num, &vsi->q_vectors[vector]);
+		struct ice_q_vector *q_vector = vsi->q_vectors[vector];
+
+		if (!q_vector->tx.tx_ring && !q_vector->rx.rx_ring)
+			continue;
+
+		devm_free_irq(dev, q_vector->irq.virq, q_vector);
 	}
 	return err;
 }
-- 
2.55.0

