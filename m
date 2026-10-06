Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A57FECA5FFE
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 71C4560796;
	Tue,  6 Oct 2026 14:41:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ir5oSM3KgozQ; Tue,  6 Oct 2026 14:41:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org C2B116062D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791297714;
	b=DQ7qIgBdTNMtjghH2EKjl5pynw/sgjWrlC4Nh8qf7txgPgtLTyCLUSVdU1lTiQl+fXHH
	 0aYl2/2NbIq7mha0T2hU5zA0LC+sVQFZvxgNkrlMTtOX07SExpT0MAVcoyKTTUK5gjrVb
	 aGGCZS+w9MRMOh3GZ0e0UL9p4u6WY74auqrb55Q61m+vNiee3K3I1+871TfZ8ZYlbLk3d
	 ny6Q7wmcuWAZjLK27xLbLE9ShhMd9Jm0GKBQcSfEymwKOeDS3ApimuyC6PkESMwczsX+0
	 KKuy9L/Sfk8BFLoIBC6a5KeF5PoimumNZWOSU4SAg5P6sSuK9hlyoj0iHsXfJeyPjrg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791297714;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-IronPort-AV:
	 X-IronPort-AV:Received:X-CSE-ConnectionGUID:X-CSE-MsgGUID:X-ExtLoop1:
	 X-IronPort-AV:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=ZfJa6vUXFhelYvuHAscsrBqlWVQVgljUl/ieMPDAORI=;
	b=mvakI0AVqHgSHNdvn8rDqULNV3VE1fgJZf4eVjSrK4k1BKncjIRh77krTlJBV0m5aIec
	 pMDaLtR0ChU9CkEAD9RCC5Gq+LK1WrVmVz/34AOcssGn/+NKPQBtY+gA1oZrX9ILcEccA
	 8BNjdwwsfxWPHQfzEdMi1FZbIEd8ilaTFZMJNAtKb87CTBOs6ggnPBMVrYz2yAAORJjxc
	 lghbfsqST7AtrbNCA8oypAXWqhOh4psZjuxWz+ACHsK1jZzdcpUXosiRK4suR5crfGn+c
	 53Ypv52mtx00xpWu9Xp9sml6pg/0OAb8eCvHg87m+gposa5NIEK5ENxCBJZETNY0DAw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791297714;
	bh=ZfJa6vUXFhelYvuHAscsrBqlWVQVgljUl/ieMPDAORI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TdG0GHvgFQetzfvmxcVCDCskWHBmTRtD5D1oLej68Q7K21Ml+N8RffJAIRZGEigt2
	 9AyPLPcG/Rfpzo9PjWInNeQCjHLkDR5dk7uhAS+rhu/RygMlEUJ3NjaSWixmeQM3CZ
	 hI1X2g6qkrsbHVDh+iiW65UUG8D3m/glUwk5735tCvW0oI5ygNccwJECwBjLE3yPKP
	 72+B4Ff+eDzLYcqRFVPFz3P9sb2XGt26NoM24/ayhXVkhwwzEMoGkruJXUrkbSJ0zy
	 C9p/w7XY6Kr2bmN58ktTVXLzRvImdrY8+qV81e0uJUHc32j2Eqbz0f3eslv52AHBm/
	 bV2yjPc1RBKFw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2B116062D;
	Tue,  6 Oct 2026 14:41:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DC20D361
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C8B194027A
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rAmx4uaR_g2J for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 14:40:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 02D5C40274
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=198.175.65.10
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791297626;
 b=BOvziWkXrVYkxYGD31p+YsSfT4K+RwRMK6TEJXyb4rDB7jWVVEoSd5J+ChxwMPMwTDDy
 MTUGPkXhK2Qooktww0rfNAAiwsFtWk7pcptVSFzDXbFvilEmEDAF1pPtEblwIGwz6N/lI
 llU0QiXK8fs1ak1o0+XwBv/pW7Hq6AqC245iw7Mx0aAhpYlegfsIqCHLtod9L7DX0l3FS
 yAdWbIuoY/srG85aAs27vb8A4dAcwABwGZRzefy94ZQPxqmsiP4TeEfqodZolLvJz+NYV
 4qmpTmdLqXG+hylgsgegsZeGgOpEBdP7fgOEsLTpzKx07dGQzyt1BXpPqZG88iuifsA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791297626;
 h=Received-SPF:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
 X-IronPort-AV:X-IronPort-AV:Received:X-CSE-ConnectionGUID:
 X-CSE-MsgGUID:X-ExtLoop1:X-IronPort-AV:Received:From:To:Cc:Subject:
 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
 Content-Transfer-Encoding;
 bh=ZfJa6vUXFhelYvuHAscsrBqlWVQVgljUl/ieMPDAORI=;
 b=j1O6jo2NgyDBM/7C3eZ/3adzGjb89ecxd0Omqumym+6Ch/452/4bi0GULYZByuF+BYf2
 2Mg1CS1pV6yRLfccyL3woRwBZBygMDm/A0hCSmwSYlVessmEJSPp79Oiam2mS3P+OI66i
 RJMu+pGGnlIhl31vLF6agg9YirxmKwbEbWB1wEQ02hve4fRn1O5TX64DQNhiFSxop7eWs
 EnVrSY6hufQYz2tvu873d0gAGJMiBYiEW9SOT13M12uYt7O+qkWbZDHWr+WVBqoo38LcK
 OZ3vyxlL0s0FQBhchqJVaEG3rMUmLW6DYZXBePWWpR+95fCrAVmKpK6dY7IrrBuOMOA==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=intel.com; 
 dkim=pass header.d=intel.com header.i=@intel.com header.a=rsa-sha256
 header.s=Intel header.b=OmmHWLwZ; 
 arc=none smtp.remote-ip=198.175.65.10
Received-SPF: None (mailfrom) identity=mailfrom; client-ip=198.175.65.10;
 helo=mgamail.intel.com; envelope-from=aleksandr.loktionov@intel.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com
 header.a=rsa-sha256 header.s=Intel header.b=OmmHWLwZ
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 02D5C40274
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 14:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791297626; x=1822833626;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=MWD638znLHizKwxoyd1xFnLZGc3jPBjzadKDkb4fNsQ=;
 b=OmmHWLwZdwN67sln2sUiYGTKJmB1baphK/HQ+PcUFHoFLSlybVrDSw9u
 gseWoXazpqznSNYlbkjPiN4TTGjUyrwgjsxvX1Q+I7TnEpwkT2Qsmqgl8
 L2PSWwFcYafiGQC73Z+XuWlTE9l970/oymwr7U9cD5JEawhpOljXVkUzj
 WgfkFXnUcXb0PPm7QY//jrBTAO63WHdIPwj+RJP/FOvhE5uonyuKlE+rx
 FLAI62+8hYeqxMl6DZkbxYV47JELkEvmwfRWDLCi7q967IUu9BSYnXuye
 2uzcWHB9YMZAxuqLBDOQuWZeA/D1anC+5dYhIfmRYCQ8kvifl9Lm4hO0u Q==;
X-CSE-ConnectionGUID: twdE9EjJQzCQA14SI7/Fgg==
X-CSE-MsgGUID: igk0yVBmR0GbxPIi7KDZHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11927"; a="108363416"
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="108363416"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Oct 2026 07:40:23 -0700
X-CSE-ConnectionGUID: bVOtb+auR9mgVbjxRhBQ1g==
X-CSE-MsgGUID: kQ979MCVQiWe8QA1efXo/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,143,1787036400"; d="scan'208";a="315187475"
Received: from amlin-019-225.igk.intel.com ([10.102.19.225])
 by orviesa001.jf.intel.com with ESMTP; 06 Oct 2026 07:40:22 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
 aleksandr.loktionov@intel.com
Cc: Simon Horman <horms@kernel.org>
Subject: [PATCH iwl-next v2 1/4] ixgbe: lower IXGBE_ITR_ADAPTIVE_MAX_USECS to
 prevent RX starvation
Date: Tue,  6 Oct 2026 16:40:15 +0200
Message-ID: <20261006144018.2885932-2-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
References: <20261006144018.2885932-1-aleksandr.loktionov@intel.com>
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

From: Alexander Duyck <alexander.h.duyck@intel.com>

At the current maximum of 126 us the minimum bulk-mode interrupt rate
is ~7936 interrupts/s.  Under sustained full-line-rate bulk RX traffic
this is low enough that descriptor ring starvation can occur before the
next interrupt fires.

Lower IXGBE_ITR_ADAPTIVE_MAX_USECS from 126 to 84 us.  This raises the
minimum rate to ~11905 interrupts/s (~12K ints/s), providing enough
headroom to drain the ring before it wraps.

Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
index a530439..05d0049 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
@@ -475,7 +475,7 @@ static inline unsigned int ixgbe_rx_pg_order(struct ixgbe_ring *ring)
 
 #define IXGBE_ITR_ADAPTIVE_MIN_INC	2
 #define IXGBE_ITR_ADAPTIVE_MIN_USECS	10
-#define IXGBE_ITR_ADAPTIVE_MAX_USECS	126
+#define IXGBE_ITR_ADAPTIVE_MAX_USECS	84
 #define IXGBE_ITR_ADAPTIVE_LATENCY	0x80
 #define IXGBE_ITR_ADAPTIVE_BULK		0x00
 
-- 
2.52.0

