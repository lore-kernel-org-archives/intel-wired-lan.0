Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A08DF606A32C
	for <intel-wired-lan@archiver.kernel.org>; Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=X62wI4l2;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHiVm3q0
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7A1EC812CF;
	Sat,  7 Nov 2026 12:11:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KoU4byPSgCut; Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org B3ECB812D6
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794053498;
	b=QSrt4Z85S1pMRh6N0ctPaDIqPgQn2FzJF/4R2cK1Bwcqht9ETYILakgNEMMU8QL8XyRa
	 GRRCkuA/V5vTRbCh5etzMghQI197YHZyyNmgcEEa7gQJp14VXZ3uzoTMaBJF3Sgimaqw3
	 uPfYf0AITcr91fsywfWv6SwO4tQrxsI7eJr4RZ2cbTpLgRfbh59QIkVUff5GDJbYdpUPO
	 vl3Yv9lpqfc6IxJW36rDnyOGH/qBIZC8lvr2i3pomCF+QsJOLEX1FlqtyvIPQG02aiNYG
	 8D5+Hoq4iLY4J66TeMk9SiQIs5sNgGqDzEG+STPjmt6U8HP9sjqL55VTmZT7E47CPkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794053498;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:From:Subject:To:Cc:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:Date:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=EdBdUJzZh3smVY61J2aH+qlXHRx32E+8QJoGAylugEA=;
	b=Ul+BCpH481lRsed0NyJZBhYn5d0dEK2HK9dW21sXSWnXXaItZ7SJOGAet44SMW9QBVM0
	 7r6blzYMyXhfx6DlV0ZsSW8nwinOuAP0BDL+9NsY2o3qTbc+DvEH71yhJ4jspo08LHnOz
	 8MjqSroglogAvq+qDcr6G0ndhE0CXXfeExr7zhtpo4m674iD7kPsl8V91IQHyO/49eXuX
	 o91v7kGjxDqWO5nEAOqFyFFm5/TCSykfm9zoCRIDA+gdiI8+tkIxBPwsMDCaaFA1q4F2E
	 pCUlMyRz3KcVG5wRFzNsh+7S0+xlK+4hz6jk6FRjG4N8su7MJQ049iZ2rLszEGuvOLQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	dmarc=pass header.from=kernel.org;
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lHiVm3q0;
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1794053498;
	bh=EdBdUJzZh3smVY61J2aH+qlXHRx32E+8QJoGAylugEA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=X62wI4l2U6prsh+Nxc4uFz0SoLyYLVteHS6ZPhw94puX5YyUbCJrsfNF9jvuNxb2U
	 k/ZW1U/lyWIibR8GvVd2TA4Bqeu5g8UBcouh+nL4e+xS3ChuIlrE8lQFfKdBcjig67
	 fughbKpkO2B5b8A6532RKLI6CXEKpmBnrs3QdToDpH6TSvDyDSrgNCUdZxt4V/gM1i
	 Tc5CAYEwjQM7V1c9r0ZdutN05+P9ScYnlBtvCfChpAs2wc7msUrKEqT55aoT53/Y6D
	 Y+CFNqkroyZsir/sYWqE0etExdsHLpxT9J8DmCGQOpZD4/P0+8tEHzHlBWG0KSV7oW
	 bkdOkO06EjjZw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id B3ECB812D6;
	Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 3576C1C6
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1B148812CF
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:38 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HJXbnxn2EN-T for <intel-wired-lan@lists.osuosl.org>;
 Sat,  7 Nov 2026 12:11:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1574D80D7F
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=sashiko-bot@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=lHiVm3q0
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1574D80D7F
 for <intel-wired-lan@lists.osuosl.org>; Sat,  7 Nov 2026 12:11:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 49DBD41190;
 Sat,  7 Nov 2026 12:11:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C7F1F0089F;
 Sat,  7 Nov 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794053496;
 bh=EdBdUJzZh3smVY61J2aH+qlXHRx32E+8QJoGAylugEA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lHiVm3q0lqxcW8QewVcpw+4d6v9IieajhEIX7H5KXMauv4eSKluktgHJ5OnzPkR4z
 v7B8a0xK/rve5Gqf7GMyiZCg+Zlzww7HaT5Mv6lE/ZovERqJc6gyzRjTe87ZL/t7I3
 +brg/3rJGidzIBTMvURQCwV6utjn87L5kTw1wtG+GtIJoE3JFhKWOAXZgNOd3RMY0i
 FQVwZZggcYbo8ob0kX/BoA/Flfjv4UOcL5wJFhDA4VTEp1b5SbuqUXacV9QKq5c9qz
 QU0tIicWJIhZJESRM5UiOWtwRUl9C+U8ecMWE3RLZyuyOzowCLJYIPCJhBlh6yP5L/
 EV3yNc7HPvNPw==
Message-ID: <sashiko-outbox-202876@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next 04/10] dpll: take domain locks around driver
 callbacks
To: "Ivan Vecera" <ivecera@redhat.com>
Cc: intel-wired-lan@lists.osuosl.org
In-Reply-To: <20261106121005.1327603-5-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
 <20261106121005.1327603-5-ivecera@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 07 Nov 2026 12:11:35 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 1 related pre-existing issue it does not
introduce:
- [Medium] dpll: broken NLM_F_ECHO in dpll_pin_event_send() [1]
--

commit 1d6bef1472d6edb1fb63ca2b725c77cbbc70a8da
Author: Ivan Vecera <ivecera@redhat.com>

dpll: take domain locks around driver callbacks

This commit acquires the object's domain lock around driver callbacks in
netlink requests, dumps, and notifications.

> diff --git a/drivers/dpll/dpll_netlink.c b/drivers/dpll/dpll_netlink.c
> index e5380d95f238b..1b4e3a0166a74 100644
> --- a/drivers/dpll/dpll_netlink.c
> +++ b/drivers/dpll/dpll_netlink.c

[ ... ]

> @@ -941,27 +955,39 @@ dpll_pin_event_send(enum dpll_cmd event, struct dpl=
l_pin *pin)
> =20
>  int dpll_pin_create_ntf(struct dpll_pin *pin, u64 src_clock_id)
>  {
> +	int ret;
> +
> +	mutex_lock(&pin->domain->lock);
>  	dpll_pin_notify(pin, src_clock_id, DPLL_PIN_CREATED);
> -	return dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
> +	ret =3D dpll_pin_event_send(DPLL_CMD_PIN_CREATE_NTF, pin);
> +	mutex_unlock(&pin->domain->lock);
> +
> +	return ret;
>  }

[Severity: Medium]
This problem wasn't introduced by this patch, but does dpll_pin_event_send()
break NLM_F_ECHO on pin SET requests [1]?

drivers/dpll/dpll_netlink.c:dpll_pin_event_send() {
	...
	hdr =3D genlmsg_put(msg, 0, 0, &dpll_nl_family, 0, event);
	...
	genlmsg_end(msg, hdr);
	genlmsg_multicast(&dpll_nl_family, msg, 0, 0, GFP_KERNEL);
	...
}

When a user-space SET request triggers a pin change notification,
dpll_pin_event_send() is called without the request's genl_info context.
Passing a portid of 0 to genlmsg_put() and calling genlmsg_multicast()
instead of genl_notify() drops the originating socket information, so user
space never receives the requested NLM_F_ECHO notification.

[1] https://sashiko.dev/#/bug/linux-14884b2c-eeea-47fd-87fe-40bc535d32cc

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106121005.1327=
603-1-ivecera@redhat.com?part=3D4
