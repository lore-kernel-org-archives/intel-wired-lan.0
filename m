Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DEC1C47DDF
	for <intel-wired-lan@archiver.kernel.org>; Tue, 30 Jan 2024 10:33:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D46F340510;
	Tue, 30 Jan 2024 10:33:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D46F340510
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1706610791;
	bh=xLbOPGXhMi++GhmbXpiqXz45+BGlWNHNdXImhw4Tado=;
	h=Date:From:To:References:In-Reply-To:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Cc:From;
	b=1yFN4WzKe+ZCKSihD+IEOp2DLzFGZj1D2awv4+0wwIYvntFLWcbQieYcQa/Fv1+od
	 qI4Aky6TIvKQpk2H1a7WxkHdNT1h84mILGq+9yQe4ZlPuwoy1O0Cgv3cn8iMQjmGHp
	 89SFibLAy4LsEGJ2qwj3r0MAemDkBvqze60pySKh23tvM2eD29FA1/6P6pKq40r+dC
	 9POuS2sXuiKHLuLhTng1blp4Y9PQPdIccyWA/rAQ23ekl86Iezd/7t/VhFA5YdDfyw
	 6wTMnTReGCVvilvuUUTqqefluqB48i3uWfIsN2VRSsIYOiNmhfK/RH2oVu3ijvQ+pg
	 +Bj5xSOybYubA==
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fk5VQKMf4tRF; Tue, 30 Jan 2024 10:33:11 +0000 (UTC)
Received: from ash.osuosl.org (ash.osuosl.org [140.211.166.34])
	by smtp4.osuosl.org (Postfix) with ESMTP id CACD540546;
	Tue, 30 Jan 2024 10:33:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CACD540546
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by ash.osuosl.org (Postfix) with ESMTP id 09C0B1BF29C
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 10:33:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E221940541
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 10:33:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E221940541
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vdr31e4m9xPr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 30 Jan 2024 10:33:07 +0000 (UTC)
X-Greylist: delayed 1072 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 30 Jan 2024 10:33:07 UTC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B216E4052B
Received: from ganesha.gnumonks.org (ganesha.gnumonks.org
 [IPv6:2001:780:45:1d:225:90ff:fe52:c662])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B216E4052B
 for <intel-wired-lan@lists.osuosl.org>; Tue, 30 Jan 2024 10:33:07 +0000 (UTC)
Received: from uucp by ganesha.gnumonks.org with local-bsmtp (Exim 4.94.2)
 (envelope-from <laforge@gnumonks.org>)
 id 1rUl90-00F0vY-2G; Tue, 30 Jan 2024 11:15:06 +0100
Received: from laforge by localhost.localdomain with local (Exim 4.97)
 (envelope-from <laforge@gnumonks.org>) id 1rUl5f-0000000FnQK-1I97;
 Tue, 30 Jan 2024 11:11:39 +0100
Date: Tue, 30 Jan 2024 11:11:39 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Message-ID: <ZbjLWwG8m-FdyxMH@nataraja>
References: <20240127140747.905552-1-hayatake396@gmail.com>
 <154f979e-a335-461b-b72e-5e9c54fe940c@linux.intel.com>
 <CADFiAcJShbgBLXdVgs1vK1jqDFopkRcw-se4b4h0V3Yd60xLVw@mail.gmail.com>
 <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92958c7b-7e5f-4e25-819f-4e52f9ffcf7b@linux.intel.com>
Subject: Re: [Intel-wired-lan] [PATCH net-next RESENT v3] ethtool: ice:
 Support for RSS settings to GTP from ethtool
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.29
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
Cc: Jonathan Corbet <corbet@lwn.net>, vladimir.oltean@nxp.com,
 linux-doc@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>,
 linux-kernel@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 takeru hayasaka <hayatake396@gmail.com>, intel-wired-lan@lists.osuosl.org,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>, mailhol.vincent@wanadoo.fr
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

hi Marcin,

Disclaimer: I have no understanding of the proposed implementation here, just commenting
on this from a 3GPP protocol architecture point of view.

On Tue, Jan 30, 2024 at 10:59:40AM +0100, Marcin Szycik wrote:
> >> gtpc(4|6) doesn't include TEID, so what is its purpose?
> > In GTPC communication, there is no TEID in the CSR (Create Session Request).
> > Therefore, there are cases of GTPC that do not include TEID.
> 
> The way I understand it now, this patch (and the ethtool one) adds hashing on
> TEID field in GTP* headers. So I wanted to ask why do we have a case (gtpc(4|6))
> that doesn't include TEID? Do we hash on other fields in this header?

There are many differen GTPv2C messages, most of which contain a TEID.  So it does
in general still make sense to be able to use RSS for all those other messages.

The CSR (Create Session Request) will not be able to benfit from it, but
it's just the first message initiating a dialogue between two elements
(think of it like a TCP SYN).  All the follow-up messages in that
dialogue contain TEIDs and hence can benefit from RSS.

-- 
- Harald Welte <laforge@gnumonks.org>          https://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
