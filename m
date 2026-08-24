Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF33FC5DF94
	for <intel-wired-lan@archiver.kernel.org>; Mon, 24 Aug 2026 08:55:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9EC6D40695;
	Mon, 24 Aug 2026 08:55:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 2DPugR3Ao6Ee; Mon, 24 Aug 2026 08:55:08 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1787561708;
	bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=AfVBvFO7VtgXllcxkXLcMv1/YPDrJ0C9SfJrc6BpfFE65mc9xw/sDCko1L6J+IH9F
	 voMcKY2/8Stp1ua6M+J3MD15EO4n0usxKQWRhxYVQkRZQ2IPmGUAsthr1kY/C053tz
	 nFBbrBR0z3VHMkKv8UKQtcBrbka1wPzPhBLQfDOC+ym8WOB2sL+iaTDCI24I6nu2af
	 ly33gTl4FpASuHbOIMehz9VvQUQuNRTRaqqfVpd/05A04vNVb8JQT4HAOsHPhTERRn
	 KTxoZEWfWlKpyrpmHr/FwnWjkPt5wDz3GmHIyA4KGqdT7W6RbloqbuciEqNCvM8baa
	 107tnECWahw6Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CCC21405D6;
	Mon, 24 Aug 2026 08:55:08 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 948E3230
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 08:55:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 75F1C6060A
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 08:55:07 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qLXJXYbcOR9Q for <intel-wired-lan@lists.osuosl.org>;
 Mon, 24 Aug 2026 08:55:06 +0000 (UTC)
X-Greylist: delayed 575 seconds by postgrey-1.37 at util1.osuosl.org;
 Mon, 24 Aug 2026 08:55:06 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=xE5ndECR; 
 dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=5NiaIj+w; 
 dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de
 header.a=rsa-sha256 header.s=susede2_rsa header.b=1KBVPjwf; 
 dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256
 header.s=susede2_ed25519 header.b=1GbpM6NZ
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=195.135.223.130;
 helo=smtp-out1.suse.de; envelope-from=tbogendoerfer@suse.de;
 receiver=<UNKNOWN> 
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 38E94605FD
 for <intel-wired-lan@lists.osuosl.org>; Mon, 24 Aug 2026 08:55:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07E0A867B0;
 Mon, 24 Aug 2026 08:45:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787561125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
 b=xE5ndECRYzc8WVHdhqhBXpPPRcy7jYoyBdZJsKRSnxvjmJ/AVCBWHp0x0cHH1wL5tFJqYO
 6U0XwuFmUrGWjQwJzQKkgEJVvjNvjssqybcP348INkA7s5ngCDCOzFcQXAWXs7S2rMMdhe
 JT45Y5RTHN8sRB7W1EJJHv3nTlV/2Nc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787561125;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
 b=5NiaIj+wQPTd+TzN9Vt1X/AnhCYQYrzh2sV65lBS3+N/WVrl382ivw4u8FvTlsKvHl5zQC
 AjCqMto/rpVFZ9BQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=1KBVPjwf;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=1GbpM6NZ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787561121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
 b=1KBVPjwf230umHTxY8Mzq2uq1UytXQOFvmb7V0rHzhUWouBDf+IPksW9KVcm5Qn0tCU0kj
 0+F/t4GpTBhhGYgYNImyEl0hUSNKQrtS6i2iQmlUEipRRx9gi35+SrYL2MTKEDUoiHfUUD
 X+54hVfCFB1TO7f8NvI3qW0Q+rnRnNo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787561121;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lEsVVqNEAkn5YOGDDH4OOniE9yS2v7TaErr6lqFREDc=;
 b=1GbpM6NZhkdd+dL7tZs40BuJFHkV1hA65lTkIYmpAae0CWriE0KPYgGZBxfsT1CLmACCtO
 9hV52Ns2uLDOVCBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AE36113331;
 Mon, 24 Aug 2026 08:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XdIpKaAEjGobPQAAD6G6ig
 (envelope-from <tbogendoerfer@suse.de>); Mon, 24 Aug 2026 08:45:20 +0000
Date: Mon, 24 Aug 2026 10:45:11 +0200
From: Thomas Bogendoerfer <tbogendoerfer@suse.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
 <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Ertman, David M"
 <david.m.ertman@intel.com>
Subject: Re: [PATCH net-next] ice: rephrase LLDP filter fallback message
Message-ID: <20260824104511.7a46a136@samweis>
In-Reply-To: <477734d9-ed8e-4696-8160-382b29e7491c@intel.com>
References: <20260717084453.9521-1-tbogendoerfer@suse.de>
 <477734d9-ed8e-4696-8160-382b29e7491c@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 07E0A867B0
X-Spamd-Result: default: False [-2.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TAGGED_RCPT(0.00)[netdev];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

On Fri, 21 Aug 2026 13:59:26 -0700
Tony Nguyen <anthony.l.nguyen@intel.com> wrote:

> On 7/17/2026 1:44 AM, Thomas Bogendoerfer wrote:
> > Seeing an error message in a logfile triggers scripts/admins thinking of
> > problems. The LLDP fallback message itself is not an error, it just
> > indicates it's using a different filter mechanism. So rephrase to a
> > less "scary" message. =20
>=20
> Hi Thomas,
>=20
> I believe this patch [1] will remove the need for this change. Could=20
> test it and confirm that it will work for you?
>=20
> Thanks,
> Tony
>=20
> [1]=20
> https://lore.kernel.org/intel-wired-lan/20260811181127.1142095-1-david.m.=
ertman@intel.com/=20

that solves issue, too.

Thomas.

--=20
SUSE Software Solutions Germany GmbH
HRB 36809 (AG N=C3=BCrnberg)
Gesch=C3=A4ftsf=C3=BChrer: Jochen Jaser, Andrew McDonald, Abhinav Puri
