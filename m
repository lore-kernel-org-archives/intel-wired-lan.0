Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8EA4D358DD
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:14:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id BBBD680B36;
	Thu, 29 Jan 2026 08:14:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LoeInKTgquXv; Thu, 29 Jan 2026 08:14:12 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAE7180577
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674452;
	bh=7cCn0MHAgauxm4ZGdaBittXgn+Ig3AyYlbYQYfq1ZHs=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ku1D8em6NrNST+K5T/sNEr9asHRygcErvCHbiFKP2GOwzVM5bg40lFbhC97IVpO38
	 Zof8bSthq7TiIqQDa4LzUZQS/CCz5/7q+N7opSsb/g61aVvnooFqqm9LH58uq/kPAg
	 56D7lorosn/u1mrF9x69RqhS5FEV2Nn7R8f+g/A+KIsJKJ9Fij3H+zWrrUFjvsMfTE
	 md5VIY3AsXyfnbjQ+iBlrrKYn53g/MtGa6eyAim+HTBd2vuf9uZVlxl21OwfjGYHoB
	 QKVIqs37ryevBiWq9bq0HawH1aelxhjEcR7M5Jj8+FKwuTAy7cGCIIauTs3PhRygj2
	 pMGE9XLUwaC4A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id BAE7180577;
	Thu, 29 Jan 2026 08:14:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id C8FEE118
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B7CB4402DD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:14:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id A3PomrCD3kNV for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:14:10 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org D2B1B40231
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D2B1B40231
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2B1B40231
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:14:09 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id EAF4B6001A;
 Thu, 29 Jan 2026 08:14:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC4FC4CEF7;
 Thu, 29 Jan 2026 08:14:04 +0000 (UTC)
Date: Thu, 29 Jan 2026 09:14:01 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Jonathan Corbet <corbet@lwn.net>, "David S. Miller"
 <davem@davemloft.net>, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard
 Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Mauro
 Carvalho Chehab <mchehab@kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, <bpf@vger.kernel.org>,
 <intel-wired-lan@lists.osuosl.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Shuah Khan <skhan@linuxfoundation.org>, "Stanislav
 Fomichev" <sdf@fomichev.me>
Message-ID: <20260129091401.0b86926c@foz.lan>
In-Reply-To: <09681668-57ca-4294-afa8-95af7eebe630@intel.com>
References: <cover.1769617841.git.mchehab+huawei@kernel.org>
 <87ecn97ild.fsf@trenco.lwn.net>
 <fced629d-2470-4673-ab0b-80de11f0e4c5@intel.com>
 <20260128230045.781937b5@foz.lan>
 <09681668-57ca-4294-afa8-95af7eebe630@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674448;
 bh=7IsBi6ODhtIKV2zts0kTXbGdo6yrQVlVFdfuQtskjHs=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=C+5FPY3qcPpvkQ9sAaI2KNUJHnl83VGZFBDJDwDqIxgZA02L660cmx1Bm60xYV5nI
 vLffxok4X+HFiGw38gYgNDtCo6rTyKmILPzk6tjTbFEq4sL+ZiBeZFPYzSeLS7zvSr
 T9Bswk/yR6F1zuJZGGV7KknByLqYDwRy2toSG9q2jSiuyKPCdQppZzOwZHeSdbNRBU
 YnsRZMqb+PDlrBYnNu+Hj+0C04QyP9qDiReu20XMjtg7q7LGddB3aFrPJngmTy9Dbv
 KdmASKroZhC8GdqGF1TXcPoDY9vVaWFqZrM1taeoMwYCIi9wlsCCEUJ0eb9cynsyux
 5kMDjD7DORw5w==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=C+5FPY3q
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

On Wed, 28 Jan 2026 14:08:50 -0800
Jacob Keller <jacob.e.keller@intel.com> wrote:

> On 1/28/2026 2:00 PM, Mauro Carvalho Chehab wrote:
> > On Wed, 28 Jan 2026 10:15:51 -0800
> > Jacob Keller <jacob.e.keller@intel.com> wrote:  
> >> On 1/28/2026 9:27 AM, Jonathan Corbet wrote:  
> >>> Do we really need another unit-testing setup in the kernel?  I can't say
> >>> I'm familiar enough with kunit to say whether it would work for
> >>> non-kernel code; have you looked and verified that it isn't suitable?
> >>>      
> >>
> >> I'm not sure kunit would be suitable here, since its meant for running
> >> kernel code and does a lot of stuff to make that possible. It might be
> >> able to be extended, but.. this is python code. Why *shouldn't* we use
> >> one of the python unit test frameworks for it?  
> > 
> > This is not using kunit. It is using standard "import unittest" from
> > Python internal lib.
> >   
> 
> Right. I think it makes perfect sense to use unittest for python files. 
> That was the point of my reply above :D
> 
> >> We have other python code in tree. Does any of that code have unit tests?  
> > 
> > Good question. On a quick grep, it sounds so:
> > 
> > 	$ git grep "import unittest" tools scripts
> > 	scripts/rust_is_available_test.py:import unittest
> > 	tools/crypto/ccp/test_dbc.py:import unittest
> > 	tools/perf/pmu-events/metric_test.py:import unittest
> > 	tools/testing/kunit/kunit_tool_test.py:import unittest
> > 	tools/testing/selftests/bpf/test_bpftool.py:import unittest
> > 	tools/testing/selftests/tpm2/tpm2.py:import unittest
> > 	tools/testing/selftests/tpm2/tpm2_tests.py:import unittest
> >   
> >> I agree that it doesn't make sense to build new bespoke unit tests
> >> different or unique per each python module, so if we want to adopt
> >> python unit tests we should try to pick something that works for the
> >> python tools in the kernel.
> >>
> >> Perhaps finding a way to integrate this with kunit so that you can use
> >> "kunit run" and get python tests executed as well would make sense?
> >> But.. then again this isn't kernel code so I'm not sure it makes sense
> >> to conflate the tests with kernel unit tests.  
> > 
> > It shouldn't be hard to add it there - or to have a separate script
> > to run python unittests.
> >   
> 
> Right. Some way to have all unit tests run is nice so that its easy to 
> hook up into various CI processes. Sounds like you have a solid idea on 
> that.
> 
> > That's said, some integration with kunit can be interesting
> > to have it producing a KTAP output if needed by some CI.
> >   
> That could also be interesting, as it would make it easier for other 
> tooling to work with all the tests.
> 
> Personally I am not sure how useful that would be vs just making use of 
> the unittest stuff provided as-is with python.

I'd say that, for now, we don't need a KTAP output, but as things go
more complex and more parts of the tools get unittests added, it 
could make sense to add it.

Adding proper support for it shouldn't be hard with the definitions
inside unittest_helper. All we need to do would be to write a new
inherited class from unittest.TestResult, placing there a 
printResults() method that would generate the KTAP format. We may
add a new "--ktap" argparse argument that, if enabled, it would
use the newer class instead of the Summary class.

Thanks,
Mauro
