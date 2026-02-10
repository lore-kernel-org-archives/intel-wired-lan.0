Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1B9EA812F
	for <intel-wired-lan@archiver.kernel.org>; Tue, 10 Feb 2026 15:27:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3344F83B61;
	Tue, 10 Feb 2026 15:27:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id JVpO0ZAuj90C; Tue, 10 Feb 2026 15:27:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58E9483AEF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1770737277;
	bh=mG59xyUNVSMLIoQ08Vjc0zhsfC/yyaxRQcYeJbXwl2c=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=8+gogelFXg70kD7e0y0PfsYAnnNRnaRlih2awMjnG3CD7QehxVvthP9uhPgxEpP64
	 Ib+46OMljcSbsN0VLsgXGOk9UNv0aPo0E0ZAODtref4lMC461WdnUvTWMhuNt1N7AK
	 nPYMwCO454HhXAto3JZO83G2wcCIpU/Zn5KfUbRjmwcpLrTtIedzT3kzS00mycbNk4
	 4pb5HsbuuqQM9O3IhCcy9agEe+fW6qRZqdqnrC62S8yLtLWkHO1SaEHHnf3dvM0AXw
	 GuOVmIW/jw5T0mRKREgjV0wn8HfPuuMMmuHlHOuCY32JqO3GmoMTrZlMIDPCPxF2Ux
	 NjSgBBKzpOv4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 58E9483AEF;
	Tue, 10 Feb 2026 15:27:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 6B2A3F2
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:27:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5939B40C82
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:27:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IzmYFCkgQyWr for <intel-wired-lan@lists.osuosl.org>;
 Tue, 10 Feb 2026 15:27:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.234.252.31;
 helo=sea.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org A0EB44044A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0EB44044A
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A0EB44044A
 for <intel-wired-lan@lists.osuosl.org>; Tue, 10 Feb 2026 15:27:55 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id EB72043A36;
 Tue, 10 Feb 2026 15:27:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BB2C116C6;
 Tue, 10 Feb 2026 15:27:54 +0000 (UTC)
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vppeZ-000000009O1-3uH1; Tue, 10 Feb 2026 16:27:52 +0100
Date: Tue, 10 Feb 2026 16:27:49 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: "David S. Miller" <davem@davemloft.net>, Alexander Lobakin
 <aleksander.lobakin@intel.com>, Alexei Starovoitov <ast@kernel.org>, Daniel
 Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, Stanislav
 Fomichev <sdf@fomichev.me>
Message-ID: <20260210162749.30e84be5@localhost>
In-Reply-To: <87ecn97ild.fsf@trenco.lwn.net>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <87ecn97ild.fsf@trenco.lwn.net>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1770737274;
 bh=/+KOAp07MLHz2UajjqRp0iV6Ut1gJSwomndWsRRW/lM=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=EkbDL2+00gX1IMxuRnq4mK8Ym8kww+9pO5Rrwf7Vqp2vLiKMA1nkLu88PWLG7KkjB
 HhS9qW0B+tLklTRD0PSzDMtGPx26Sh0+33n3lIfL7DdwdwY3x4CjbrGylcPZ2uF7bV
 CYxzU/3C05ngmoNVbprorCvWA0BskBs17aw5Kw1OkeCEksANHB9xK3x7hCSytEhHHC
 uISUMmkk7vnyjP6UMdpesngvg9Q5wJmtf981+xRlBrOXgVApLBTmf9AnNMy9iSQ5qo
 wnb8qRI5Fs+c+ZXWP4r24sTEJe09CIQRn5zVqZqDStWK15khf8HMLYxAzSU0aTLMM5
 v5urAt/+HtZkg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=EkbDL2+0
Subject: Re: [Intel-wired-lan] [PATCH v2 00/25] kernel-doc: make it parse
 new functions and structs
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

On Wed, 28 Jan 2026 10:27:58 -0700
Jonathan Corbet <corbet@lwn.net> wrote:

> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> writes:
> 
> > Hi Jon,
> >
> > It is impressive how a single patch became a series with 25 ones ;-)  
> 
> *sigh*
> 
> I will try to have a good look at these shortly.  It seems pretty clear
> that this isn't 7.0 material at this point, though.

I ended missing your e-mail...

Yeah, it is too late for 7.0.

> 
> One thing that jumped at me:
> 
> > Ah, due to the complexity of NestedMatch, I opted to write
> > some unit tests to verify that the logic there is correct.
> > We can use it to add other border cases.
> >
> > Using it is as easy as running:
> >
> > 	$ tools/unittests/nested_match.py
> >
> > (I opted to create a separate directory for it, as this
> > is not really documentation)  
> 
> Do we really need another unit-testing setup in the kernel?  I can't say
> I'm familiar enough with kunit to say whether it would work for
> non-kernel code; have you looked and verified that it isn't suitable?

I'm familiar with kunit: I wrote myself a bunch of tests using
it for some DRM stuff.

Kunit is focused on testing kernel content. It basically adds
a way for a python script to run self-test logic inside a kernel 
module. It is not meant to test things outside the Kernel.

Also, I'm using the python internal library for it. The only
"fancy" thing I added is a helper module to better work with
unit tests:

- it formats unittest output;
- it passes some parameters to the unittest discover to make
  it more useable;
- it adds argparse parameters to filter tests and control their
  verbosity levels;
- it adds a way to pass argparse values to the tests, as
  some tests may require parameters (like passing a different
  yaml file to a dynamically-generated unit test).

- 

Anyway, I intend to send a new version of this series either
later this week or at the next one.

I'll probably split the unittest part from the part meant to
avoid new warnings after merging from linux-next.

-- 
Thanks,
Mauro
