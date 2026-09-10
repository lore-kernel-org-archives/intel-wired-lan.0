Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDACC79F9F
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:47:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7302C40AFB;
	Thu, 10 Sep 2026 15:47:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HSQjLOFovHaR; Thu, 10 Sep 2026 15:47:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org CA24B40AFD
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055220;
	b=ADc6wQkm34dyVSKALDfyfjX5Rk7qbNsjEKj8oVTjbExh1v7UFod1nbwcHWvU9zZZHBGL
	 W4Dotrfdmui5bh8O0CCI3OxObyMKYy8or+tqE+ilWOYPUyBUisasXwaYBKswKP4qXyd8+
	 95IYy7AUjT2jE1PbN/EcvF/O9eVRQD9p3g5eEl85ENp+Ts8WwaZuH9X2WGcacmDfKbqHf
	 FfRYE2BEhOzjLgmjNOKbf/N9zp1ikqxNUnWRNMVwBwU3qAO52WrlA98Aq3b/vE7yuYtXV
	 J9WiyfSQwyQXHecdrGrvaCaPW5rLpGmCzoiC6328uGM5CiRVwSH2IFVrbs7tVh0keOw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055220;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=;
	b=F1QOMuwxVBpB98AL5Hn0ZggX2ugEjJNLJrXVhw5ojfBbi9tScD7CQ9RRnYj9wzyyfPTu
	 oPP6h/Lxnyb6LIssrq8gpEFcijaHU7+P6uEqP/qbpedFdjy58awJeh/mDRhVuzZC+nlYm
	 UfMfkdkeMFRr1QsK3MAM/n9c17f/je5C8MGGhx9foXOmgfgwg9EvLl3cje71eDX87wdnk
	 qq179nozwxK4RoZHKx8zwrqJsHwtK9nBsFqG+pqA4EM9fGBJwyZsmFSBMrPLVSESIsh7s
	 8qYETsLMKSyOZ7+C2FR12GPb1gIIS1R2DbGG9jm+roENroti8qJxwhdpBkRME/NWN9w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055220;
	bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0gZCXT/jROJEvzPVJS60rAmvsqdsyhc64r+cxo9OfhKMiwkey/8+Vg4Hy79z6gipT
	 ytO9Jfv7DVBF85kId/IkfOkq27rfTRKT+VBOTdj1mhWcwBFnvs5xubOOY89sNGB+VX
	 dgA5jd5FD9q/8Tp/08c5RZFlAMlBwGpfyXM+D0rELCHUudcHGpCBIwLUJlZdxtSEyJ
	 lm9rKxE8dO/ZPUMH4wrHu1BO2KLCAg9rytJke3eozQD1900XzoJJayLitXcG3tvVwj
	 u5K8+mxLJcWNRiwAZPQ1sfNnCGqClidPtFA0llK4rcbChtqZ7HGk61ArSaXxGRouR1
	 kQatKj0DA3Lzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id CA24B40AFD;
	Thu, 10 Sep 2026 15:47:00 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id F2E2E362
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:46:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F064140332
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:46:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HEq9bDpcJtOK for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 15:46:58 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 7D85C4032B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=202.12.124.141
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789055218;
 b=mA6oagRM1qgGsiHRpLkl2GIkijafT4CC6K65C58wR0+fL1XIS6u4tLQiCZ0DhrpOIwox
 QaaW9fjgtx/1ELDAr4T0+ESFosfwZN41gwpfb4cJr5PkTrtMMQYJz/SpxKvZyvzPo9IUh
 TBy750B3xCDlkKgLHD8QmPw2+JB0TauMKeNg974d/sjNWHfIPDixn9rq6q+obtsrF3++H
 QM/lLDwz0+qhh/ugZdCba7qq3dJyzAf4tlxXF/QMqICe4n8rMsSDBkYlgiEveRoB6BTXL
 zgmvhzMivLxYhxAQtloGuAcksOX9DGgYKMrnowoVb2fZt9GNXDXNo5VQVibbpQT/UDg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789055218;
 h=X-Greylist:Received-SPF:Received:Received:DKIM-Signature:
 DKIM-Signature:X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
 Received:X-Mailer:MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:
 In-Reply-To:References:Subject:Content-Type:
 Content-Transfer-Encoding;
 bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=;
 b=B/Y8umAcmQ/8nl95p7ihguUSdg+BkW9ELnbu2a+suN/b+tz2d8lgc5GwI8/iLuVVLTN7
 qioJn3fDvOC51ptaYv9PYgT35hOqio/JmY2BS7dfiyOuxSmnQsgDroTlhZHL4bKSXWDCF
 5DYRouYvAYQSjEUfL6naxvhEL0OpEdUwngeMRC+tkncmv/G6Nb81Y01wpbBlPtUpAAYQt
 XVs0aeE1r96QAC5yXq5+1W1yo5xBPXChOuxLLGUqvfFU1TP9R/ih+gzOf6p52/04ls9zr
 VNrG7cRMD5cFyzB6ST0iys6zCDvGS5ND7agWccveiSPt3XWQpERFER67/67TBQQQBlQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=arndb.de; 
 dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256
 header.s=fm3 header.b=g5YX+XDA; 
 dkim=pass header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=Mjj1H69q; 
 arc=none smtp.remote-ip=202.12.124.141
X-Greylist: delayed 561 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 15:46:57 UTC
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de
 header.a=rsa-sha256 header.s=fm3 header.b=g5YX+XDA; 
 dkim=pass (2048-bit key,
 unprotected) header.d=messagingengine.com header.i=@messagingengine.com
 header.a=rsa-sha256 header.s=fm1 header.b=Mjj1H69q
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=202.12.124.141;
 helo=flow-b6-smtp.messagingengine.com; envelope-from=arnd@arndb.de;
 receiver=<UNKNOWN> 
Received: from flow-b6-smtp.messagingengine.com
 (flow-b6-smtp.messagingengine.com [202.12.124.141])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7D85C4032B
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:46:56 +0000 (UTC)
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
 by mailflow.stl.internal (Postfix) with ESMTP id B78891300388;
 Thu, 10 Sep 2026 11:37:29 -0400 (EDT)
Received: from ams-imap-03 ([10.64.2.23])
 by ams-compute-02.internal (MEProxy); Thu, 10 Sep 2026 11:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm3; t=1789054649;
 x=1789061849; bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=; b=
 g5YX+XDAJclx6iQY1Iqpvad/dhrXmtpPU4X7PHlSgR64ReSdtRKtKAHoCH7XVsr5
 hAoaD2CjknoqFaItBRP2Pce1s5t+MBHlX5z6PSL9MFShemil7OeGznVKek97Pboj
 pOYd7bm9YwDodqlP0W6v+izYml6crN4RUubmoSZ24C7XJk6JFapLKhvb8RNOa9fU
 s9DAERYBnqQIx6FjZ9VJdtmLrsrdcXcqAsaEWv+3/dnl5QWZYUgt9eOEPAnHh//o
 GqHfb2N9eRIZ7x6p7Yf4XLM9osYhuuGRF0GCvYc4NhczWcBbp7F3ujKQMS5sGZFE
 njVBCvnGUlw1aVe55lI0Og==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1789054649; x=
 1789061849; bh=VJHi3AALrojUsaiH2K9JRyFh6yN6vM9XW4bo5EfCLvk=; b=M
 jj1H69qJ9QbYpI2qqgrm0TY1an5n7bAIzQ0T4sIOc382Q5JiSEzvGzcnytPog3mX
 YTl40hPZ5Doi8vrUsnS8gyQP3QmUPDhjisRddU4Mg8XKLI/Ux3ZCO+ZiVFyUrTYQ
 mkyfvndbskAGq/u+yA4ML2PgHbke7KkCVP5yPRG/VCZ9u9If5V66tyjKEaHiZW4W
 DJASGFMLx2pJegmYltp2DTEo5BfCHoo162GdBUoBaBzw4KPSpMHCw/cw77gIvrxO
 frBXjWuRTd2Dm1BkDcyvLUHrL3S3F5aBB07UJ6QjSl1CFAF2eNcVeesYQo4gNvEc
 2rp6udhsJugr91rgSQmsw==
X-ME-Sender: <xms:qs6ialjxbEuodcS0_ZTw49mWDlh3-eH5ipz4y--9tvyE15ehv0kuGA>
 <xme:qs6iak2m5qY1JZA52TgCLnb0Zlxl2I7QizMK2xUaH33EcsB7aIS8Gn1OjVrM5licJ
 6tWlaF6EbXIiUUb37baJ0Zd0PN4oJ0KtYtQwTmputgqJWm-6V4jymhG>
X-ME-Proxy-Cause: dmFkZTFEwk/pbFsgZVvj1/HzO07XC8c86PahbIj9Ip0Bc489VSmLqZw2fxt9jqTF6ASy2J
 Bh8LpJFRvRMfxgrm0BzqpnQ4+FLZVi6/PYWufUjxT9Vw2yLZMvXhGutXjCdn5zpysql4rf
 4oXu8f8leUGkFACC3NRJZNhD3z1gLg3BuiiSNulTSbNf/7sZabwsiK4Ivzij5BKUo/pvlm
 N5bsM1GtBKSA2QAmu2L9srOMeJlcR+G3QpuNNzrAlfxtUkOtu1ETj8xY0ae0n16CaydZ7o
 0SYTEts/JKJ/hF8H5riazj4NnaBJJINfKYCXtU2ogsd4knZf2c6XXMR7LDauOa3DULeriZ
 0zecyUgKRcqt+NBZFIG8DW19AN2ywWhsRUrQ3XXV5vcRLgJ4+0Xr/XpS4f8hEyG0LtKFqt
 QnpEuZK818HonIlCCpCzRvx5ykclnNC0zhvRgqyrLMdw1J/ipnqJ/ufaaxN1IjTJXgKNYS
 OTydTB/ZaZX67n+6HNlgcl4plIjbODbPBp0bqLPXFArdRv6l/GqG7nWmZuQ2/dwI+RA6rG
 QyZZ8rIoMag4LJSVL6jK/uYEStG2jXNGSqxUE2hRLSUV++qO702qwXCJbFQ7sdrkjKip51
 kT2tH8QDoaWCFZEfJgoWEwICI/2gQcKdPgM7OZxkPWi4zRiW1TF1JGHhqSDw
X-ME-Proxy: <xmx:sc6ialjamB9SeQnHab_t6ZRsQqT-buxwQbX7Pk1AlPeCCTQb7rOOeQ>
 <xmx:sc6iaglIqAf0vosGUApMblzQyeJj-NLS64wxskaXgk2cV7M71tEuZw>
 <xmx:sc6iaiTuMxs-CFVvJ2UHUpblwBGAL8YpG-Y6W7CwFQlvVLQUZWL9Mg>
 <xmx:sc6iasWedQvENNAVhlBvV-KNGWkAMnU-r3agZilH1yq9Zos-xHWiZQ>
 <xmx:uc6ian8Q2FSkLT9gPSPBqk5JaLSiRD4MeryCzmrJXmDUbfNMGy4g4w1i>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
 id A91DC32A007B; Thu, 10 Sep 2026 11:37:14 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
MIME-Version: 1.0
X-ThreadId: Ay04W235egbV
Date: Thu, 10 Sep 2026 17:36:54 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nicolai Buchwitz" <nb@tipi-net.de>,
 "Fernando Fernandez Mancera" <fmancera@suse.de>
Cc: Netdev <netdev@vger.kernel.org>, "Simon Horman" <horms@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>,
 "David S . Miller" <davem@davemloft.net>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Leon Romanovsky" <leon@kernel.org>,
 "Andrew Lunn" <andrew+netdev@lunn.ch>,
 "Anthony L Nguyen" <anthony.l.nguyen@intel.com>,
 "Przemek Kitszel" <przemyslaw.kitszel@intel.com>,
 "Elad Nachman" <enachman@marvell.com>,
 "Saeed Mahameed" <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>,
 "Mark Bloch" <mbloch@nvidia.com>, "Ido Schimmel" <idosch@nvidia.com>,
 "Petr Machata" <petrm@nvidia.com>, "Edward Cree" <ecree.xilinx@gmail.com>,
 "Maxime Chevallier" <maxime.chevallier@bootlin.com>,
 "Maxime Coquelin" <mcoquelin.stm32@gmail.com>,
 "Alexandre Torgue" <alexandre.torgue@foss.st.com>,
 "Arend van Spriel" <arend.vanspriel@broadcom.com>,
 "Miri Korenblit" <miriam.rachel.korenblit@intel.com>,
 "Keith Busch" <kbusch@kernel.org>, "Jens Axboe" <axboe@kernel.dk>,
 "Christoph Hellwig" <hch@lst.de>, "Sagi Grimberg" <sagi@grimberg.me>,
 "Chaitanya Kulkarni" <kch@nvidia.com>,
 "Saurav Kashyap" <skashyap@marvell.com>,
 "Javed Hasan" <jhasan@marvell.com>, GR-QLogic-Storage-Upstream@marvell.com,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 "Martin K. Petersen" <mkp@kernel.org>,
 "Nilesh Javali" <njavali@marvell.com>,
 "Manish Rangankar" <mrangankar@marvell.com>,
 "Varun Prakash" <varun@chelsio.com>,
 "Alexander Viro" <viro@zeniv.linux.org.uk>,
 "Christian Brauner" <brauner@kernel.org>, "Jan Kara" <jack@suse.cz>,
 "David Howells" <dhowells@redhat.com>,
 "Marc Dionne" <marc.dionne@auristor.com>,
 "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Chuck Lever" <cel@kernel.org>,
 "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>,
 "Dai Ngo" <Dai.Ngo@oracle.com>, "Tom Talpey" <tom@talpey.com>,
 "Marek Lindner" <marek.lindner@mailbox.org>,
 "Simon Wunderlich" <sw@simonwunderlich.de>,
 "Antonio Quartulli" <antonio@mandelbit.com>,
 "Sven Eckelmann" <sven@narfation.org>,
 "Nikolay Aleksandrov" <razor@blackwall.org>,
 "Pablo Neira Ayuso" <pablo@netfilter.org>,
 "Florian Westphal" <fw@strlen.de>, "Phil Sutter" <phil@nwl.cc>,
 "Johannes Berg" <johannes@sipsolutions.net>,
 "Matthieu Baerts" <matttbe@kernel.org>,
 "Mat Martineau" <martineau@kernel.org>,
 "Geliang Tang" <geliang@kernel.org>, "Julian Anastasov" <ja@ssi.bg>,
 "Aaron Conole" <aconole@redhat.com>,
 "Eelco Chaudron" <echaudro@redhat.com>,
 "Ilya Maximets" <i.maximets@ovn.org>,
 "Allison Henderson" <achender@kernel.org>,
 "Jamal Hadi Salim" <jhs@mojatatu.com>, "Jiri Pirko" <jiri@resnulli.us>,
 "Marcelo Ricardo Leitner" <marcelo.leitner@gmail.com>,
 "Xin Long" <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>,
 "Dust Li" <dust.li@linux.alibaba.com>,
 "Sidraya Jayagond" <sidraya@linux.ibm.com>,
 "Mahanta Jambigi" <mjambigi@linux.ibm.com>,
 "Tony Lu" <tonylu@linux.alibaba.com>, "Wen Gu" <guwen@linux.alibaba.com>,
 "Jon Maloy" <jmaloy@redhat.com>,
 "Tung Quang Nguyen" <tung.quang.nguyen@est.tech>,
 "Steffen Klassert" <steffen.klassert@secunet.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Casey Schaufler" <casey@schaufler-ca.com>,
 "Paul Moore" <paul@paul-moore.com>, "James Morris" <jmorris@namei.org>,
 "Serge E. Hallyn" <serge@hallyn.com>,
 "Vikas Gupta" <vikas.gupta@broadcom.com>,
 "Bhargava Marreddy" <bhargava.marreddy@broadcom.com>,
 "Rajashekar Hudumula" <rajashekar.hudumula@broadcom.com>,
 =?UTF-8?Q?Markus_Bl=C3=B6chl?= <markus@blochl.de>,
 "Heiner Kallweit" <hkallweit1@gmail.com>,
 "Florian Fainelli" <florian.fainelli@broadcom.com>,
 "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Qingfang Deng" <qingfang.deng@linux.dev>,
 "Julian Braha" <julianbraha@gmail.com>,
 "Ethan Nelson-Moore" <enelsonmoore@gmail.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Eric Biggers" <ebiggers@kernel.org>, "Ard Biesheuvel" <ardb@kernel.org>,
 "Neal Cardwell" <ncardwell@google.com>,
 "Kuniyuki Iwashima" <kuniyu@google.com>,
 "Willem de Bruijn" <willemb@google.com>, "Alyssa Ross" <hi@alyssa.is>,
 "Joel Granados" <joel.granados@kernel.org>,
 "Oleg Nesterov" <oleg@redhat.com>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "open list:NETRONOME ETHERNET DRIVERS" <oss-drivers@corigine.com>,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org,
 "open list:ETHERNET BRIDGE" <bridge@lists.linux.dev>,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org,
 "open list:TIPC NETWORK LAYER" <tipc-discussion@lists.sourceforge.net>,
 linux-security-module@vger.kernel.org
Message-Id: <cda5d4e9-49a5-4d6f-93d4-fb50d74ed5ce@app.fastmail.com>
In-Reply-To: <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
 <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
Content-Type: text/plain
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

On Thu, Sep 10, 2026, at 17:11, Nicolai Buchwitz wrote:
>> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
>> index 2997382d597c..00fda9e08cb0 100644
>> --- a/net/packet/Kconfig
>> +++ b/net/packet/Kconfig
>> @@ -5,6 +5,7 @@
>> 
>>  config PACKET
>>  	tristate "Packet socket"
>> +	depends on IPV4
>
>    depends on IPV4 || !INET
>
> Otherwise this would break existing configs with INET=n. The same 
> applies to other affected options that currently permit INET=n.

Since that's a lot of symbols that all need the same dependency,
maybe we could have an intermediate symbol for it:

config IPV4_IF_INET # or any better name you can think of
      def_bool IPV4 || !INET

Similarly, everything that currently has 'depends on INET && IPV4'
could be simplified to just 'depends on IPV4', and the leftover
'depends on INET && IPV6' from the days of modular IPV6 can now
become 'depends on IPV4'. We only needed to list both in the past
to deal with the IPV6=m case.

       Arnd
