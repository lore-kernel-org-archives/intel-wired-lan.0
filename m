Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7527ECA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 13:09:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 3A42440D70;
	Fri,  2 Oct 2026 13:09:25 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hForjPT5JcXF; Fri,  2 Oct 2026 13:09:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 0271440DAB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790946563;
	b=qJCMYd3YBg75TY6t2Wkx0dlmLNuAKDuYh2ku1RY4Zqp5KvZClvT3NLnHtg4LZxWqWRIX
	 NyAe50kJb2A1KhOeVqmQ3UGhGyWNPi3ZIOLtGEH1U6RoeYdMsFtEbm6mBFyCzWrMKlsHc
	 qOn14pGzUBHq7R+ZpWZ3RcGbEVg/e99wzb01HZW5NCOFosDLIUiWASiXjh7/MJc++zCoK
	 WuZf9Oumxmm3mMcamQLnAleSWZIYqCfuwH+7SRiJk5GTByI2KCNaOVXxtN3NT6oSLukz9
	 P32rbThyKQZhdpY8OuBTNuLRXTweZWD+l6kIKdE+E7wdqi2K4OBVluzL5DT2xXoVodA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790946563;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Transfer-Encoding:content-type:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
	b=UNLHHYmppnMz6peWEHO8X0cyIRWBOmGGG44DxICiokYD+Od3P9ZFyuLsTXuZwSyrntgj
	 qkrROsE5xGlgl7v8XZnspnvyiv8W+0MUn3YfJjJ86CCUHo2/FSm9qsFEd5H3ulxOpvies
	 7XYeFVDIG4wMrww/ezn31PwfNeDH8rPhTJAsrzQ56zoLndKX6aGjPtuOHdntVJ46iyRIC
	 TNJt9FVG4gh0sIJqGzlakpZXcmqKoYCnIsjTCUyPIuXUHRRzsoKE/KvPQ6XapaLN7E9pD
	 +62ktKWSEUxH8H8AdycN4y8Db2k/GIHVb8sEEbAQY9doGw51dgZYmBEnfvhjRP+8nUQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QvgivZuA;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790946563;
	bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=k4QpyceAMrcUkZpyr/GNw5sI3euaN2C4nT8L8Vw9cp9Yq31G7JRBu31OqA8Idp2KL
	 85+ZLU076+oCYB95BKCMcHXncU1I9Gk/jlLv8iPLPHSXwRzFqR/p8xMaHxENbW1KKD
	 lb9JG9q5I6FabHIlFp5q2cjV0aQtoiyIgdckcdGrFLlZ/Su8rU8IX3ZxHeTmzehbH+
	 pH3CFIaee+FRJo83zP4GJJk0PSZOwE83VPKwfPPZf++BzQkNYBjmoeliDfsgPqrdAg
	 4XBugwXP71uaV7/PVn/UC+lQZp1F4u+McN59/HciRl0RzvRABDo+dOn5uIpXO2e/pW
	 Hgn6aT0dfRjqw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0271440DAB;
	Fri,  2 Oct 2026 13:09:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id DC2EE282
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D9F1140DA3
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id MIp7IiRKL6jo for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 13:09:20 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8DCB340D95
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790946559;
 b=nv1e4h/WpelaikcO1hffgnjo0W8INKY8MRb4c7WXJHjGl1dC5fY1mTgs6NrjJ7RoRhrT
 vqOPkUdyGxWHW0YlNnS8aMqHQkF/ijDmhExyqfe819mqIPZ4SzcTg4rr1GuzVWjU+tJGf
 of8VGNV5jdkOl97i6Hlyo0Ypc/I3d5Es09BZ8y6s3kftsVet7aWrOJvAV1ly0rapIkz8u
 HAtJP2rSZC1V8QEX4x2KkzTxL0ieuLEfjaxUglcJpQgAnEhoGBznbnprCbyFu9k2NAl+H
 oUQhzZG4s7uYH8qUt6oiWRjacNdbTbF8QWBrE0TmAcK1NnS0IlqUwVB+2KYvPJDWh8Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790946559;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:In-Reply-To:References:MIME-Version:X-Scanned-By:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
 Content-Transfer-Encoding:content-type;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=e9Of4s1ERiE2Oni1xDYWQ+x8mp7xZmW5mXxl7OTnRFp7+6N2hXHPsKxp/MehHftbsJQh
 XJmXi1SiCntls3VetxUFZUbJB5dzxzk6uNnyvgXWMEs5AzhGSlR+q5ZYpCdZvnNIqn3aF
 ax+Xj5g61sCFJiHbglrQJ2lkoUp1bPoiaLBItTaGrFV3i9Y93XmSsILb13SFuH2UG6qPD
 1POaPp7sUZpIluDTVTprF40ny3bzTa/07ns6gCaqd8vAFVmptJZT5r3pqAjrOBwd640O9
 DPgVIYzfgtL8TobM4MapKgHlbJKlUfNkVvBkEdTpuHEAXWqehiM3iTyIiFRDQ1HouLw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QvgivZuA; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QvgivZuA; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=Pf+5DIYR
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8DCB340D95
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 13:09:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=Pf+5DIYRNGr4XIK5fbJiMPeab7uW8cyD003L1RCxA94qvduE3VJphFiyJGPX6C6k2pfh2U
 yJtTJsGGeJaLdB9l2HMRsIMxNuzstQOqDVESSgLlgtAnWQCdADvuMYi/Mwh5OLuEio1k4b
 X3/5K6BckwpybziuDbV0sKpGzR8NuDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=Pf+5DIYRNGr4XIK5fbJiMPeab7uW8cyD003L1RCxA94qvduE3VJphFiyJGPX6C6k2pfh2U
 yJtTJsGGeJaLdB9l2HMRsIMxNuzstQOqDVESSgLlgtAnWQCdADvuMYi/Mwh5OLuEio1k4b
 X3/5K6BckwpybziuDbV0sKpGzR8NuDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=QvgivZuAg0IGdyNFdiGuW1ZfegfxNDEM+1wyDKZPx3d8Y3tgMmwfIdXR3q5pA2qkAzaxfd
 qeZte/RKBwHLYPvsUguiloCGookMaQMippZYu40mYe4VXzlTbLlst17FZsbc0FrIou95ya
 bzWYvYVWTUrXjPvnIyeeCrS/93OIyKk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=Pf+5DIYRNGr4XIK5fbJiMPeab7uW8cyD003L1RCxA94qvduE3VJphFiyJGPX6C6k2pfh2U
 yJtTJsGGeJaLdB9l2HMRsIMxNuzstQOqDVESSgLlgtAnWQCdADvuMYi/Mwh5OLuEio1k4b
 X3/5K6BckwpybziuDbV0sKpGzR8NuDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=Pf+5DIYRNGr4XIK5fbJiMPeab7uW8cyD003L1RCxA94qvduE3VJphFiyJGPX6C6k2pfh2U
 yJtTJsGGeJaLdB9l2HMRsIMxNuzstQOqDVESSgLlgtAnWQCdADvuMYi/Mwh5OLuEio1k4b
 X3/5K6BckwpybziuDbV0sKpGzR8NuDQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790946556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zJ7coCqPywFU4p+9fADiFNkr/yo4IXM4jkVfcEsVsKU=;
 b=Pf+5DIYRNGr4XIK5fbJiMPeab7uW8cyD003L1RCxA94qvduE3VJphFiyJGPX6C6k2pfh2U
 yJtTJsGGeJaLdB9l2HMRsIMxNuzstQOqDVESSgLlgtAnWQCdADvuMYi/Mwh5OLuEio1k4b
 X3/5K6BckwpybziuDbV0sKpGzR8NuDQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-BLZtcfimP7KX1xoF7cxTcg-1; Fri,
 02 Oct 2026 09:09:13 -0400
X-MC-Unique: BLZtcfimP7KX1xoF7cxTcg-1
X-Mimecast-MFC-AGG-ID: BLZtcfimP7KX1xoF7cxTcg_1790946550
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3CB5218011D4; Fri,  2 Oct 2026 13:09:10 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.32.39])
 by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 4CC44767; Fri,  2 Oct 2026 13:09:04 +0000 (UTC)
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
Subject: [PATCH iwl-net 10/10] ice: fix unsigned stat widths
Date: Fri,  2 Oct 2026 15:07:52 +0200
Message-ID: <20261002130752.2597259-11-poros@redhat.com>
In-Reply-To: <20261002130752.2597259-1-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-MFC-PROC-ID: 1U9s8HGDvdVqULSD3ZmjaM9A1ShwU3XAM-4HYuf2Lxk_1790946550
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

tx_restart, tx_busy, rx_buf_failed and rx_page_failed in struct ice_vsi
are u32, but ice_update_vsi_ring_stats() fills them with sums of the
64-bit per ring counters. The values are truncated and the ethtool
statistics exported from them wrap at 2^32 while the ring counters keep
counting.

Make them u64 like tx_linearize next to them.

i40e fixed the same truncation in commit 3b8428b84539 ("i40e: fix
unsigned stat widths").

Fixes: fcea6f3da546 ("ice: Add stats and ethtool support")
Assisted-by: LLM
Signed-off-by: Petr Oros <poros@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 6c596e5a315175..a985b81efbe2d6 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -344,10 +344,10 @@ struct ice_vsi {
 	u64 tx_linearize;
 	DECLARE_BITMAP(state, ICE_VSI_STATE_NBITS);
 	unsigned int current_netdev_flags;
-	u32 tx_restart;
-	u32 tx_busy;
-	u32 rx_buf_failed;
-	u32 rx_page_failed;
+	u64 tx_restart;
+	u64 tx_busy;
+	u64 rx_buf_failed;
+	u64 rx_page_failed;
 	u16 num_q_vectors;
 	/* tell if only dynamic irq allocation is allowed */
 	bool irq_dyn_alloc;
-- 
2.55.0

