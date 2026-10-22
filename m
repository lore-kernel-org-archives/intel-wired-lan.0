Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2584606A31A
	for <intel-wired-lan@archiver.kernel.org>; Thu, 22 Oct 2026 10:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=mRA2q80t;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0;
	dkim=neutral header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D366481248;
	Thu, 22 Oct 2026 10:40:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uqZ_mj8h6e5Z; Thu, 22 Oct 2026 10:40:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0F75981287
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792665627;
	b=nIKenwf+FGAqkDvMdETVpLcZwfqwwd+gFwusxfozblgxTJctID/FEyaeJRJyTJBEMcAa
	 cJXSPqsHszhauedi8Y/NBQTBczN+g739UHTupcn+RlQ5utjBIHtt9/FTRdB9mmyRmdts/
	 gyre0yCPQr8oi6fAFXSTvWhxGrpfYZzhTml4Zqstd+WafKBnlPj+9nCiYLAjZTMxnvQ9Z
	 L2BevMHYg8jKExIvK4Fa8ysHtXSedLy95cOAfx9alxhJzAQn8vS8/A6l5nN0wjr8RVWNI
	 9p+2pt7GWgJOUGwior7ihZHKm2I6uLRU4Y5YqhssK4/cGz6V0yyBdED6pksX8Yvs/rA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792665627;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
	 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
	b=lGV7AMQPZom3Hy0ByeSxswh4v+redWQEkWC+OT1HJvzdIibErNZwLxCekP0PS5vOALxn
	 QOhKTETwOA7K4yB0cgk2kwLXf4ZsQeUvcUbUbrxWtzav1WUHVApR81KjsfgcD9hTzHK1S
	 r0fskfmZtpB8nK+9VhlUdw7SDsWuvGJ/plFcAaafW9SFPQwM9jfmXPdko20LXqihmXYc0
	 Eyx7eCWl3ITp3vNlLsFIpXtxqNl178G5wCKooOQ8WUoADBl/juXeGU7kcaWNcFyyCARCA
	 1V6lLPW+Bt4iFIqKSn/5aFVi4Ld/FU75nRCZP+eaVlhA8kPK0m1+9Fa4hPBXFYi/Agg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1792665627;
	bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mRA2q80tuH6vtSuERbHIki2pjJ1HR+3EmE6msdk4vd3/vtgzkOzoND4jHb6lN2jsc
	 Kq7qeA+o0fsJiHZ2YieOO8U20nD2j3MgzKGMTFovxF44sQO9RzqowfiE8R1zSHsOSl
	 QwsOgKL0LEWq2PojBtiTF8mK5vk2Bo/om69meNhyUU5QXkN9THlkwu1w4sShvbSCHH
	 wkdR14kWzsj6yv73R+qUcaqk2LGDb3OLpAhYkluQ5oQRS1bGEN3zj5Hx7luKawSNoc
	 LxI+hnXM6KHCrTG1jI3t7oKu9gV68MmBGkqBdRrEKJOiewTP2+ldbYmpHJ/5/oin22
	 9+C0+iw+l9jrQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0F75981287;
	Thu, 22 Oct 2026 10:40:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 0D3C8356
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:40:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E3CCE40411
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:40:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id a43FD5Hvh6TD for <intel-wired-lan@lists.osuosl.org>;
 Thu, 22 Oct 2026 10:40:23 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C875940409
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792665623;
 b=ef5P4aMmk2fe2yyJYIUzoxXOaaXHhepqcLC7sI7/ZSrAAb1eWcaO5fs1gJ91VxX+sMbw
 FNySg2MGQbAQT6W1oEdBOA+EL2IkvZd1+NSWxNWanGuERDnIDfHxI7E796poZECFFYAHc
 84WUajsVpIHNR1DwiW3+tkzihEz+PPOUb3yICmQnEUsb/0lF1eRoYGPc7AZ9vssPzglV9
 yrhBYJoV9qTO06zXhsrcQzPAREnV5Q9t2LbP7T34+O8IKyLQCroufsRrF5z68jnG+4aG3
 HCau776od1mNQWxMOJss5I5N0u6ieM3m64X3T1ru27SLDeSmdwd9rNwinlOe5l13BVA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792665623;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:DKIM-Signature:Received:
 X-MC-Unique:X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
 To:Cc:References:From:In-Reply-To:X-Mimecast-Spam-Score:
 X-Mimecast-MFC-PROC-ID:X-Mimecast-Originator:Content-Language:
 Content-Type:Content-Transfer-Encoding;
 bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
 b=bb4+wgLjOZIqyummp6Tw1Avb/jCVCzPlOW542xtONqlvQ4vkj+nm4OPpQn9xv3TE2lPc
 NEiWqkQL/CDm59DcMZ6Jb3axd67fUReLBTPlTv1g9ISmsZtnPRCBKQG0TsejxwftnFCwU
 IoQgNkqDrdRe6rM0YpMBj6EJbNlWdaPxVtc313TEsn6ow6/wHidxd6pv5c7H1/JJs0MTh
 nrJhTMZTe+oXWnigDTyzp6jSFl7U5FTnWRI3zwWSM+g7h1KQuVNWQTB7N1JOQ/6450DW4
 9EtJtm68aEtzR8uSh9vBL47EmqLc2MStTKLyFOd/uzOZ+eacj7nRXAtlbcuhvW3sCZg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=redhat.com;
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=H+aAUIH0; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=H+aAUIH0; 
 dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256
 header.s=mimecast20190719 header.b=H+aAUIH0; 
 arc=none smtp.remote-ip=170.10.133.124
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=poros@redhat.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=redhat.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0; 
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=H+aAUIH0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTP id C875940409
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 10:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
 b=H+aAUIH0CB7c7yTA6nVQsOgOvq2yvnbZT4sOQtojIefTpq3/oXmGcPBj34wd3dqy+6L9s1
 1z+SyMUET+CP2h/2KKdIKCMRDt62/9bovCIzlNcq7D8Xx5dpx/ZnxlVn3DfsKS8qsCaWa6
 HwPTW/4cmawzdKlbFOVqPCghmjn5mjQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
 b=H+aAUIH0CB7c7yTA6nVQsOgOvq2yvnbZT4sOQtojIefTpq3/oXmGcPBj34wd3dqy+6L9s1
 1z+SyMUET+CP2h/2KKdIKCMRDt62/9bovCIzlNcq7D8Xx5dpx/ZnxlVn3DfsKS8qsCaWa6
 HwPTW/4cmawzdKlbFOVqPCghmjn5mjQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792665620;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
 b=H+aAUIH0CB7c7yTA6nVQsOgOvq2yvnbZT4sOQtojIefTpq3/oXmGcPBj34wd3dqy+6L9s1
 1z+SyMUET+CP2h/2KKdIKCMRDt62/9bovCIzlNcq7D8Xx5dpx/ZnxlVn3DfsKS8qsCaWa6
 HwPTW/4cmawzdKlbFOVqPCghmjn5mjQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-bk6pwyxIMYiv17H2-u1taA-1; Thu, 22 Oct 2026 06:40:18 -0400
X-MC-Unique: bk6pwyxIMYiv17H2-u1taA-1
X-Mimecast-MFC-AGG-ID: bk6pwyxIMYiv17H2-u1taA_1792665618
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a204f135ffso4246495e9.1
 for <intel-wired-lan@lists.osuosl.org>; Thu, 22 Oct 2026 03:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792665617; x=1793270417;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FEKm5nQsGf/I+ugCmSSfq8QJNoZ1NYPo9Xa7ZqzEb5w=;
 b=HXLoYZt6CJ2jZGmgScIs1AtGVW8jfey6oAGrSb/MXSmHG6NySlKGymFUynG0Q/8pY7
 DvrhMr+gkC6sMhmcJIntXYjLScz2dl5yIHDmTXmxcqimla8/MSf+QU25gw1Ih3XeZ5rV
 s8gSMRdm/lweLlVJposeCJRixwmJ/RvVnDjbpZ7slmht803xbx/K0GUpAeA3lr27B7XO
 GYYZhTcPq54VmWtDasj5crg+sqTOQ+Y4GnqS7UT+xWNsYfz/NJTFpWxbS/2J+s0XONPx
 wcW7FyNwaM77as15LpkC0gyg2kGvJIOS1HjaEnjbx37JxU/c6k7FWchM7Y4kFbH+NsDZ
 PGtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwLHv7zMeOVa0yEiFvK1IfXoAR9EA5urViz4CSCnK3EhJJOL9HQjMTChzrho3OVK3BBNxcMLSkHKzKg0FqMYOI=@lists.osuosl.org
X-Gm-Message-State: AFq9FYIsCbdklmX915Gc7kvrz+qElXi64NQw+oeja6zhBzuVGzaQKex8
 J7fEMQw1pPJCthJW1WtOujOs32z5wFGdRiHy+279wcH5p2HxC+kubMuh4y1HxmwikJvenGH0VuI
 tRaCS98LoorkCE4NbsbviGi++yxcZRMOwmO1gcasJ1/5TL42mLR7nXfTyQj7kgkzqBJM+JY8=
X-Gm-Gg: AYBFou0qvtZIEvwzOufe49XYk70SCBfl5sdGtAc0dpnZ3H64s2PF09wDp9WfmwQgNZ4
 H5q6s9IqbIBHVuZ7Q1xM5IzuvUHJAPZaMsKCfadqSlDhGi168Wr3zt4mrvFTCYdYxZ/Yu2iosnV
 hnl6yrxK0mikbX3SPr9fpAumYOhmmJw80n4RTbIv/2xD2qCN2iZoeiUivNvmDlLn7vsdVn0f4Ed
 rytx7b8gnqeXBuv3GlwyWF9OzRJv66FRtWgFGi/HD63weUt3QTfL/UhXS38+qvP+57ublIHFAZk
 AvUHR+3lUfJyhom4miQG35hV9ymJpA3c4LYZ2NH/Jf/bYDx/r6+izQanvFtkgxAYVb3aQGXrVQ=
 =
X-Received: by 2002:a05:600c:5308:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4a20047b7bemr73764695e9.32.1792665617534; 
 Thu, 22 Oct 2026 03:40:17 -0700 (PDT)
X-Received: by 2002:a05:600c:5308:b0:4a2:47:b79c with SMTP id
 5b1f17b1804b1-4a20047b7bemr73764225e9.32.1792665616929; 
 Thu, 22 Oct 2026 03:40:16 -0700 (PDT)
Received: from [192.168.2.75] ([46.175.183.46])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a207fd494dsm17235475e9.4.2026.10.22.03.40.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 03:40:16 -0700 (PDT)
Message-ID: <9d167482-2cac-42eb-9fa1-c242406c493d@redhat.com>
Date: Thu, 22 Oct 2026 12:40:13 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iwl-net 1/3] ice: avoid RTNL deadlock when notifying the
 RDMA auxiliary driver
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Ertman, David M" <david.m.ertman@intel.com>,
 Shiraz Saleem <shiraz.saleem@intel.com>, Leon Romanovsky <leon@kernel.org>,
 "Maziarz, Kamil" <kamil.maziarz@intel.com>,
 Rafal Rogalski <rafalx.rogalski@intel.com>,
 "Schmidt, Michal" <mschmidt@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 Mateusz Palczewski <mateusz.palczewski@intel.com>,
 "linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>
References: <20261019065301.3983537-1-poros@redhat.com>
 <20261019065301.3983537-2-poros@redhat.com>
 <CH3PR11MB566895C406B00646530A5249C9E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Petr Oros <poros@redhat.com>
In-Reply-To: <CH3PR11MB566895C406B00646530A5249C9E5662@CH3PR11MB566895.namprd11.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: KbPMuspVJhyHIRzXBv9C8nAX-fu_Xc9WzrL0Nq-0PTM_1792665618
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 10/21/26 1:20 PM, Loktionov, Aleksandr wrote:
> 
> 
>> -----Original Message-----
>> From: Petr Oros <poros@redhat.com>
>> Sent: Monday, October 19, 2026 8:53 AM
>> To: netdev@vger.kernel.org
>> Cc: Oros, Petr <poros@redhat.com>; Nguyen, Anthony L
>> <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
>> <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
>> David S . Miller <davem@davemloft.net>; Eric Dumazet
>> <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
>> <pabeni@redhat.com>; Ertman, David M <david.m.ertman@intel.com>; Shiraz
>> Saleem <shiraz.saleem@intel.com>; Leon Romanovsky <leon@kernel.org>;
>> Maziarz, Kamil <kamil.maziarz@intel.com>; Rafal Rogalski
>> <rafalx.rogalski@intel.com>; Loktionov, Aleksandr
>> <aleksandr.loktionov@intel.com>; Schmidt, Michal <mschmidt@redhat.com>;
>> linux-rdma@vger.kernel.org; intel-wired-lan@lists.osuosl.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Sebastian Andrzej
>> Siewior <bigeasy@linutronix.de>; Clark Williams <clrkwllms@kernel.org>;
>> Steven Rostedt <rostedt@goodmis.org>; Mateusz Palczewski
>> <mateusz.palczewski@intel.com>; linux-rt-devel@lists.linux.dev
>> Subject: [PATCH iwl-net 1/3] ice: avoid RTNL deadlock when notifying the
>> RDMA auxiliary driver
>>
>> ice_send_event_to_aux() blocks on the auxiliary device lock, and the
>> dcbnl callers reach it with the RTNL lock held. The RDMA auxiliary probe
>> takes the two in the opposite order, because __driver_attach() holds the
>> auxiliary device lock across ib_register_device(), which needs the RTNL
>> lock:
>>
>>    systemd-udevd   state:D
>>      really_probe                  <- holds device_lock(&adev->dev)
>>      icrdma_probe
>>      irdma_ib_register_device
>>      ib_register_device
>>      setup_device
>>      irdma_roce_port_immutable
>>      ib_query_port
>>      irdma_query_port
>>      ib_get_eth_speed              <- blocks on rtnl_lock()
>>
>>    lldpad          state:D
>>      rtnetlink_rcv_msg             <- holds rtnl_lock()
>>      dcb_doit
>>      dcbnl_ieee_set
>>      ice_dcbnl_setets
>>      ice_pf_dcb_cfg
>>      ice_send_event_to_aux         <- blocks on device_lock(&adev->dev)
>>
>> Everything else that needs the RTNL lock piles up behind lldpad and the
>> boot never completes. The probe side cannot be changed, so use
>> device_trylock() and report whether the event reached the driver.
>>
>> IIDC_RDMA_EVENT_BEFORE_TC_CHANGE has to arrive before the traffic
>> classes change, so ice_pf_dcb_cfg() refuses the request with -EBUSY
>> rather than run it behind the RDMA driver's back. The critical error and
>> MTU change events are sent from the service task, which consumes their
>> pending bits before sending, so those are re-armed instead.
>> AFTER_TC_CHANGE keeps its fire and forget behaviour, it can be neither
>> refused, the hardware has already changed, nor deferred, every lock that
>> would serialise a deferred delivery against the dcbnl callers forms
>> another cycle.
>>
>> Fixes: 348048e724a0 ("ice: Implement iidc operations")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Petr Oros <poros@redhat.com>
>> ---
>>   drivers/net/ethernet/intel/ice/ice_dcb_lib.c |  9 ++++++++-
>>   drivers/net/ethernet/intel/ice/ice_idc.c     | 20 ++++++++++++++++----
>>   drivers/net/ethernet/intel/ice/ice_idc_int.h |  2 +-
>>   drivers/net/ethernet/intel/ice/ice_main.c    | 16 ++++++++++++----
>>   4 files changed, 37 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> index 0bc6dd37568792..2022b46c990cb2 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_lib.c
>> @@ -355,8 +355,10 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct
>> ice_dcbx_cfg *new_cfg, bool locked)
>>   	struct iidc_rdma_event *event;
>>   	int ret = ICE_DCB_NO_HW_CHG;
>>   	struct ice_vsi *pf_vsi;
>> +	bool dcb_ena;
>>
>>   	curr_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
>> +	dcb_ena = test_bit(ICE_FLAG_DCB_ENA, pf->flags);
>>
>>   	/* FW does not care if change happened */
>>   	if (!pf->hw.port_info->qos_cfg.is_sw_lldp)
>> @@ -406,7 +408,12 @@ int ice_pf_dcb_cfg(struct ice_pf *pf, struct
>> ice_dcbx_cfg *new_cfg, bool locked)
>>   	}
>>
>>   	set_bit(IIDC_RDMA_EVENT_BEFORE_TC_CHANGE, event->type);
>> -	ice_send_event_to_aux(pf, event);
>> +	if (!ice_send_event_to_aux(pf, event)) {
>> +		assign_bit(ICE_FLAG_DCB_ENA, pf->flags, dcb_ena);
>> +		kfree(event);
>> +		ret = -EBUSY;
> -EBUSY doesn't match to any ICE_DCB_* constant, are you sure you tested this case?
> It looks like it will be processed like ICE_DCB_NO_HW_CHG i.e. no change needed, isn't it?

The negative return takes the same path as the existing -EBUSY for the
custom Tx scheduler. ice_dcbnl_setets() and setpfc() pass it to dcbnl
unchanged, only ICE_DCB_NO_HW_CHG is mapped to zero. setapp() and
cee_set_all() mask every error, that is pre-existing and also hides
-ENOMEM and the AQ errors. I have noted this in the v2 message.

> 
> 
>> +		goto free_cfg;
>> +	}
>>   	kfree(event);
>>
>>   	/* avoid race conditions by holding the lock while disabling and
>> diff --git a/drivers/net/ethernet/intel/ice/ice_idc.c
>> b/drivers/net/ethernet/intel/ice/ice_idc.c
>> index 102d63c3018b1f..7fd35ce966ea65 100644
>> --- a/drivers/net/ethernet/intel/ice/ice_idc.c
>> +++ b/drivers/net/ethernet/intel/ice/ice_idc.c
>> @@ -34,30 +34,42 @@ ice_get_auxiliary_drv(struct iidc_rdma_core_dev_info
>> *cdev)
>>    * ice_send_event_to_aux - send event to RDMA AUX driver
>>    * @pf: pointer to PF struct
>>    * @event: event struct
> 
> ...
> 
>>   			kfree(event);
>>   		}
>>   	}
>> --
>> 2.56.0
> 

