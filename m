Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3186CA5FD4
	for <intel-wired-lan@archiver.kernel.org>; Fri,  2 Oct 2026 09:14:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 799FD40CA6;
	Fri,  2 Oct 2026 09:14:55 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jN-hrTjU_i5w; Fri,  2 Oct 2026 09:14:54 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 8AB8640CAC
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790932494;
	b=pc2KaTw9PxdCIXd/bdsGu0t2NHh6a/k1u9gSCnmkYSs4qRrnkOZ1gp+HToDgK9OdLIun
	 O9Jj1tj/jQuq/uLVFxVUD7HbwXrKszsoYDjvxXTjJzckVIQ0qfwdJxL1raSYAGkADOaUn
	 5aVeyKrx5TZafLencjWAyMNG9QTsWOxIUvm7QyskjW91LBqiEkTgahz0steOTz6NIiAn4
	 nowklHW5CU8O998Qqypb7dnMUS/WlpT7xNt5fh8RK6RV8yzDskU5ofx5j6oASZpAULct2
	 kI8yMb20ChdWqj0aijpnnz0na8whEVKaAbLJY1NmFm2/Enfut5EfQIRFxiDr0PHMb8g==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790932494;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:Subject:To:Cc:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:Date:Message-Id:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
	b=YqGNK4tbjO26Q8OP7nTiN8+bfr3+RR9y+udyYX4n9sMZFU4IgGbuGUQZJKuvNRQONHEF
	 PwEyiZ+DeRM4w1XtUt3Wa24/7x4p8H/ishEM6XNcIDJ6nlhEx5wIPk5fc5Q8rI4jjgQxm
	 8rBQkP2QWxtKK31DNYucDtzYcAAAH2XFAZN1fjjclXXETmwu6Vm3NT1SVyukdumQoPbbY
	 C44T7Y4Vo1g3Zu0jBQW3qBiurAD1TDgVu0rF1sEJc99cLpA+cnMNr9pbZ5ss0z1VjMgBO
	 dqrzTEfCoRV3OYeMigbWsWtn20RxzaOInsAb5s1eeSpnpm9ERKKE5kdfDGBWV6ipzlA==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1790932494;
	bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=mBU2gqH61scRQ1pMK5eBQSr94wDUeD679RUHgtuzMgfnXgbBqJyc4FSY9OQn3ETMy
	 LXju+aHF4uqFti+DkUe23CaLuEdac6L1L1YkTfDiD2FBXGxb3q8Uc1XmbSz+jVZ8xJ
	 BdKxPRoIHz56ZymNnqc0K8Zabw2dmu4QAJiRhA2Hjunnnpeco2tQrL15dclnQ7f5sg
	 XiGOWYqHwz03uHCtySBZLObst0mlGqnO1fKCdUNE2wqTwEwEVy2F1ZHym1ox+t9IR/
	 WvvUIwYfCaHwosMTz7Arrvm4keno+H1X7+XA8JS741BAZgY8TTNdAedqEGBP2Ajy7n
	 /elta6v2+KNFg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 8AB8640CAC;
	Fri,  2 Oct 2026 09:14:54 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id B37933AC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5C42607F2
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Z6kHioF-8BhD for <intel-wired-lan@lists.osuosl.org>;
 Fri,  2 Oct 2026 09:14:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org E6F106066C
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790932492;
 b=lYmilmD6tC6ojiyJ/8Xv8P0/opUwlBPjmctw9vuVHDCATVf3as+JFhMfYJ4eaXTGJ3t+
 nLUMa7PeHz3VX9wMcYBWSPBcLLxK/Xt4Gq8GZ22UqqoH8rK+iOz2X/rgKXlb/k5/D9wF6
 7Xuki/VY/GMkGrx63cAsFXjhyQdT8RbvmbXn69WprPAVO/2WVWOUYjIXSuxFrbjNoRRzY
 WNckqi1M8ONq+CPWJO2OTTk1qfphLshAdCPXu8G+XxFV3bhWaVD2eaEL5oKwQH5pX+AOH
 su4oGnbA8BL2S+LFUR4kBDRrvITEDZMf7T/URr1qvlAia7BcSaBDb66MvksQK/jfBnw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790932492;
 h=Received-SPF:Received:Received:DKIM-Signature:From:Subject:Reply-To:
 To:Cc:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:
 Date:Message-Id;
 bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
 b=OjNyWsFZnfMbag80F4C8XXw2/tFSkeDksWgJyTyGzcmYvW9EulXFi4vF+TgKkj6j8UCl
 DHVcwN2l6GkW0aAd+9aTlprBYCswAmqiV3/zlJMfUuU4Jg9fioggTj+pKSWNEkXVCcGYU
 /fA4bFuh07i82YI9DMtjUnbIpfMsNXCfeGTjPFuZikw9/2eUreQ8u3ZHqnwS+11xOfU4v
 3m5Csej2DJGsfQW+QjUDXi3KP/bjTBla7/eRiLtodZElaAXf5PMd+HGaeXDXY4WLF62mL
 vLF4tMPd+TEU7amEgchGcQ1h24KRjzjBCuiVzmcxDo/CAcWbaAWfYPdgNntWFmozFJg==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=pass header.from=kernel.org; 
 dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=cuzHgLWQ; 
 arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=cuzHgLWQ
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E6F106066C
 for <intel-wired-lan@lists.osuosl.org>; Fri,  2 Oct 2026 09:14:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 959074127F;
 Fri,  2 Oct 2026 09:14:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 021551F0089B;
 Fri,  2 Oct 2026 09:14:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790932490;
 bh=HBMqH89VWxpIRyUQWMPadKOiKfhyb5TdKNkdcRPEdpw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cuzHgLWQL687s39rXnLi6PQXldXtVE/ygeVjY5yr753VjrP2GHeU4yU6/M40hxoS/
 M+0NGeEZurQ2CRG2sTMgDLK+x5mrC8XL/yuVqPucLLWtajjfAad/1cqvwbf0ulYO0j
 aAuif9sczc+biFeXvZgYGew5n/eue//JujJC271j2iHLDMq9feQITqy/wLgiDBKxPq
 HbiDfX7kofaopAU7bmv4XPKlWhqXAG83mNyhB60nrdz5dBhNLxwUK4TTH96PVm2fhi
 8Yl1vzIPS3mrIGP6pznNx5HYeMmXDRu7/46kl8c7t1LfuwaN6Nps0iQGodxanAtEsi
 Oeltlvdr3vqUg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/3] drivers: Replace __MODULE_STRING() with
 __stringify()
To: "Petr Pavlu" <petr.pavlu@suse.com>
Cc: linux-modules@vger.kernel.org, linux-hwmon@vger.kernel.org, "Alexandre
 Belloni" <alexandre.belloni@bootlin.com>, intel-wired-lan@lists.osuosl.org,
 linux-watchdog@vger.kernel.org, "Petr
 Pavlu" <petr.pavlu@suse.com>, dri-devel@lists.freedesktop.org,
 linux-serial@vger.kernel.org, linux-rtc@vger.kernel.org
In-Reply-To: <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
References: <20261002-module-string-v2-0-fc7438acaf4d@suse.com>
 <20261002-module-string-v2-2-fc7438acaf4d@suse.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 02 Oct 2026 09:14:49 +0000
Message-Id: <20261002091450.021551F0089B@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: intel-wired-lan-bounces@osuosl.org

> __MODULE_STRING() has been an alias for __stringify() since "[PATCH]
> MODULE_PARM support for older modules" [1] in 2002-12. That change also
> moved it to the graveyard section at the end of linux/module.h
>=20
> Replace the remaining uses of __MODULE_STRING() with __stringify() in
> preparation for its removal.
>=20
> Link: https://git.kernel.org/tglx/history/c/136839a1b4 [1]
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Acked-by: Andi Shyti <andi.shyti@kernel.org>
> Acked-by: Ian Abbott <abbotti@mev.co.uk>
> Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261002-module-str=
ing-v2-0-fc7438acaf4d@suse.com?part=3D2

