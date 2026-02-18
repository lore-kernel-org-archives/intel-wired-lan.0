Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C483EE9A03B
	for <intel-wired-lan@archiver.kernel.org>; Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75DD7605E6;
	Wed, 18 Feb 2026 10:13:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ho7zFfRNfa8T; Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6CFC9605DC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1771409602;
	bh=INQWUBoHdyd40KVmSGoHZIr5TihUkQlSREp3ffp220M=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=xUfpb1QQwD7kUw1rJM0Ol57SLTFqz0CbpOvyMWuQkl+MUoeJu37kBkWC/wkg8MASU
	 CyiZGwV6QG9e87+JB2br/Xj0zo5WbSXSiyzgzNsiuWOBmWFHFGiuw88YqC8Il7VVmJ
	 QymyF4RtY7pEElAUhZ2ukHmp4q01lzIZSHxn5gTsvBcIRV3l4cxQLtZQwOWdQKxo/k
	 CSIy9p+PlBx8/oeoCFwCDc1XwgS54OsOx7rYLBUNvpZQQsnsU14BdRPiXX0d6q/MTa
	 ENy/qfTE+YyR71HiZBNq+zS/jHmXSG1Bg/rQBRJjAg22BNz/JfrgMJI/Gq/qwu04bE
	 BvNP0SceJE+3A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6CFC9605DC;
	Wed, 18 Feb 2026 10:13:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 3DBFB438
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 21FCB4009A
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yVI5om3x7Ur7 for <intel-wired-lan@lists.osuosl.org>;
 Wed, 18 Feb 2026 10:13:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org DEFAA40078
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DEFAA40078
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DEFAA40078
 for <intel-wired-lan@lists.osuosl.org>; Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 16AFA416DB;
 Wed, 18 Feb 2026 10:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0DC7C19423;
 Wed, 18 Feb 2026 10:13:17 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vseYV-00000000LJW-3Io3; Wed, 18 Feb 2026 11:13:15 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Kees Cook <kees@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Wed, 18 Feb 2026 11:12:30 +0100
Message-ID: <cover.1771408406.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1771409597;
 bh=hQYWDaTIE85+WOC6CQ6nA1VAXpHb84+B8MfLik8/hPM=;
 h=From:To:Cc:Subject:Date:From;
 b=d02Pp71Fm4vMO7efubkTyWYQJv6OqhWDcfH7yDy5f3q/bpJvvParwNqbJnu6fD63z
 XXD9RwmeBKw6NyttSW1D1sdSfxwcLeYO9ZRCjhsK+c1MlvUhojI+3xhmDh3LLn4byr
 uEf4t/XgAsbWQXgKwc7Mgotuz0tz4qk8hsLsqkSQrbrYysWJ8It1Dk9g6/MsQN6phC
 dBcI8WfcmzOPKKhS8J77QRwNhbjQM8FjmA4wmqNAcZBmWhyXMbmQ8IonJtah5jYby7
 Cl+G8tW4Bsd+rxAUUmIfQws2Qy+3DyAaWEEuyfbMYdoZ6DDl1axycFfQd8/asJm6Eo
 jBuuXgC8wniDA==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=d02Pp71F
Subject: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
 kernel-doc
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

Hi Jon,

This series contain several improvements for kernel-doc.

Most of the patches came from v4 of this series:
	https://lore.kernel.org/linux-doc/cover.1769867953.git.mchehab+huawei@kernel.org/

But I dropped from this series the unit tests part. I'll
be sumitting it on a separate series.

The rationale is that, when I converted kernel-doc from Perl,
the goal were to produce a bug-compatible version.

As anyone that worked before with kernel-doc are aware, using regex to
handle C input is not great. Instead, we need something closer to how
C statements and declarations are handled.

Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
inside it with one exception: struct_group logic was using very complex
regexes that are incompatible with Python internal "re" module.

So, I came up with a different approach: NestedMatch. The logic inside
it is meant to properly handle brackets, square brackets and parenthesis,
which is closer to what C lexical parser does. On that time, I added
a TODO about the need to extend that.

The first part of this series do exactly that: it extends it to parse
comma-separated arguments, respecting brackets and parenthesis.

It then adds an "alias" to it at class CFunction. With that, specifying
functions/macros to be handled becomes much easier.

With such infra in place, it moves the transform functions to a separate
file, making it hopefully easier to maintain. As a side effect, it also
makes easier for other projects to use kernel-doc (I tested it on QEMU).

Then, it adds support for newer kref annotations.

The remaining patches on this series improve the man page output, making
them more compatible with other man pages.

-

I wrote several unit tests to check kernel-doc behavior. I intend to
submit them on the top of this series later on.

Regards,
Mauro

Mauro Carvalho Chehab (36):
  docs: kdoc_re: add support for groups()
  docs: kdoc_re: don't go past the end of a line
  docs: kdoc_parser: move var transformers to the beginning
  docs: kdoc_parser: don't mangle with function defines
  docs: kdoc_parser: add functions support for NestedMatch
  docs: kdoc_parser: use NestedMatch to handle __attribute__ on
    functions
  docs: kdoc_parser: fix variable regexes to work with size_t
  docs: kdoc_parser: fix the default_value logic for variables
  docs: kdoc_parser: add some debug for variable parsing
  docs: kdoc_parser: don't exclude defaults from prototype
  docs: kdoc_parser: fix parser to support multi-word types
  docs: kdoc_parser: add support for LIST_HEAD
  docs: kdoc_re: properly handle strings and escape chars on it
  docs: kdoc_re: better show KernRe() at documentation
  docs: kdoc_re: don't recompile NestedMatch regex every time
  docs: kdoc_re: Change NestedMath args replacement to \0
  docs: kdoc_re: make NestedMatch use KernRe
  docs: kdoc_re: add support on NestedMatch for argument replacement
  docs: kdoc_parser: better handle struct_group macros
  docs: kdoc_re: fix a parse bug on struct page_pool_params
  docs: kdoc_re: add a helper class to declare C function matches
  docs: kdoc_parser: use the new CFunction class
  docs: kdoc_parser: minimize differences with struct_group_tagged
  docs: kdoc_parser: move transform lists to a separate file
  docs: kdoc_re: don't remove the trailing ";" with NestedMatch
  docs: kdoc_re: prevent adding whitespaces on sub replacements
  docs: xforms_lists.py: use CFuntion to handle all function macros
  docs: kdoc_files: allows the caller to use a different xforms class
  docs: kdoc_re: Fix NestedMatch.sub() which causes PDF builds to break
  docs: kdoc_files: document KernelFiles() ABI
  docs: kdoc_output: add optional args to ManOutput class
  docs: sphinx-build-wrapper: better handle troff .TH markups
  docs: kdoc_output: use a more standard order for .TH on man pages
  docs: sphinx-build-wrapper: don't allow "/" on file names
  docs: kdoc_output: describe the class init parameters
  docs: kdoc_output: pick a better default for modulename

Randy Dunlap (2):
  docs: kdoc_parser: ignore context analysis and lock attributes
  docs: kdoc_parser: handle struct member macro
    VIRTIO_DECLARE_FEATURES(name)

 Documentation/tools/kdoc_parser.rst   |   8 +
 tools/docs/kernel-doc                 |   1 -
 tools/docs/sphinx-build-wrapper       |   9 +-
 tools/lib/python/kdoc/kdoc_files.py   |  54 +++++-
 tools/lib/python/kdoc/kdoc_output.py  |  73 ++++++--
 tools/lib/python/kdoc/kdoc_parser.py  | 183 ++++---------------
 tools/lib/python/kdoc/kdoc_re.py      | 242 ++++++++++++++++++++------
 tools/lib/python/kdoc/xforms_lists.py | 109 ++++++++++++
 8 files changed, 451 insertions(+), 228 deletions(-)
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py

-- 
2.52.0

