Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0734EC79FBF
	for <intel-wired-lan@archiver.kernel.org>; Thu, 10 Sep 2026 15:49:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4CB860B93;
	Thu, 10 Sep 2026 15:49:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 77-QSq_uhsh5; Thu, 10 Sep 2026 15:49:48 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 1585B60B8D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789055388;
	b=SYwnrnVlWXtow6lXWxJ8hFyKsT8Mi6pKyglWnek7jczMYBXB9n6xe823NL43ycM/HmXC
	 lWVapA1Kbt1g8j8yXX/oZJIeLP8iRITmZrVuerFhj1042rQgh1Na8JcVbIX1AicdWcFv0
	 SQ3ke8aw9+Bjw2SjC/rE8HeBET8ve26YBlY2puaDjKnRAWSHFJPkVmMvlnjARLteYGoXH
	 cEnul/6GYwSgGvSaz1r5n9bhlVtBq+iYzWESwgjhHDqW/DRAPKAiDz/QCMGWOp+h8G6sb
	 HghR94Z4R/pf6nV1yI/IiqX7T8ol/m6T/7/+HBSxDIkJqdX9V6YzDLROjLatJAUKdUg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789055388;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:Subject:
	 In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version:
	 X-Mailman-Approved-At:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
	b=coUZjIsLeJ8ijWBzwgxY6UYy5SdhKMwFH3yNB9hLHwowQaC5DZyt6sGNWknvg4hEMpDw
	 MHJ8glIxf41UKsdgnUDtw2tErkaSFLm09U6GeHVN7N7sKbNfMGgvSmt8kGYbjWF/T+N5y
	 5bQCWtjOE06/P+M4JjYJYpQ0SJa4HK+QfaijPGLQMDgw/n2gz7Ieu79oBpelhfLuIumgK
	 6upWCkGeOBAA8yLbCCMfcYutvbc2UTyfe01Pu5T/Zf5DQ5oBoaB9R9OVFC9mcZo03OEze
	 iVnEXDsD1PoYLvBAmTNVtvRlZYdM6MVoyqmhr7bhTUHI9OtTN4dEo7b2lKK+VA0HefQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; dmarc=none header.from=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=Hpdx1B0R;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1789055388;
	bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=uz0/sHCgFaaz3xvdZA7T4/N93WolzdJ8+Mr5qIgJl5mE62ifYbtlsPf6PK7wP4os2
	 FoJEMKlWXXggxy4om8O7qbwjDj6BaHVKBq3CpixGv2XxL8EKqDON7Tv/N1z5juV3V0
	 P8H63Ip4Xi1xvlVter6j+HNSFTJLVD+R6bYNdP2AnjBQF0PXCWJyimUiagcc41sxzY
	 XJ2u4dF+eMt7O1Wc2TaLaUMZAGSR2b6vQqmmphS66EtmVuG99KD8KxzWWbYvUl49nk
	 KhvMuRdT+6oOkg79RVPvTBGRGdV8s6z/oK2L8glWHfLPZFS3055obQqloEq8f3vwQT
	 +QndNgZLsvKJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1585B60B8D;
	Thu, 10 Sep 2026 15:49:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id AC4D4769
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:22:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9215560B69
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:22:48 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id OyDJREBuToBi for <intel-wired-lan@lists.osuosl.org>;
 Thu, 10 Sep 2026 15:22:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 98A6760B55
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2a03:4000:43:185::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789053767;
 b=p2/z6A0ntsV9z7loxx+MTl0HjP2LmNprBxsD9j5Bc7miT6k+W75OIexd+lldpP2FVpQT
 s4tVfRBdoZSQkOdEASJH83AJQZAPhUlvOphEGSUCI8jMtQudXOQWYnN2yL7NTHC5FmfqY
 CP0ZnNW+XRzDXPH9xK7NxDd9J77Ln/JHAWES1oLfjK5C1yYm/gmVtTF2Qa2gC0RODjhuK
 TDp0QEafst/owtxmLuT9P2NFMmCtsab1qohUf2g91ZdMgZ7/sqa9t9jdlM9wPp3PiCTfF
 asQCE6tGGACwYHbeulWNCffDmvIgJXnHnShk645EGMxa6uSZ/LxrB5jlZmYyhUOJGdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789053767;
 h=X-Greylist:Received-SPF:Received:DKIM-Signature:MIME-Version:Date:
 From:To:Cc:Subject:In-Reply-To:References:Message-ID:X-Sender:
 Content-Type:Content-Transfer-Encoding:X-Last-TLS-Session-Version;
 bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
 b=A8aiQsknGz1ulLCFor8lHtC8fXm3RRAyVGtA4/zkV3TGAVdrcUYfgu6E+ZtmxKVvOUC+
 ftlBSyH1699w3HPLbpM/ZuG/wDYUdSJhY8M/vyS5y+/lUc7WvEBVK+02iy+AlF2Pjk5U+
 WqL4UD152s9ENRk+YVkrotPs0B0jTTy8GaWQ+h1HMizYkghfZ4wCb6+DnEQeAQtsmY14n
 VSRMboZiu2DvoY0oSrlFMe3xfdxlY/Mi+yqSD36HzrAOMfpvHw/U2FfBJJhb/KgnX2Q2R
 K0tQR2YpVUbMTOOsQcWSGQ0/u7rG4m87zq7rXSkslAfgcm7cyEPYId2EF70cdp463BA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org;
 dmarc=none header.from=tipi-net.de; 
 dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256
 header.s=dkim header.b=Hpdx1B0R; 
 arc=none smtp.remote-ip="2a03:4000:43:185::1"
X-Greylist: delayed 632 seconds by postgrey-1.37 at util1.osuosl.org;
 Thu, 10 Sep 2026 15:22:44 UTC
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256
 header.s=dkim header.b=Hpdx1B0R
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a03:4000:43:185::1;
 helo=mail.tipi-net.de; envelope-from=nb@tipi-net.de; receiver=<UNKNOWN> 
Received: from mail.tipi-net.de (mail.tipi-net.de [IPv6:2a03:4000:43:185::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 98A6760B55
 for <intel-wired-lan@lists.osuosl.org>; Thu, 10 Sep 2026 15:22:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 47C55A4169; Thu, 10 Sep 2026 17:11:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
 t=1789053121; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=kpbngov4RIuLBylCtoJAheo73LrZm+/bp+JAwq7KaTM=;
 b=Hpdx1B0RklFI70C6JovHFAuJwyocwPn/ocqTHpQdmGbpphdH1JIBcqr/YtbjcnbJ6ZtOfU
 7pePFoQRb7XlSWPffSMETd4TTPd0pZvW3piaRLHiSzL0tVz45TkmmC2BocAwDgRAgvuxw0
 XQneeJ/zpQOFh0La0WXgAbUPdKcd8z5ra8QU6CZxRLdgdCdeyMNYnQxqtLLs9ZeTuL8OPy
 5sN4KooGBkX/6RmSaBGO1l2v7csMS5zxmT0Ku9YXijilyY5qmWPpIUxr4cN1jVcamG22ON
 xBaiIr0TLZ8mbFDjdj4iXDwo/xy7DrVzyM+U/yDAqv8gNlxRbnB64AfiV66POA==
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 17:11:33 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, davem@davemloft.net, Jason Gunthorpe
 <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Elad Nachman <enachman@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
 <petrm@nvidia.com>, Edward Cree <ecree.xilinx@gmail.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Keith Busch <kbusch@kernel.org>, Jens
 Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg
 <sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Saurav Kashyap
 <skashyap@marvell.com>, Javed Hasan <jhasan@marvell.com>,
 GR-QLogic-Storage-Upstream@marvell.com, "James E.J. Bottomley"
 <James.Bottomley@hansenpartnership.com>, "Martin K. Petersen"
 <mkp@kernel.org>, Nilesh Javali <njavali@marvell.com>, Manish Rangankar
 <mrangankar@marvell.com>, Varun Prakash <varun@chelsio.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara
 <jack@suse.cz>, David Howells <dhowells@redhat.com>, Marc Dionne
 <marc.dionne@auristor.com>, Trond Myklebust <trondmy@kernel.org>, Anna
 Schumaker <anna@kernel.org>, Chuck Lever <cel@kernel.org>, Jeff Layton
 <jlayton@kernel.org>, NeilBrown <neil@brown.name>, Olga Kornievskaia
 <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey
 <tom@talpey.com>, Marek Lindner <marek.lindner@mailbox.org>, Simon
 Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli
 <antonio@mandelbit.com>, Sven Eckelmann <sven@narfation.org>, Nikolay
 Aleksandrov <razor@blackwall.org>, Pablo Neira Ayuso <pablo@netfilter.org>,
 Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>, Johannes Berg
 <johannes@sipsolutions.net>, Matthieu Baerts <matttbe@kernel.org>, Mat
 Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, Julian
 Anastasov <ja@ssi.bg>, Aaron Conole <aconole@redhat.com>, Eelco Chaudron
 <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Allison Henderson
 <achender@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko
 <jiri@resnulli.us>, Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Xin
 Long <lucien.xin@gmail.com>, "D. Wythe" <alibuda@linux.alibaba.com>, Dust Li
 <dust.li@linux.alibaba.com>, Sidraya Jayagond <sidraya@linux.ibm.com>,
 Mahanta Jambigi <mjambigi@linux.ibm.com>, Tony Lu
 <tonylu@linux.alibaba.com>, Wen Gu <guwen@linux.alibaba.com>, Jon Maloy
 <jmaloy@redhat.com>, Tung Quang Nguyen <tung.quang.nguyen@est.tech>, Steffen
 Klassert <steffen.klassert@secunet.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Casey Schaufler <casey@schaufler-ca.com>,
 Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, "Serge
 E. Hallyn" <serge@hallyn.com>, Vikas Gupta <vikas.gupta@broadcom.com>,
 Bhargava Marreddy <bhargava.marreddy@broadcom.com>, Rajashekar Hudumula
 <rajashekar.hudumula@broadcom.com>, =?UTF-8?Q?Markus_Bl=C3=B6chl?=
 <markus@blochl.de>, Arnd Bergmann <arnd@arndb.de>, Heiner Kallweit
 <hkallweit1@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Qingfang Deng
 <qingfang.deng@linux.dev>, Julian Braha <julianbraha@gmail.com>, Ethan
 Nelson-Moore <enelsonmoore@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Eric Biggers <ebiggers@kernel.org>, Ard
 Biesheuvel <ardb@kernel.org>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, Willem de Bruijn <willemb@google.com>, Alyssa
 Ross <hi@alyssa.is>, Joel Granados <joel.granados@kernel.org>, Oleg Nesterov
 <oleg@redhat.com>, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
 linux-net-drivers@amd.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-wireless@vger.kernel.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, bridge@lists.linux.dev,
 netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
 mptcp@lists.linux.dev, lvs-devel@vger.kernel.org, dev@openvswitch.org,
 rds-devel@oss.oracle.com, linux-sctp@vger.kernel.org,
 linux-s390@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-security-module@vger.kernel.org
Subject: Re: [PATCH 01/13 net-next] net: ipv4: introduce CONFIG_IPV4 to
 decouple the IPv4 stack
In-Reply-To: <20260910144914.8025-2-fmancera@suse.de>
References: <20260910144914.8025-1-fmancera@suse.de>
 <20260910144914.8025-2-fmancera@suse.de>
Message-ID: <aeb37452e976f5d44540ac3a0999d07b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Mailman-Approved-At: Thu, 10 Sep 2026 15:49:46 +0000
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

Hi Fernando,

Thanks for the patch - after nearly 30 years IPv6 should be mature 
enough :)

On 10.9.2026 16:48, Fernando Fernandez Mancera wrote:
> Historically, the IPv4 protocol has been linked to the core INET
> subsystem. Because shared infrastructure like the TCP/UDP engine,
> routing or INET hashtables live inside net/ipv4/, it has been 
> impossible
> to compile a kernel with only IPv6 support.
> 
> This patch introduces the CONFIG_IPV4 Kconfig symbol, which is set to
> 'def_bool y' for now. This does not allow to completely disable the
> IPv4 stack yet but it lays the necessary build-system work for that
> goal.
> 
> In addition, multiple subsystems Kconfig symbols across networking
> features like tunnels, drivers and filesystems have been adjusted to
> depend on IPv4. Keep on mind that follow-up work is required to convert
> the Kconfig symbol to bool and remove the dependency on IPv4 where it
> makes sense.
> 
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---

> [...]

> diff --git a/net/packet/Kconfig b/net/packet/Kconfig
> index 2997382d597c..00fda9e08cb0 100644
> --- a/net/packet/Kconfig
> +++ b/net/packet/Kconfig
> @@ -5,6 +5,7 @@
> 
>  config PACKET
>  	tristate "Packet socket"
> +	depends on IPV4

   depends on IPV4 || !INET

Otherwise this would break existing configs with INET=n. The same 
applies
to other affected options that currently permit INET=n.

> [...]

Thanks,
Nicolai
