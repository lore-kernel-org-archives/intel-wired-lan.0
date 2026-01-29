Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C34C9D358DB
	for <intel-wired-lan@archiver.kernel.org>; Thu, 29 Jan 2026 08:08:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 75D6B60861;
	Thu, 29 Jan 2026 08:08:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pHTjjMDQfhfv; Thu, 29 Jan 2026 08:08:35 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EFE3F60862
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769674115;
	bh=g3sPmE4bsJmPYda+176UiOILnKENTPm8A2UGjRWJtvw=;
	h=From:To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=wFqTtFLrx0DvhjOKKNCWxL55AU5jvkIfN+Gky37yEj53+O96W0Fr2hRSgE9R9eB3L
	 1Bwcf/7Dk4jnw+5jMsY3ADmR4UuAtvFELhpsWotO2AtY4kxVFDVnQbuATMfzI9bL2o
	 0oWhpOxUpt+AQ4ASJg4GaHRQdDMMllgvjy6BQYAYQiDr5aOoh2JumQEz6F2ZXaKnmo
	 VrOfcDHF2gj+A5cj9RXQ8hLXSjvZsM7MD0Wfz15v7PEOpXkUcMqDLfFjY4J51J+mvb
	 H7VUcmxqIlkrMHgGSjXdrz433bL8dsHxsY1Q467acv9T0WwIxucx+D+GTIWHGrHAXB
	 xLfh24JId//3g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id EFE3F60862;
	Thu, 29 Jan 2026 08:08:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8D1031AD
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 7CAFC40429
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id iRzskYrffXib for <intel-wired-lan@lists.osuosl.org>;
 Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 91A4140070
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 91A4140070
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 91A4140070
 for <intel-wired-lan@lists.osuosl.org>; Thu, 29 Jan 2026 08:08:31 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id D4600444E1;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32AFC4CEF7;
 Thu, 29 Jan 2026 08:08:30 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vlN4m-0000000ERMY-2ftW; Thu, 29 Jan 2026 09:08:28 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Kees Cook <kees@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Richard Cochran <richardcochran@gmail.com>, bpf@vger.kernel.org,
 intel-wired-lan@lists.osuosl.org, linux-doc@vger.kernel.org,
 linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Stanislav Fomichev <sdf@fomichev.me>
Date: Thu, 29 Jan 2026 09:07:51 +0100
Message-ID: <cover.1769673038.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769674110;
 bh=CpFZnCKsXaKpTRcH1wYRERdcRFhRq9xxZ9K2UwivETI=;
 h=From:To:Cc:Subject:Date:From;
 b=ojfk/quOeC6rlZ6ssOp/3ezqD86OPKPGp+gEq6gQjjU+aP/6zPZySdSfcS3dJpOrs
 C3Pu8IIE64/3oJHlonHHs3TKQ8jBtzusidNS/7f8ctf13+hyyarNu3thYQ1F8m/n2H
 ihhMgGrVjQtJiXhbytiy9ScvuaMoxsyshf3AnsruFw23OFM9j7X4LeApwfVgHKku56
 ZNx0odlnA7Cp7H5y6xSUeCnn2HU8pEHw9p74iWb0JJEGyCHFKunQxLjNPPO+r0PvW/
 +Wjnt+60lgN6+85zccoOnibHci40PVDKMCIGnJ23f9BLBHtpcHXoi7Cj6L8VSU/CCm
 hyTdJUcLiT3Vg==
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20201202 header.b=ojfk/quO
Subject: [Intel-wired-lan] [PATCH v3 00/30] kernel-doc: make it parse new
 functions and structs
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

And the size grew again: it is now 31 patches...

This is still based on next-20260127.

On this version, I created a new "CFunction" class, with is
just an alias for "NestedMatch" class, meant to simplify the
logic and maintainership for Linux Kernel macros that require
transforms.

With that, a transform list (for instance to cleanup structs)
become a lot simpler and easier to understand:

    #: Transforms for structs and unions
    struct_xforms = [
        (CFunction("__attribute__"), ' '),
        (CFunction('__aligned'), ' '),
        (CFunction('__counted_by'), ' '),
        (CFunction('__counted_by_(le|be)'), ' '),
        (CFunction('__guarded_by'), ' '),
        (CFunction('__pt_guarded_by'), ' '),

        (KernRe(r'\s*__packed\s*', re.S), ' '),
        (KernRe(r'\s*CRYPTO_MINALIGN_ATTR', re.S), ' '),
        (KernRe(r'\s*__private', re.S), ' '),
        (KernRe(r'\s*__rcu', re.S), ' '),
        (KernRe(r'\s*____cacheline_aligned_in_smp', re.S), ' '),
        (KernRe(r'\s*____cacheline_aligned', re.S), ' '),

        (CFunction('__cacheline_group_(begin|end)'), ''),

        (CFunction('struct_group'), r'\2'),
        (CFunction('struct_group_attr'), r'\3'),
        (CFunction('struct_group_tagged'), r'struct \1 \2; \3'),
        (CFunction('__struct_group'), r'\4'),

        (CFunction('__ETHTOOL_DECLARE_LINK_MODE_MASK'), r'DECLARE_BITMAP(\1, __ETHTOOL_LINK_MODE_MASK_NBITS)'),
        (CFunction('DECLARE_PHY_INTERFACE_MASK',), r'DECLARE_BITMAP(\1, PHY_INTERFACE_MODE_MAX)'),
        (CFunction('DECLARE_BITMAP'), r'unsigned long \1[BITS_TO_LONGS(\2)]'),

        (CFunction('DECLARE_HASHTABLE'), r'unsigned long \1[1 << ((\2) - 1)]'),
        (CFunction('DECLARE_KFIFO'), r'\2 *\1'),
        (CFunction('DECLARE_KFIFO_PTR'), r'\2 *\1'),
        (CFunction('(?:__)?DECLARE_FLEX_ARRAY'), r'\1 \2[]'),
        (CFunction('DEFINE_DMA_UNMAP_ADDR'), r'dma_addr_t \1'),
        (CFunction('DEFINE_DMA_UNMAP_LEN'), r'__u32 \1'),
        (CFunction('VIRTIO_DECLARE_FEATURES'), r'union { u64 \1; u64 \1_array[VIRTIO_FEATURES_U64S]; }'),
    ]

(that is the entire set of struct transforms).

I also moved the transforms to a single separate module,
placed at: tools/lib/python/kdoc/xforms_lists.py.

As KernRe, CFunction and NestedMatch have a ".sub" method, a
single transforms table can have all of them altogether.

The first 15 patches on this series were co-developed with Randy,
with came up after the original patch to support sparse annotations
used by clang thread-safety-analysis.

I ended helping identifying kernel-doc issues while help testing
and addressing its and doing some changes to make the parser more
reliable.

After those, I added other patches to cleanup macro
transforms.

Even NestedMatch being more complex than KernRe, on my machine,
parsing all files is 5% faster than before, because we're not
parsing anymore macro definitions.

Ah, due to the complexity of NestedMatch, I opted to write
some unit tests to verify that the logic there is correct.
We can use it to add other border cases.

Using it is as easy as running:

	$ tools/unittests/nested_match.py

(I opted to create a separate directory for it, as this
is not really documentation)

---

v3:
- improved the unittest helper to allow adding in the future
  a runner to create a test suite directly;
- added unittest to tools/python library documentation;
- improved comments at the new modules;
- did several cleanups at the new logic;
- added a fix for NestedMatch not remove ";" at the end,
  mimicing the behavior of KernRe;
- moved transforms to a separate module;
- replaced all regexes to parse macros with the new CFunction
  alias for NestedMatch.

v2:
- added 10 new patches adding support at NestedMatch
  to properly group and replace arguments with \1, \2, ...

Mauro Carvalho Chehab (28):
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
  docs: kdoc_re: don't recompile NextMatch regex every time
  docs: kdoc_re: Change NestedMath args replacement to \0
  docs: kdoc_re: make NextedMatch use KernRe
  docs: kdoc_re: add support on NestedMatch for argument replacement
  docs: python: add helpers to run unit tests
  unittests: add tests for NestedMatch class
  docs: kdoc_parser: better handle struct_group macros
  docs: kdoc_re: fix a parse bug on struct page_pool_params
  docs: kdoc_re: add a helper class to declare C function matches
  docs: kdoc_parser: use the new CFunction class
  docs: kdoc_parser: minimize differences with struct_group_tagged
  docs: kdoc_parser: move transform lists to a separate file
  docs: kdoc_re: don't remove the trailing ";" with NestedMatch
  docs: xforms_lists.py: use CFuntion to handle all function macros

Randy Dunlap (2):
  docs: kdoc_parser: ignore context analysis and lock attributes
  kdoc_parser: handle struct member macro VIRTIO_DECLARE_FEATURES(name)

 Documentation/tools/kdoc_parser.rst   |   8 +
 Documentation/tools/python.rst        |   2 +
 Documentation/tools/unittest.rst      |  24 ++
 tools/lib/python/kdoc/kdoc_files.py   |   3 +-
 tools/lib/python/kdoc/kdoc_parser.py  | 182 ++------
 tools/lib/python/kdoc/kdoc_re.py      | 215 +++++++---
 tools/lib/python/kdoc/xforms_lists.py | 105 +++++
 tools/lib/python/unittest_helper.py   | 348 +++++++++++++++
 tools/unittests/nested_match.py       | 589 ++++++++++++++++++++++++++
 9 files changed, 1277 insertions(+), 199 deletions(-)
 create mode 100644 Documentation/tools/unittest.rst
 create mode 100644 tools/lib/python/kdoc/xforms_lists.py
 create mode 100755 tools/lib/python/unittest_helper.py
 create mode 100755 tools/unittests/nested_match.py

-- 
2.52.0

