Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C933C88E72
	for <intel-wired-lan@archiver.kernel.org>; Thu, 17 Sep 2026 19:03:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id CA35760B83;
	Thu, 17 Sep 2026 19:03:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LFZlzjlFLWa7; Thu, 17 Sep 2026 19:03:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98A2460841
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789671796;
	b=OqEJdoOTDvXVKR4/MkHc8F9Z6KeMZ3L3emtFnJIOcVJshz836fIA9fQE81hTMGUlQuD0
	 eCYkXLJJ4NaT1ETgAdz/vNUof7O5zjMCcJfDxSlauRN6oIvdFXuAQ7QBMBDK9OxvQ0AGz
	 mMRY6oQx9o48iLoF7sAvP9C430w1ZjqBJ7EDZNKac+biuLsf/yNpCFHzYDlo8zob41TgN
	 QtxBx13ZKulWNJCB1UVYIzam2Xq0XS6XsMh2idbKLudjuAk9UfkJtgz+VC9B3FwPHvF6L
	 egNlxAm6iO0YSfRkuzoSD3GhcctqyPdYQ2siO13/BvQ7VRF76VYvbISUzUKoi0MFowQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789671796;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Transfer-Encoding:content-type:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
	b=Io0BuZZGsTuikRt5qaKkX0ZPGhWnmzB1R5JGBKcIXweTUc8kQtzwqAq2LHwnK2IM3N4J
	 hQvjUqXiW6XjZMRUifH/2M5sBmvAPV96gEExwO4ZYcn4Ga0EqcvW8KhSqmsto4IE5c1/8
	 Fs9QWdYMLmmv/YdAEr5VkCWGsKRzyNwF7wNgiLLEPYShZj34GH1v9YWRfQXZ7E9Uo3LtJ
	 RKFJm3L4X3sPUj86+OliZuiemq9rw7ljqCMX+EBD9p5wGg7FwZX6vBnYroQCgJIRV2Ucx
	 JwfVEE7fyk0eTNeqtgbF/HZk9/OD9QynTxN15gCYIrxrHwcf9bUcFf1fA9cXi9xXyUg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789671796;
	bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=W0i5QXNJhYFJ4FsSVFaQjEyKYrzlkOERlzKJE1jx3G/TuHLf5ZOeTxFlQ6cT8NolA
	 1gB8QILIbUMHqF6SkjMvOp4uWP5yL6s2EMfluIhfTMNaJgwAI/SC+uGT6k1CQxKBSA
	 3WFoqxpzn/ZCbUsrQiAV8dVK1H1hG6G5fiDMI13Tz0e2VD7pmOXpOjUNarJKt9DVa1
	 vPB0oHEI4KG2MVpjmBVHwzHm0Ad57ir0OSd2hrBUldNy3MomMgaVti9VaMSqAsqCFV
	 ivdMD/OM2GloSBJHAmTHLPiUM7uML1VzkOoYSeMAzbv8t3zK0yF9AYCCb3Krc71Jxv
	 mBc/RCWZ8KLkA==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 98A2460841;
	Thu, 17 Sep 2026 19:03:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1A7AF3AF
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0C1664044A
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id edcpyTp6oGS1 for <intel-wired-lan@lists.osuosl.org>;
 Thu, 17 Sep 2026 19:03:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 206DE40427
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789671793;
 b=GgY9oAPm9k6YvEAqI9FUHrNZnxGHgVvQyIm9g0P2ytSM44ddl1X6GckYNaaJK8x4UZcg
 GVKaknlcb7AKWbbPWbvs3QBB5YJHfYqM15IMYkHlCrYwI9X9GoMyFeMW2Et8v2tpzC86+
 NCG3b8Ns8i4Uc0WsO27YVZdnD1Dwc4nUw4tzaiWK/Aa/m7T2ZWLB4K3murIa4zNFiT09T
 Mps0nGEZFrcOw1sB7uEqpr8qaYChYJ6zLmAGl49ffVdGA7M+gkJ21ee4I2xavi0S/yabd
 WonbbbOj/QhYThoNfgt0JN6CH0+4c/nvDsOeTwoEHALyYaQ8au5GSzm4N5zzTWlS0Cg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789671793;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
 Message-ID:MIME-Version:X-Scanned-By:X-Mimecast-MFC-PROC-ID:
 X-Mimecast-Originator:Content-Transfer-Encoding:content-type;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=ICPErJKx4yJZE0pXuKfMkL1XDdh5v2yu/x0WKl4vjBaYOFLwVuWNAHPbALL6UdhcOmmu
 jLOqsm6U9un7OtY9Pjzg87THaCOWrKkqFiOeUY0+Mg0ClMiDLDLH2tcRUT7u1RGhRyBnv
 ArpfHliCo4F4s3dt+qJEu23Ssr0nwsnzHOD60KUHVi6V0vILs098NjUx7Pd5EsJoCYfNZ
 VXrgo3ThNt7/mOjnQrmTsZA5j/yOdnYs/V4y4c/TiKyYgwvck/Ui3aMi4FvqQ4VqTj4qr
 WcF6iUFDYjb4uUphBjH3BzBrkHEDBSgN4kTSI7qQrey9C8ZyRSTlS5hmiwz0QiHp9Hg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 arc=none smtp.remote-ip=170.10.129.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=YFGBQJ9Y
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 206DE40427
 for <intel-wired-lan@lists.osuosl.org>; Thu, 17 Sep 2026 19:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789671790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=vEpKdM9UdqRPamiH0lpl9OzTLcWcwBrdEdoeLPKinHQ=;
 b=YFGBQJ9Ym6ksGbcPGryiCgNPSM9hjHlAZSdsDySdcx0Kh77DQujsVt+R6afQNgQEOkCL76
 00KXKs3XeT4X3g6aHgQyoHSbxtYrZ35XtifViOhH5cCW4qzjm5dWnfOg5YbZHc063JdnGf
 PDsVleIXKCih1DrvPumgTey1Vsyy1qQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-t0X3_cFXNpamsqq4JUK0PA-1; Thu,
 17 Sep 2026 15:03:06 -0400
X-MC-Unique: t0X3_cFXNpamsqq4JUK0PA-1
X-Mimecast-MFC-AGG-ID: t0X3_cFXNpamsqq4JUK0PA_1789671784
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7DE8E197759D; Thu, 17 Sep 2026 19:03:04 +0000 (UTC)
Received: from ShadowPeak.redhat.com (unknown [10.44.49.1])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 0E6F719AC048; Thu, 17 Sep 2026 19:03:00 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH iwl-net 0/2] ice: DPLL init fixes for E810 timing boards
Date: Thu, 17 Sep 2026 21:02:56 +0200
Message-ID: <20260917190258.3239282-1-poros@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-MFC-PROC-ID: nkJFWIv2J9dnn4GIW4fWwv7169dXYdh9Lhdkcier_f4_1789671784
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

Two fixes for E810-C timing boards the driver's static pin tables were
not written for, seen on a board whose netlist has no PCA9575 clock mux
and whose CGU reports more pins than the tables describe. The first
layout is a reference design of its own, Intel ships it as the
E810_C827_SyncE_SFP_SEC NVM configuration.

Patch 1 keeps the DPLL registration alive when the PCA9575 clock mux is
missing. Today the lookup fails and the driver gives up on the whole
DPLL, so userspace loses both devices and every pin.

Patch 2 stops the SMA and U.FL wrapper setup from indexing the input
and output arrays at fixed positions when the driver has already fallen
back to generic pins, where those positions can lie past the end of the
arrays.

Both are tested on an E810-T with the mux present, with the mux hidden
from the driver, and with the generic pin path forced, and on the board
above, where both DPLLs now lock.

A follow-up for iwl-next derives the generic pin names from the pin
classification the firmware reports, so such boards get addressable
pins instead of ambiguous numbers.

Petr Oros (2):
  ice: fix DPLL registration on boards without the SMA clock mux
  ice: skip the SW pin description on boards with generic DPLL pins

 drivers/net/ethernet/intel/ice/ice_dpll.c | 33 +++++++++++++++++------
 1 file changed, 25 insertions(+), 8 deletions(-)

-- 
2.55.0

