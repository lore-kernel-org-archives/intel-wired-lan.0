Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA00ECA5FED
	for <intel-wired-lan@archiver.kernel.org>; Tue,  6 Oct 2026 12:00:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 761D280BE5;
	Tue,  6 Oct 2026 12:00:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oLUwCn57KH78; Tue,  6 Oct 2026 12:00:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org BBBB580BD3
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791288001;
	b=nMWi6yx4DbAadHL+j+B6ySiyvSOyVc/a6i1LK/mcHctIvk8zlJpiyYKiRTKeu4JXrVkR
	 O2kgKwlaXZf7N3H0o8GtFtC9q0tRdoCzetG2J5hRNFwkUSDMxuTWfCUjJc5+PRb2rfIjU
	 nPKLkV3tk+OvuBO0ARkxR83VOQtd54KL2LQVVcKVWZQIUanMVp5Wza4aif/93yppM8mzL
	 JKApeb7D3w/6rWDJnQ+Cr3sn0ZXKoLiP7AAkVw2zL+r+r57P7xTLcOrR0a/MjyNHx6gI3
	 geK/nk5akF13gKgTUUNgNN6eoHvQSh3QnAMQCZCKPVPSttt1nykMLStLTv/rpVXGJJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791288001;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
	b=dDjFW+1aQLdqY3O4ZM/CwVRr53fixa7zcZOxsh3vr4IOyhf7HoPfR6QMXtFJSBYuUlsx
	 LNh4+vqxAFqCMi49fbk0vc+RgPkyWWMuq9cfyS+dCc8vBShHKW/tdv2eUwh57LflXbvaJ
	 FLLnTrC2O6YvQZESPliyHJZXNFWfm0xVRyzPHCh810dBycvU9JwW2QjF0j8Z7ma8eggYa
	 J35pRa6KXplbDnqlDm7U3DkyM0whJIvxEyN/7fjcrmUmmEBE0sM6dCfK/bpUn12tpWRJU
	 pzZEtWGPvRnD9/BkluMlWL9Q4HUEVHFf2f0IESRKKL/x/xi8EiV6YgBZNN1CbMRArmA==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791288001;
	bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=MSCNrUswt+9yr0NtKJg3WNq/O7w26cRs0BcgwPqRI2ppVlbT1VB7rgTeBOoRhv7my
	 vLiCZhDVzxD1jlyP4fpNRZhvkyR8AMa9fzGm4Zo4sCWam9wayY6t//cdPzCMfnwcZ6
	 wy3FSNMfriwvGjFRLGk+BJiLdELQ6WcF/YJ2nMQf/tbDyeaEZgiXiwJBdfqYLg79de
	 e2Dzn1LngrrfNKnHMkepB1SAD2SAyVuXWOTy3xaFKYul8HmUzLGX2ydcblJwmdplt2
	 ue/yS+P63+VgucDnMA2V6i8TDiQZMLe6XGo/7Upz0c0zbQb9umAljkAygwhRokG7b2
	 PgEE5zSrr9yDg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBBB580BD3;
	Tue,  6 Oct 2026 12:00:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3F9D875
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:43:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3181C401EC
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:43:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ccon9Dp23XgT for <intel-wired-lan@lists.osuosl.org>;
 Tue,  6 Oct 2026 11:43:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 67707400B5
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791287034;
 b=aKt3aquQZgOshRH1pzTPXhXgvD+D95ZG/ntweeDFf84g9cdhKRSHSOFG+iqauGUR7qEN
 wJZ/EfuM6qzHAvPHrLzsSilz65c+B/KsY+8vT/6LXF6gnblPhu9qYbmJ3/4xCv5+HE351
 s0PM/ItNIN+2/tX+p2StkiyTlxwUPvxxAi3fzcQ9NsgKgRP6u9yPFMx02Ox8W1lTU8Ibp
 DI1Uv6I/mQpmm3Ivwm999Vgri0Sh7QmY0k7rtK1GKo6Fxsf+kRVEtU38jPyRaSHbdRXfM
 2X9MfGJERFT5zbGADORjbPthGmyU6YvA854H8u/i+5H9egHPMhk3Ht/xiY3MwV2qTuQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791287034;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:DKIM-Signature:
 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=GcOU1d/nXmnzSvyH+KKXwg51YneBSVzRW3ZLIopu/4NgwbeRVlASMsDaBQqSvYUcdjr+
 uiZgtH1J8iowigu9KKSVoGsULLSjzMb/98m8oWbcexBCfMsAqAJOo4FcC+rvoI/7PCPAy
 CPxu2NwNLh/04rfQqyGqdEyDSrBRn8wM8sTB36wMNVu0Di9h+ZkYTVz6Y28OumYPY6UEL
 rPlC9doPUzp9RXFxyOoiL95TkyDjHRw4oyvBGAxG6FkTBP6lFh0YkTSy7eS0oxk55tkFy
 9JGYFztUyiU/BcDbkf7HS/mI8zTmbqe+6pNeOapfE9VImowLh6pDaomhSdXHKyZ2XTw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b="ZEhp/ANQ"; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=QKcFxyp1; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZEhp/ANQ; 
 dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=ZEhp/ANQ
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 67707400B5
 for <intel-wired-lan@lists.osuosl.org>; Tue,  6 Oct 2026 11:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791287033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=QKcFxyp1BkUkKyghJj/2XfOBucU6LXCcNooLNjlhQIY8DGkMLEoRTHnhkO0ywUsexc4EMz
 fHM8ZiMrad9uzUXWTczoUCAfSmj4oa8L+ZwHSfMdBdTmeaZgYtiiv9U897zNQsEfemIwM7
 pDbgABulUKprTBaJ/klu4bWDGslQNpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791287033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=QKcFxyp1BkUkKyghJj/2XfOBucU6LXCcNooLNjlhQIY8DGkMLEoRTHnhkO0ywUsexc4EMz
 fHM8ZiMrad9uzUXWTczoUCAfSmj4oa8L+ZwHSfMdBdTmeaZgYtiiv9U897zNQsEfemIwM7
 pDbgABulUKprTBaJ/klu4bWDGslQNpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791287033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=QKcFxyp1BkUkKyghJj/2XfOBucU6LXCcNooLNjlhQIY8DGkMLEoRTHnhkO0ywUsexc4EMz
 fHM8ZiMrad9uzUXWTczoUCAfSmj4oa8L+ZwHSfMdBdTmeaZgYtiiv9U897zNQsEfemIwM7
 pDbgABulUKprTBaJ/klu4bWDGslQNpM=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791286731;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=ZEhp/ANQi2ux3ECicMDQp+VFHjoNjtp1C4LoEMTbEW3wjZ3dIIHm3826a7/QMnCoOGGAUi
 5+IGURIGIIi/NSc7nx3zVC259mbp2EdchqhAQJEVWnmnVve/8Mifb23JR0owWEXTZfyRDI
 Ua/+lncGTDu3IbjBMzwDQM0FjB3SHX4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-MBhqFZcANECkNecwvdhgeA-1; Tue, 06 Oct 2026 07:38:50 -0400
X-MC-Unique: MBhqFZcANECkNecwvdhgeA-1
X-Mimecast-MFC-AGG-ID: MBhqFZcANECkNecwvdhgeA_1791286729
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-486f9d150c3so1622852f8f.3
 for <intel-wired-lan@lists.osuosl.org>; Tue, 06 Oct 2026 04:38:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791286729; x=1791891529;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=iDW3vzyRoZqymSPRfQkop/cgLakUVwx8htt1ibae5gU=;
 b=P8eNYKkDVgeaT5BC8iZlC2Q7KHJcua3GacesAufkK+qvBUxIcBW7o7W3Lt9M4CYOyD
 DKUFrHECXIF4ho3DtHWMPOJfhXoKILbk0bm3eotsjumniM9oW9PMuzS3fHlQXhogKSu2
 894LwnxOt3ANnnj7KqFjyfq97pRyOzU8OIJZ42/VGzCWStFtl91OAMYODFK4MwNdffJE
 d8/Qq2pWnQv5Olh5/rjIZkbjy4hWknoj9dskqsPFk9JWOrK/gH5ppYQPRg4+hRoBUdCl
 AREjqzkUk2nVQU9Th7lny+aKh34AUCeAhB/af29KkLTVkupK00EHqBD7Hc212+5C8pYH
 0mPA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRVlJsDX5na/2ATUqdrFTVk//VqQGTH06I8fTACWMiQ5AutykNxPA5T8fIS2U3LbmAyDgJqG3Mpi46bdC2wBs=@lists.osuosl.org
X-Gm-Message-State: AFuF++lQoclBCxaoCajzLeOY0A8ACjWvAquyJKdyxLWRcnun6sA00f1P
 ++vxy1REViwD+8WbxvuEpyrwzgArVB6u+mOtrH5Lh35h4aWNz5qjRajX9lIC+J2qYp9u2NguAos
 BPwCObUmToOOJxf2OjwmoPR0fqk75g/cCbaSqnU4rTN3gFVmXshtz9dnZyDNEhURsV/H/638=
X-Gm-Gg: AYBFou0lqUCRme1YIKnPQhlqiCGockhY0pMn+qm2Hex5MiCcG/xKAQJ1WCkvIuGclKn
 hHkdLvchbElUYV4f37z2mWMtHOw9QlQwDdCUnWtPjQh/kc9KpiLoXZIrsM7BDf9Tfs80HxSjsm2
 a/3fDa0j+KwggQKoU/GsRiYPTJhkF3x/b3qS8mbevZ4johq9jYtAxU7T8qQzVZXycLYvlMqP3Xl
 wq06/jPCciO11NhfWrITZBZmYp6oyuHWbuknKiqyAb976MhhQKN5mkcKVaAT9pFiRQfitUj80be
 jjwNL03mzSRpPOFvUeD0R+tfRmaQo0GWOYlheXCwDMKeA5z14YUJAUQJIRYgYg==
X-Received: by 2002:a05:600c:4e45:b0:4a1:687b:8f3d with SMTP id
 5b1f17b1804b1-4a17b55ad69mr16882315e9.31.1791286728714; 
 Tue, 06 Oct 2026 04:38:48 -0700 (PDT)
X-Received: by 2002:a05:600c:4e45:b0:4a1:687b:8f3d with SMTP id
 5b1f17b1804b1-4a17b55ad69mr16882015e9.31.1791286728262; 
 Tue, 06 Oct 2026 04:38:48 -0700 (PDT)
Received: from [10.43.3.161] ([213.175.37.14])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a030326132sm341298485e9.0.2026.10.06.04.38.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Oct 2026 04:38:47 -0700 (PDT)
Message-ID: <21e0965d-d247-49b2-86fa-041ead3d8558@redhat.com>
Date: Tue, 6 Oct 2026 13:38:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 09/10] ice: program multicast magic wake before
 tearing down the main VSI
To: sashiko-reviews@lists.linux.dev
Cc: bpf@vger.kernel.org, intel-wired-lan@lists.osuosl.org
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-10-poros@redhat.com>
 <20261002132815.D3A771F000FF@smtp.kernel.org>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <20261002132815.D3A771F000FF@smtp.kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qJUEzlp7rF2dl06XkXzhe0_oNN-eOonxeZj8S-OMH-8_1791286729
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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


On 10/2/26 15:28, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] ice: Use-After-Free in ice_setup_mc_magic_wake() during concurrent devlink reload
> --
>
> commit 6cf8b519dd4de7f3996192dbff4ffe7afc4d34f8
> Author: Petr Oros <poros@redhat.com>
>
> ice: program multicast magic wake before tearing down the main VSI
>
> This commit moves the ice_setup_mc_magic_wake() call earlier in ice_remove()
> before device structures are torn down. It fixes an issue where WoL magic
> packet wake was not set up correctly because it was being called after
> ice_deinit().
>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
>> index b121faa345c1a..857ba7d92b140 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_main.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_main.c
>> @@ -5465,6 +5465,8 @@ static void ice_remove(struct pci_dev *pdev)
>>   	if (!ice_is_safe_mode(pf))
>>   		ice_remove_arfs(pf);
>>   
>> +	ice_setup_mc_magic_wake(pf);
>> +
>>   	devl_lock(priv_to_devlink(pf));
> [Severity: High]
> By moving ice_setup_mc_magic_wake() outside of devl_lock(), is it exposed to
> concurrent devlink operations like reload?
>
> If a devlink reload operation executes concurrently with the driver's removal
> routine when Wake-on-LAN is enabled, the reload can call ice_unload() and
> ice_decfg_netdev(). This unregisters and frees the netdev.

A devlink reload can not run concurrently with ice_remove(). Since
commit bf6b200bc80d18 ("devlink: Acquire device lock during reload
command") the reload takes the device lock before the devlink instance
lock, and both the PCI unbind path and device_shutdown() hold that same
device lock for the whole of ice_remove().

>
> When ice_setup_mc_magic_wake() runs unprotected by the devlink lock, can it
> experience a use-after-free when attempting to read the freed netdev's MAC
> address?
>
> drivers/net/ethernet/intel/ice/ice_main.c:ice_setup_mc_magic_wake() {
>      ...
> 	if (vsi->netdev)
> 		ether_addr_copy(mac_addr, vsi->netdev->dev_addr);
>      ...
> }
>
> Would it be safer to place the ice_setup_mc_magic_wake() call after acquiring
> the devlink lock?
No, the netdev can not go away underneath ice_setup_mc_magic_wake()
regardless of where the devlink lock is taken in ice_remove().

>
>>   	ice_dealloc_all_dynamic_ports(pf);
>>   	ice_deinit_devlink(pf);
>> @@ -5475,7 +5477,6 @@ static void ice_remove(struct pci_dev *pdev)
>>   	ice_deinit(pf);
>>   	ice_vsi_release_all(pf);
>>   
>> -	ice_setup_mc_magic_wake(pf);
>>   	ice_set_wake(pf);
>>   
>>   	ice_adapter_put(pdev);

