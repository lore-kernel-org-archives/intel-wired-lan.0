Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9429FCA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4CC468124D;
	Fri,  2 Oct 2026 13:08:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id e_Vo6b91wDpA; Fri,  2 Oct 2026 13:08:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org B808E81232
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946536;
	b=ZgBfGBs3iPPYhzfllLOOJLfQIX6bKbz+n7r0VRenCLvtQumrWlFrHzDJbGpaDKgvSjij
	 3qrEvHyGPh2b7kHfcJO4sWUP51ZOZ0Ghdm1lw1cZwiYe98p0DiwEkaCkx7yYcfpprGLtY
	 9soaJCF4aCC7DTblaebEIL4RU1OD1qzFp2mrNH8+intHQz81eGwfODSz5HZ5EtwjVf1Qb
	 WxtGnshIbxj4uOYz716WkXfD/lehCaqm5KB3dBzuc8lpUa7XC/JC/zt0BeV7sS5jvucac
	 m4YL46smLFmLy5WqPF/FJJato+5J0SbiSfr7aJKrhaZ3XPWmiwhbwZH+iYsAl3arw0g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946536;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HVAaLUhTqMoBr0N22nVTfsPLBxCK3PYhH7rimPVG0u0=;
	b=MjeX+k1BFl31f7jv7MAQ204aCSc90GQbOoD2COsSxTOfKwXKm9QXNvG/uBzmZ4M4ahin
	 HUvEJbN3nG0mnjbeAJP+Ys/dyvCbSyBVaaeaoyuWcI7Ajxqvbaj79Z6n/jEiRdImfmvjx
	 CrOqGS6ANS/6zcS/U0xlqLPwgwXzv0m7cjpolWdAGGpinZyfD+ebEzP1dnitGrwX1fuXC
	 9dO74fiyrFYjXtmpndsSMt0QK0PDyD+DrrtUq84Z3727rBxGk94uNWI0TsQVya1HH3e4T
	 0thmngW0gmOpybK5BLBIDO+7/M5N/98XgwKoqlhtjXGhcpQiNhq0LJ6Lqn3hka/FPgQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946536;
	bh=HVAaLUhTqMoBr0N22nVTfsPLBxCK3PYhH7rimPVG0u0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=onzI3YalL17jJQKeRyZJj37tojIh8VB/ckrgvFAeopKVoSb1yeXBSJCK75EbYYaQs
	 mVkxQjOjzhR0q+9yq/Z1fOxOLveWfjVF1uOhObMumZTDhfwUCMAnN/V33FMw7r/fn7
	 KRDAN6iLYCoeuB3Mu9qyYArK6eAQ0UsXpjQ5KhJIor4uE+Yo0zuoHBmL/4mPBR11rm
	 A+EsyxYy92wHdz6HbnXdDvqyYu6z+RQjzW8KNSztOAjnaht/fiu0i+Kh0KypNuSgr4
	 wwG2l3bPI0/pWajRaH3Mk1D1GY9EZYeMWHEk1Bly+CIRv85vSPg+q3CxZBvkTWC76p
	 xuhosd6OojKCQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B808E81232;
	Fri,  2 Oct 2026 13:08:56 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9B30A34D
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8D59B40CAC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id BhhwgYJFKJtX for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:08:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CCACB40C03
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946535;
 b=MGhigAYVEHN8d7Kx/T9JHC88WnyVd8PAyry8Aqi5xhTwEHPDYSIcgfj24ajIRh+4Sk3C
 z1YIZJQm96ZCCWcqDcG7G2ST0xr2aqorbI3a3zJpAwVP/+hRZDtWiajS5pmYChMycHk3H
 VGKawJOqbRb2RFaI/W6J8ac4C0eThSj/WCSmKS1uheJeH8R+J6hfqcgea+I+wPL0yiU7c
 RgaLtZZ6/xZtcx7noBHwZVkmo96OZzUcs58rkc24/w8IaHS7K8uvhxF4IHv1jStToE3wN
 M0lNJoQAEKhJN2nKLa8EXvSbTcqNDB+EYE6zrdw1UEUq20GYRCLeFJppKxrZxRkmtlQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946535;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=HVAaLUhTqMoBr0N22nVTfsPLBxCK3PYhH7rimPVG0u0=;
 b=JNQYs6YASd2WTUOAM0k1Ex1dJSBTxWiibyK6oN7FnmPOQyQbe6f0++ilBNktycgRxrZo
 AZO/H099P0SuUXOd/kZHX9SHXqOw8RwQUfalPOVMCZ0uX15ZGtv0IsVzpZFNsXMJtla8F
 01eizMdCjj8AcpSUJ+IWUhLLP9aQbuE7AIzncEyu9f0H8mw6aZiS9D5WP/jNj0i1PtHg9
 09/oL6MftPlMvUfFKdGjtL/qPCyONNWLLRjfkXXs3CYp42SD7ADaHHV4GOcrP0VwFnX1T
 wvY3ohaWbQ5dZ6pX1J/KYqD41ZVnBLHcm7GzoPTXZWYYzval1buAy3ruNFBkWTq7GhA==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="A/pv9Scq"; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A/pv9Scq
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id CCACB40C03
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946533;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HVAaLUhTqMoBr0N22nVTfsPLBxCK3PYhH7rimPVG0u0=;
 b=A/pv9ScqkJENaQq/Nh73ttPUyykOhSLmh+v0yU3Tg0a0usRclpyqJxqojGkyZa+Ik0VZ17
 eHtsdhNPshv+0a9LCD5k9Xg33F/YT3tNcnAhmy6GpXDtG8RN2MUXizg/yEvcGGzq1Q/CCP
 4YDQQkf6Yrv86MdYey3guuaOTG3yXRE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-119-eqv7YGLcP727CC3BAZGHdA-1; Fri,
 02 Oct 2026 09:08:47 -0400
X-MC-Unique: eqv7YGLcP727CC3BAZGHdA-1
X-Mimecast-MFC-AGG-ID: eqv7YGLcP727CC3BAZGHdA_1790946525
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A3401195423D; Fri,  2 Oct 2026 13:08:44 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1B627433; Fri,  2 Oct 2026 13:08:37 +0000 (UTC)
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
Subject: [PATCH iwl-net 06/10] ice: keep adding MAC filters after one that
 already exists
Date: Fri,  2 Oct 2026 15:07:48 +0200
Message-ID: <20261002130752.2597259-7-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: TJWOCwwrWknjgdcBrUAH8zV3JGwZHm2Mz_vKgO7qwzM_1790946525
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

ice_add_mac() returns as soon as one entry of the list fails, including
-EEXIST for a filter that is already programmed for the VSI. The rest of
the list is never added. ice_vsi_sync_fltr() treats -EEXIST as success,
so the skipped addresses are considered synced and their traffic is
dropped until they are removed and added again.

In a test that adds 50 multicast addresses to a port in a burst with
the port MAC address in the middle of it, 19 of them were left without
a filter.

Continue with the next entry on -EEXIST and report it once the whole
list has been processed. Other errors still stop the loop.

There is no i40e counterpart of this fix, i40e keeps its MAC filters in
a hash with a state per filter and syncs them differently. It was found
while building a reproducer for the MAC filter overflow handling that
i40e fixed in commit e58872398684 ("i40e: fix disabling overflow
promiscuous mode") and commit 7363115efb04 ("i40e: do not force filter
failure in overflow promiscuous").

Commit bbb968e8b34c ("ice: Fix issues updating VSI MAC filters") dealt
with the same problem for the VF MAC filter requests, which are now
added one by one with -EEXIST tolerated, but left ice_add_mac() and the
PF filter sync as they were.

Fixes: 89f3e4a5b762 ("ice: Do not bail out when filter already exists")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_switch.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/ethernet/intel/ice/ice_switch.c
index 2ee5cb6ffdab1f..239d4d9633baa6 100644
--- a/drivers/net/ethernet/intel/ice/ice_switch.c
+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
@@ -3659,7 +3659,9 @@ int ice_add_mac(struct ice_hw *hw, struct list_head *m_list)
 
 		m_list_itr->status = ice_add_rule_internal(hw, ICE_SW_LKUP_MAC,
 							   m_list_itr);
-		if (m_list_itr->status)
+		if (m_list_itr->status == -EEXIST)
+			status = -EEXIST;
+		else if (m_list_itr->status)
 			return m_list_itr->status;
 	}
 
-- 
2.55.0

