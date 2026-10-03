Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ECECA5FDD
	for <intel-wired-lan@archiver.kernel.org>; Sat,  3 Oct 2026 09:55:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 819326064E;
	Sat,  3 Oct 2026 09:55:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kfocu0N_cpfE; Sat,  3 Oct 2026 09:55:55 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org CDAE360E71
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791021354;
	b=n1/FhBYTOuE6nNC7XTxAmHkRP+HmfD/pb7uC3DxpheCQxtEw3cmFb8CPfllaHR3T4Cqr
	 V0iGdxrqvzytltvL6haCxBzfquCAh8U8nJtSR+RVwk8+lTkQcDfVsCMh7RyIcn6kZqn+3
	 phJeziWnVy26aqiTnalbQftb5x02fTnefI5FD3XcY/ELftwd76AqQUYGeD+WEm4J4zYZZ
	 phzlKBgIhN6rpsUumd3qsyWfJ14zIesBQ/EeusbapHL2ltpMx1ZwCdkgM/JSu+7xG1dck
	 DlxkPX4NEnwt0beOPhpf/E10lO/SJrequC336tw8cnT7mL/cGMqE2V2FT+f3EIrUYJg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791021354;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:Received:Date:From:To:CC:Subject:
	 User-Agent:In-Reply-To:References:Message-ID:MIME-Version:
	 X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=F1jvtDOyMhNiAw/xTZGpDbKUATFfNpALn3V0shG8M0k=;
	b=du0L7KnYI1bKOXdIIwF0/PBGDNLtYPg1L+RKgkDQGk7TEQDkeblzg3R4bkUmBaJLGucb
	 Qo4LG/fCctf1+dyDIZEVEvCJAqneYQB7L4Q7+Ur/md5z+8YKGUZ306z1R4BWlmb17QTbX
	 apvTGaGx6abhnn+fB9hOoTluD4TqUWy2pI8rxJI5idQqT7tnAwtlcefxCTswmU82tDghH
	 MbBxpZGRnblHsVzsY5OekalExvC2bixeARZ/QkmpJOwvMfvPCxgltgl9E0s+64Rqha7vc
	 ZuQsivX3bNSWbrES1bc6a4QldxVBT3ajg+UxHU4qNAu5wQ8Y0PxHF62otUgJe0k0cmg==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791021354;
	bh=F1jvtDOyMhNiAw/xTZGpDbKUATFfNpALn3V0shG8M0k=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=M3v+vvMIgSuPKonuk7lCSL4VKdBN2rKb8LVT7qMupE+NsmPxL6lEuiGUET/w2DMN3
	 xpFfrjqVv/XDw3KVXN0VgQu/odrj77vmGi4N7nVpT7Y2vmnG5+5xmAh0tmkPYKEZe1
	 3MNNC7vXDgo3yozCYMINb2fFGCRDh6CfCvN2fbgaEULvkdg+GbNaGWNtN/0gPFxPrb
	 abbyiYToQ+/oErWE2ufcMrqVhRx3uEXv+iGRQpU/OXC8/FedqRA2wLk/zRAR6eHUjw
	 vO1n+jafXdvApQYq41WZ38Czx3FFTK8CeZ8mQR82yunn8ub76ZVYY+NwYqh2CMxOve
	 TcNPYk84gpezQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id CDAE360E71;
	Sat,  3 Oct 2026 09:55:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1CC61179
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 02806400F6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EHF90BrW6wGK for <intel-wired-lan@lists.osuosl.org>;
 Sat,  3 Oct 2026 09:55:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 2AAFA40059
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791021353;
 b=e9k38GwnU5LDNSjpHXmMl2qDrBv/Shu3MNGDsaF/Gb8WMjojX2yw8Giqb9i3fDE5cSFr
 JNg5nWGJd1CiLHI07Hewt9T8DdAcOI9XRQ5q5D3uON5cuf5gTMIiU4Zh86bNGjHbhWqNi
 Pk05mS9hvCcXFrxXo5URqPQj8kZIb/qETZIDf1SRa7KeAeO3lJkPonHYvxAFN5Acj8yFI
 oL3VmgNmAwJ6uVNpDltpSFwgm9ku5wGXSpJuOa4kga2sKNhhkJH8F1CEtIQEI5zzqJWm+
 KzhDosA4w/d0kc6mw/qYhWyU0T/CRLFA/om+frwEP84k5H6XGw8YKEAN217gR7If8dA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791021353;
 h=Received-SPF:DKIM-Signature:Received:X-MC-Unique:
 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Date:From:To:CC:Subject:User-Agent:In-Reply-To:
 References:Message-ID:MIME-Version:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Type:
 Content-Transfer-Encoding;
 bh=F1jvtDOyMhNiAw/xTZGpDbKUATFfNpALn3V0shG8M0k=;
 b=h6oxY6VLHOICRnxnPB5J7vRIMTXxt1vXgPt4oskH8GYrAnHM9rzoMZbD5D03D2mCIn/P
 pyPo1RPTb6Wxnb5Gjt7272DJc38N4Ep1ENZAfDzblDarCvP1r6E7eFQQH6XFwcHTl/UO6
 jaAva9c1Pz0u/ihNW40jmxkSieRfIpVmw1cWqhx1NeJnec8k/JesHm5K5yKWdWq0w86nL
 0x1PU46PVcbpsEUeFLP9n20jZD9WB8uDv+Vcgd2usxGmdp4CiHAv6InkRszInFT+G6z/e
 mD5r7YMji3yrMjWQMH/nF+KK1cI/+4l2+Q6WXWYVT0nBhqzDHOC1ggWNAHzbXWRGMBg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=redhat.com; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=BsXTyzZ8; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=ivecera@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BsXTyzZ8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id 2AAFA40059
 for <intel-wired-lan@lists.osuosl.org>; Sat,  3 Oct 2026 09:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791021352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F1jvtDOyMhNiAw/xTZGpDbKUATFfNpALn3V0shG8M0k=;
 b=BsXTyzZ8nCyONMwxdpYdBLhoaI99vOA6DF2JYgQq5QQqnRkQ/XbXlzZEsdGRRN8dSaCnUT
 gPH09JuobfVa19q8hL9yUD/sVPEZt5xVnt+mvl67rYmMRi6ZgOKcEWr8MDHpoC9wXfOPWB
 zPL9FTJ4D8l4srb8oiPmkI7KYMCuE4I=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-450-g68CRfI2PMe-z0pEvsYSag-1; Sat, 03 Oct 2026 05:55:50 -0400
X-MC-Unique: g68CRfI2PMe-z0pEvsYSag-1
X-Mimecast-MFC-AGG-ID: g68CRfI2PMe-z0pEvsYSag_1791021349
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-48af4a0bd0fso139646f8f.2
 for <intel-wired-lan@lists.osuosl.org>; Sat, 03 Oct 2026 02:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791021349; x=1791626149;
 h=content-transfer-encoding:content-type:mime-version:message-id
 :references:in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=211tvn9y3p5J+u/mzZRpmt2Ac+xaJHBNaH1jQgm5GKo=;
 b=sX5qprYYWD7SA3hR8D2NoFcZ2eqKEzzv/BS5FSEPXJDgcgxGZ44t4/kkAt+Wg7aTuq
 0JOqInktOJQlIG7udLcU5mW33NK65QJFUNoaI43g+3IxVZJIMJ6ptEQMzmBZWV0gOU/U
 HpcCN2SmZ+OAcmemPrUaOEsp6ekbG11Yf/J1gzSayDDLwpSESwDd4ZQRS7AusqKQBILe
 6FdUWgtpl1slf9V0xUYNQzEiAnmTTzAN54pxNkhgpYAz7zAZ6QGWv72tdGD+JsKglla+
 k5QVN4u0K5M1qSYZQHJjrVecDg552k/uv21HFACmiEOA70mjpioOQVOCYviNGRgau1cn
 42Hw==
X-Forwarded-Encrypted: i=1;
 AKwUvBy2zv4BtzUNdbhKcRaU4Fir/tCoFdUYF1QKuN5vYm3+BpTcBR/HdSkGSyu8FLD2gBALwsZnNdGAZDlA/yH8qDY=@lists.osuosl.org
X-Gm-Message-State: AFuF++ksIsL+3Pib3aT7jvS2v2QYCHCaVZLmNkHoe1Oo/YbG0Gz+Tv6d
 Se05wsoorxsFSLqeuljgaPM47lBeMbMDxEaBGfKg0JtdqeA3i/B+waUVOQhpao5m87uRXHt7ix2
 eQmceYPJxiljpa6nqCbYS8vS9EL4P+8rIU+jhI4bx4E3224Dfuu6GfmkTs0fK9dNp5LCYa3s=
X-Gm-Gg: AYBFou1nzif8jYOgEydd2YIYagJ19bnS4HQVZvJbbx0KW4TowjCsMhIb5ew8Unqyq3K
 +XvqjPt05oyN3m0xYzMQd4rHCm52yUPQ4oL8DslF24J5xbPfor0nEI5QrQnnSpptZ6rqU686ZQO
 iu+3qZBh80NKbUmFCZ7/bM7j2Y/Q1hSLakZZCegeVETnS242OJdH9LqaEEHERhgECrh9LLKntV7
 MpTDnqS3RYyWlgkLyUHmY/TlQ0v4cGOVEf7Q/LuYXdg57X/Pe+8eGwv1zarytwCKnCSUffXI5sK
 ELGZvsnJMm5shjaeClRxPH8RQWeFKhcUnGDcsse4HmAVN95Jz+5sW+J9+fgH1vNL+4Ka/Us1wMD
 ARhSkQlaJj4nOXa0+/4urnLONkOI6xBRHvYayiq0=
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a02758653cmr85580315e9.16.1791021349374; 
 Sat, 03 Oct 2026 02:55:49 -0700 (PDT)
X-Received: by 2002:a05:600c:3510:b0:49f:ff32:803c with SMTP id
 5b1f17b1804b1-4a02758653cmr85580005e9.16.1791021348969; 
 Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2a00:e580:bf11:1:2666:d874:79e6:3214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a16bcb9a21sm38091735e9.10.2026.10.03.02.55.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2026 02:55:48 -0700 (PDT)
Date: Sat, 03 Oct 2026 11:55:47 +0200
From: Ivan Vecera <ivecera@redhat.com>
To: intel-wired-lan@osuosl.org, Petr Oros <poros@redhat.com>,
 netdev@vger.kernel.org
CC: Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
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
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_iwl-net_07/10=5D_ice=3A_take_the_swit?=
 =?US-ASCII?Q?ch_rule_AQ_error_from_the_response_descriptor?=
User-Agent: Thunderbird for Android
In-Reply-To: <20261002130752.2597259-8-poros@redhat.com>
References: <20261002130752.2597259-1-poros@redhat.com>
 <20261002130752.2597259-8-poros@redhat.com>
Message-ID: <9B559EBB-75B5-43C6-AA5F-304E2AED20AE@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: EjJrgmtRq79-nvl6fd7mpmJcJa58188uSDFz48cSqFk_1791021349
X-Mimecast-Originator: redhat.com
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

On October 2, 2026 3:07:49 PM GMT+02:00, Petr Oros <poros@redhat.com> wrote=
:
>ice_aq_sw_rules() decides whether a rule removal failed with ENOENT by
>reading hw->adminq.sq_last_status after ice_aq_send_cmd() returned. That
>field is shared by every admin queue user and is only stable while the
>send queue lock is held. Another AQ command completing in between can
>overwrite it, so a failed removal is reported as a generic error, and a
>successful one can even be turned into -ENOENT, because the check is
>not limited to the failure case. A caller that sees -ENOENT keeps its
>rule bookkeeping while the rule is gone from the hardware.
>
>ice_vsi_sync_fltr() has the same problem with ENOSPC. It checks
>sq_last_status only after it has freed the list of filters it tried to
>add. Every entry is a separate devres allocation, so freeing a list of
>thousands of entries takes seconds, and by then the value usually
>belongs to a different command, so the MAC filter overflow handling is
>never entered. With debug prints of the error and sq_last_status added
>to both places:
>
>  ice_aq_sw_rules: opc 0x2a0 status -5 aq 16
>  ice 0000:04:00.0 enp4s0f0np0: Failed to add MAC filters err -5 aq 0
>
>Use the retval of the descriptor that ice_aq_send_cmd() copies back,
>only when the command failed, translate ENOSPC on add to -ENOSPC and
>let ice_vsi_sync_fltr() check the return code instead of
>sq_last_status.
>
>i40e fixed the same kind of race in commit 53a9e346e159 ("i40e: Fix race
>condition while adding/deleting MAC/VLAN filters").
>
>Fixes: ca1fdb885e5f ("ice: return correct error code from ice_aq_sw_rules"=
)
>Assisted-by: LLM
>Signed-off-by: Petr Oros <poros@redhat.com>
>---
> drivers/net/ethernet/intel/ice/ice_main.c   |  4 +---
> drivers/net/ethernet/intel/ice/ice_switch.c | 13 ++++++++++---
> 2 files changed, 11 insertions(+), 6 deletions(-)
>
>diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ether=
net/intel/ice/ice_main.c
>index 8a21f87eb6ca21..ceb9fec2af21e7 100644
>--- a/drivers/net/ethernet/intel/ice/ice_main.c
>+++ b/drivers/net/ethernet/intel/ice/ice_main.c
>@@ -396,8 +396,6 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> =09struct device *dev =3D ice_pf_to_dev(vsi->back);
> =09struct net_device *netdev =3D vsi->netdev;
> =09bool promisc_forced_on =3D false;
>-=09struct ice_pf *pf =3D vsi->back;
>-=09struct ice_hw *hw =3D &pf->hw;
> =09u32 changed_flags =3D 0;
> =09int err;
>=20
>@@ -450,7 +448,7 @@ static int ice_vsi_sync_fltr(struct ice_vsi *vsi)
> =09=09 * should go into promiscuous mode. There should be some
> =09=09 * space reserved for promiscuous filters.
> =09=09 */
>-=09=09if (hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOSPC &&
>+=09=09if (err =3D=3D -ENOSPC &&
> =09=09    !test_and_set_bit(ICE_FLTR_OVERFLOW_PROMISC,
> =09=09=09=09      vsi->state)) {
> =09=09=09promisc_forced_on =3D true;
>diff --git a/drivers/net/ethernet/intel/ice/ice_switch.c b/drivers/net/eth=
ernet/intel/ice/ice_switch.c
>index 239d4d9633baa6..ae96a2003d5c5e 100644
>--- a/drivers/net/ethernet/intel/ice/ice_switch.c
>+++ b/drivers/net/ethernet/intel/ice/ice_switch.c
>@@ -1959,9 +1959,16 @@ ice_aq_sw_rules(struct ice_hw *hw, void *rule_list,=
 u16 rule_list_sz,
> =09desc.flags |=3D cpu_to_le16(LIBIE_AQ_FLAG_RD);
> =09cmd->num_rules_fltr_entry_index =3D cpu_to_le16(num_rules);
> =09status =3D ice_aq_send_cmd(hw, &desc, rule_list, rule_list_sz, cd);
>-=09if (opc !=3D ice_aqc_opc_add_sw_rules &&
>-=09    hw->adminq.sq_last_status =3D=3D LIBIE_AQ_RC_ENOENT)
>-=09=09status =3D -ENOENT;
>+=09if (status) {
>+=09=09enum libie_aq_err aq_err =3D le16_to_cpu(desc.retval) & 0xff;
>+
>+=09=09if (opc !=3D ice_aqc_opc_add_sw_rules &&
>+=09=09    aq_err =3D=3D LIBIE_AQ_RC_ENOENT)
>+=09=09=09status =3D -ENOENT;
>+=09=09else if (opc =3D=3D ice_aqc_opc_add_sw_rules &&
>+=09=09=09 aq_err =3D=3D LIBIE_AQ_RC_ENOSPC)
>+=09=09=09status =3D -ENOSPC;
>+=09}
>=20
> =09if (!status) {
> =09=09if (opc =3D=3D ice_aqc_opc_add_sw_rules)

Reviewed-by: Ivan Vecera <ivecera@redhat.com>

