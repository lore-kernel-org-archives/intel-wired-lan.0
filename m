Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE52DC3DA7A
	for <intel-wired-lan@archiver.kernel.org>; Wed, 28 Dec 2022 15:53:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 54650402D2;
	Wed, 28 Dec 2022 15:53:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 54650402D2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1672242780;
	bh=deZ5hMypfUk/X4kCxFxSAKWMa5WHVAP9YbYsvAKDxJM=;
	h=From:To:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=S7ZVfKhXKaLEiWKK+ow7IZlY6mlLhu1ffsUovY6yLMA7KTLzFOjjBK3KkjnL19XSH
	 J86Wf7m/hH9XniJZ2psWLL/KuExKKZCiIF30tPI3TpmySu5vQ4cQh1iAL8biOZT2gA
	 WdQFBWAD5QH/WP+UgqOEFg7lJ+H1xBIRi1vF6Q8cRerTHEa2nrJtnFAyXVq0odpfYJ
	 HYyVXIEr4Hr8mp5S7rf71tG3/Rq9sOqAfnaZt81MlbBj0Uo/f/vXhxa4Syg0+7ezyc
	 kKXmABvOhYuZBez55AYWxRUTghOuMn9lpeLomCwvb8bYCIzjLT3SJvSzHkrMDlUrFo
	 fBwut4FUZl5dQ==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZcOERhF2MRdK; Wed, 28 Dec 2022 15:52:59 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0514D402EF;
	Wed, 28 Dec 2022 15:52:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0514D402EF
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by ash.osuosl.org (Postfix) with ESMTP id 64E7D1BF3C2
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Dec 2022 15:52:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3EAFA812DB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Dec 2022 15:52:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EAFA812DB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yVFHGXjIRPo8 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 28 Dec 2022 15:52:56 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 68977812AB
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 68977812AB
 for <intel-wired-lan@lists.osuosl.org>; Wed, 28 Dec 2022 15:52:56 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6D87BB81730;
 Wed, 28 Dec 2022 15:52:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3FDC433EF;
 Wed, 28 Dec 2022 15:52:50 +0000 (UTC)
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Date: Wed, 28 Dec 2022 15:42:30 +0100
Message-Id: <20221228144315.148014413@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144256.536395940@linuxfoundation.org>
References: <20221228144256.536395940@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=linuxfoundation.org; 
 s=korg; t=1672242771;
 bh=M+k0+5VQoTiQ28+qOM0SuLz5NZ4u1yl9Hi3eY/xvBAo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GowJcS2S2btxdjrr8VsIVQa7Ijk5KFRHxcX3uLOdr9wpzvbEz9uxID0UPmRL2A13l
 eMmU70xBM/WPWlBf3kvov0kF+ZY/Ljk2swP9sGvUkZmcHrbii3EQv4aXPBYWfiphRN
 S3SQTbN5DlCd4Hyev+wtzYQcOHicKmgfRMxdtGQU=
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
 header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg
 header.b=GowJcS2S
Subject: [Intel-wired-lan] [PATCH 5.15 643/731] igb: Do not free q_vector
 unless new one was allocated
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Sasha Levin <sashal@kernel.org>, Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, patches@lists.linux.dev,
 Jesse Brandeburg <jesse.brandeburg@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
 Tony Nguyen <anthony.l.nguyen@intel.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

From: Kees Cook <keescook@chromium.org>

[ Upstream commit 0668716506ca66f90d395f36ccdaebc3e0e84801 ]

Avoid potential use-after-free condition under memory pressure. If the
kzalloc() fails, q_vector will be freed but left in the original
adapter->q_vector[v_idx] array position.

Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Tested-by: Gurucharan <gurucharanx.g@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 70667b46858a..b246ff8b7c20 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -1204,8 +1204,12 @@ static int igb_alloc_q_vector(struct igb_adapter *adapter,
 	if (!q_vector) {
 		q_vector = kzalloc(size, GFP_KERNEL);
 	} else if (size > ksize(q_vector)) {
-		kfree_rcu(q_vector, rcu);
-		q_vector = kzalloc(size, GFP_KERNEL);
+		struct igb_q_vector *new_q_vector;
+
+		new_q_vector = kzalloc(size, GFP_KERNEL);
+		if (new_q_vector)
+			kfree_rcu(q_vector, rcu);
+		q_vector = new_q_vector;
 	} else {
 		memset(q_vector, 0, size);
 	}
-- 
2.35.1



_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan@osuosl.org
https://lists.osuosl.org/mailman/listinfo/intel-wired-lan
