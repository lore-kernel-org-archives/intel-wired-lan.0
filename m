Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6834FEB28DE
	for <intel-wired-lan@archiver.kernel.org>; Fri,  6 Feb 2026 07:45:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0E77B610DA;
	Fri,  6 Feb 2026 07:45:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JPq6kKTmNNQ5; Fri,  6 Feb 2026 07:44:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB79F60EF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770363896;
	bh=xpzWp3yq3XiRmUCcwaPqU4QiBYrxfXsSEJ+PJeVd5pQ=;
	h=Date:From:To:Cc:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=gReOkE0Q9TKXbR2JQ1MkG1KfsJuevGgjNZWOPwpAkcOB2p4eRnKOQhkI2YxGIIdnD
	 YVnI1jOfNqOdu8EbLQrdl3jdOmU/3FOq5rHbjcpzd2mwDfSlYGlvRdVdRK8+dlYV7K
	 0jBUpf40p42Z6r3t1liGaJH8efVAAMzglig8jS1qzbsOL8O2ZbA9ZC9GmhMu8jOSBL
	 k3ghEhTEn+o0KWTykO/QxXt9u+Y6D9uocTu6phcaG3oAjBV+CZEdhrwEajl5JUeMAW
	 NGNi64xZR5fQKBs0Ts5nsY6xeDzbU/t+B6Um+V9TEYSX6leouBeEB9LVpNN6zWRPr1
	 jlOzi8Tp5SxJg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB79F60EF4;
	Fri,  6 Feb 2026 07:44:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 54CE3219
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 07:44:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 34D9C8129E
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 07:44:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4gP6acF4asRK for <intel-wired-lan@lists.osuosl.org>;
 Fri,  6 Feb 2026 07:44:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=193.142.43.55;
 helo=galois.linutronix.de; envelope-from=bigeasy@linutronix.de;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 34B568122F
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 34B568122F
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 34B568122F
 for <intel-wired-lan@lists.osuosl.org>; Fri,  6 Feb 2026 07:44:54 +0000 (UTC)
Date: Fri, 6 Feb 2026 08:44:49 +0100
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Willem de Bruijn <willemb@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
 Paul Menzel <pmenzel@molgen.mpg.de>,
 "Gomes, Vinicius" <vinicius.gomes@intel.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Richard Cochran <richardcochran@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Keller, Jacob E" <jacob.e.keller@intel.com>
Message-ID: <20260206074449.CydBDckN@linutronix.de>
References: <20260205-igb_irq_ts-v3-1-2efc7bc4b885@linutronix.de>
 <IA3PR11MB898652699383BA265C5747A5E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <20260205100347.ssTBDAI_@linutronix.de>
 <IA3PR11MB89865B46DCBEB496BE28703BE599A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <6a0f4cbb-e8b3-4f0e-b7f1-7f9ca5cba97d@linux.dev>
 <20260205145104.iWinkXHv@linutronix.de>
 <66925f09-ef9f-4401-baec-7d4c82a68ce3@linux.dev>
 <20260205164341.pJvni8kA@linutronix.de>
 <76acd5cc-eb6f-4c56-a5e6-f6413736afbb@linux.dev>
 <willemdebruijn.kernel.459b2672b1e7@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <willemdebruijn.kernel.459b2672b1e7@gmail.com>
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020; t=1770363891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpzWp3yq3XiRmUCcwaPqU4QiBYrxfXsSEJ+PJeVd5pQ=;
 b=yU7OniFO6DTMhIXOIMwHx7vYb7Fc4wabicbGx8o5Ba3wljCAO+o9srwyg4uB3E89V8HsQ+
 1ctbCpBpTXlokDCVTfZL1xXfW07uhvABrJ7xoclNksmrKiREuozwOheb0Hmpd1E3l2k/Bn
 Ua9Y2RrUuhzXPFnXZ0LDY9Vmo9Iby+wWEsV/U897nWGyqJZJNTxmKSgmhPY5H68vZrDVGR
 Kj2kXsnsdbzhwuKjAsStvLIR9oTcD+1BQs2cTgr1pVn+aU05Fx9vpP0QRRez7PAKERPEod
 wj9WztLnKDdVxM/7xvyvXsYXAHq+0RJv8d0S1y2EgpCwjWJZ5RJ2wCl9SIYemg==
X-Mailman-Original-DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=linutronix.de; s=2020e; t=1770363891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xpzWp3yq3XiRmUCcwaPqU4QiBYrxfXsSEJ+PJeVd5pQ=;
 b=N5W2jvDG3T5AdCJ5JQCIxnv7FBwjhTyLCY2tspJ0SgS8bn/Nwnk0lIxL60AORnUhZJWbuC
 A6C1iKTuhsJ2oKDQ==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none)
 header.from=linutronix.de
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de
 header.a=rsa-sha256 header.s=2020 header.b=yU7OniFO; 
 dkim=pass header.d=linutronix.de header.i=@linutronix.de
 header.a=ed25519-sha256 header.s=2020e header.b=N5W2jvDG
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v3] igb: Retrieve Tx
 timestamp directly from interrupt for i210
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

On 2026-02-05 16:41:03 [-0500], Willem de Bruijn wrote:
> 
> Requiring OPT_TSONLY unless CAP_NET_RAW would break legacy users.

okay. Can we move the check to sock_set_timestamping()/ setsockopt()
time? On the plus side we could throw an error instead silently dropping
packets. This might be a late win given that you describe the users as
legacy users.
I'm not sure if the "permission" can change over time and so get revoked
while an application is running.

Sebastian
