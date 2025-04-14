Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4BA2C369A2
	for <intel-wired-lan@archiver.kernel.org>; Mon, 14 Apr 2025 13:44:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6F5076F6C6;
	Mon, 14 Apr 2025 13:44:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id G3HT4g3CkSFz; Mon, 14 Apr 2025 13:44:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C1B82612AB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1744638251;
	bh=fmi7flxlGHpvF4HSkQqrqNLSomJ0qJnIgw5w4V6dOUI=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oQiPPHEGoiLRwQ7EjYal41J6JCQl4xZT619eC+1IlravoV/qH1vyjCAGeVcobJZKq
	 8NwoVAEB+K+YcytFUzJIlFCY6TlRvLQ5EmurCyymEb+mJnDGZPRAhZh0IPKtQIVXAm
	 Mrkjav02k2k8JmTtDcHJKdRWKHTEvSJyyhf2jle94rJ6CjrpwtDcxjUUoo9rZrFIpe
	 7bTKPjDlgazfk5Ye0c1vnBZj+1i9MYr4gAElB+4LpbDp9SrlxjKRmJiiq1yH/05Ate
	 ThAsfWAboMYIbyBEf6F/fpGKrJfKEv2aq8nW7S1YTtbcNPbp0okqEIgbgBeWQlFvAX
	 7rK/5b8cpW8UQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id C1B82612AB;
	Mon, 14 Apr 2025 13:44:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 2DE2F250
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Apr 2025 13:44:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C2D8C6F5DE
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Apr 2025 13:44:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id VvShqarMq8cx for <intel-wired-lan@lists.osuosl.org>;
 Mon, 14 Apr 2025 13:44:08 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2001:4b98:dc4:8::222;
 helo=relay2-d.mail.gandi.net; envelope-from=kory.maincent@bootlin.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org BA6A061145
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org BA6A061145
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net
 [IPv6:2001:4b98:dc4:8::222])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BA6A061145
 for <intel-wired-lan@lists.osuosl.org>; Mon, 14 Apr 2025 13:44:07 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1E7634385F;
 Mon, 14 Apr 2025 13:44:04 +0000 (UTC)
Date: Mon, 14 Apr 2025 15:44:04 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Message-ID: <20250414154404.1c25ae91@kmaincent-XPS-13-7390>
In-Reply-To: <20250414130007.366132-7-martyna.szapar-mudlaw@linux.intel.com>
References: <20250414130007.366132-2-martyna.szapar-mudlaw@linux.intel.com>
 <20250414130007.366132-7-martyna.szapar-mudlaw@linux.intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvddtjedtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtqhertdertdejnecuhfhrohhmpefmohhrhicuofgrihhntggvnhhtuceokhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepgfdutdefvedtudegvefgvedtgfdvhfdtueeltefffefffffhgfetkedvfeduieeinecuffhomhgrihhnpegsohhothhlihhnrdgtohhmnecukfhppeeltddrkeelrdduieefrdduvdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepledtrdekledrudeifedruddvjedphhgvlhhopehkmhgrihhntggvnhhtqdgirffuqddufedqjeefledtpdhmrghilhhfrhhomhepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepgedprhgtphhtthhopehmrghrthihnhgrrdhsiigrphgrrhdqmhhuughlrgifsehlihhnuhigrdhinhhtvghlrdgtohhmpdhrtghpthhtohepihhnthgvlhdqfihirhgvugdqlhgrnheslhhishhtshdrohhsuhhoshhlrdhorhhgpdhrtghpthhtohepnhgvthguvghvsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrt
 ghpthhtohepkhhorhihrdhmrghinhgtvghnthessghoohhtlhhinhdrtghomh
X-GND-Sasl: kory.maincent@bootlin.com
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bootlin.com; s=gm1; t=1744638245;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fmi7flxlGHpvF4HSkQqrqNLSomJ0qJnIgw5w4V6dOUI=;
 b=EODCCOImDJZJOCuCcz84zOFvtZMDxT4NZa9TkcGXku1evj31hS+THtNKRgd9yoakJGrz7U
 ydr24cRWnnXmHHgbpwKTV0CaGQ8yeT2LmSTNJ9VQpz9U70sYiEVWtnzZqb9GESO+g/Q8vp
 coexTfA6xmvzuj6cH1klbv5oQO+3eOc+tzPxWpKgGviZUHIQ0E8A8ZEAbcYZOSYhLhUhix
 LmlQ646pPSACpeTG+77yImfHqthGpVNj66tH90x9J+lXZk8L6MtK8fYjIVEbklGuFdmJ5b
 29dXRe3yD2OruLnXq67eGUYgBz+pmd82LLMZrt17cqxndSPOl/wXGbTzxm7Prw==
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=bootlin.com
X-Mailman-Original-Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256
 header.s=gm1 header.b=EODCCOIm
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 2/2] ixgbe: add
 link_down_events statistic
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
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

On Mon, 14 Apr 2025 15:00:11 +0200
Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com> wrote:

> Introduce a link_down_events counter to the ixgbe driver, incremented
> each time the link transitions from up to down.
> This counter can help diagnose issues related to link stability,
> such as port flapping or unexpected link drops.
>=20
> The value is exposed via ethtool's get_link_ext_stats() interface.
>=20
> Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.c=
om>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com
