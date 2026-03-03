Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63775EC145B
	for <intel-wired-lan@archiver.kernel.org>; Tue,  3 Mar 2026 14:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0812760EF1;
	Tue,  3 Mar 2026 14:53:20 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id YuUJ99Oyj4Et; Tue,  3 Mar 2026 14:53:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B4C2A60E89
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1772549598;
	bh=NQpTL1xhVxUH3HzflVo3MByyHgQWogYwCavgY3SqVWM=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ADSMzORl6ZTyprho83aK26CNDSuDCMVP4vDh4cSdkUTyq4JTx5BO9BeZKJfYsIYAZ
	 MiIkVxFLDcMQWRtsh2UoqRcNHO0gJ706FnLs6sMJJlhdF2z8GC8RT2tOj6wDfOq8Ob
	 HWyOSv+DbxsUIqN4fBOqN/BZZm7mGvlJRjcTrMpxJhBQUh/58w5ul2GKuX3W15bhS0
	 4nldDPi4cAmMiREgF/rV6rLLOBJaatJgMKKqS29GYpUyHs4WnmoAQM89f0NAIJHHDu
	 Ifcb+2Ldxk0GpALPKsIlnBbnESAdV0G3CKTSgdThYhR3JMfQ1K0L/vGkAbd+6VntO4
	 BUaAtF3uRP2mQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id B4C2A60E89;
	Tue,  3 Mar 2026 14:53:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 1AE4E1EB
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 14:53:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 00D2082214
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 14:53:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uJB4ITRm4fZE for <intel-wired-lan@lists.osuosl.org>;
 Tue,  3 Mar 2026 14:53:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=172.105.4.254;
 helo=tor.source.kernel.org; envelope-from=mchehab+huawei@kernel.org;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org E3EB181404
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E3EB181404
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E3EB181404
 for <intel-wired-lan@lists.osuosl.org>; Tue,  3 Mar 2026 14:53:15 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 54C4960127;
 Tue,  3 Mar 2026 14:53:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D73C19422;
 Tue,  3 Mar 2026 14:53:13 +0000 (UTC)
Received: from localhost ([::1]) by mail.kernel.org with esmtp (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vxR7W-00000007JR5-48Lo; Tue, 03 Mar 2026 15:53:11 +0100
Date: Tue, 3 Mar 2026 15:53:10 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Jonathan Corbet
 <corbet@lwn.net>, Kees Cook <kees@kernel.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, intel-wired-lan@lists.osuosl.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Aleksandr Loktionov
 <aleksandr.loktionov@intel.com>, Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <20260303155310.5235b367@localhost>
In-Reply-To: <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
References: <cover.1771408406.git.mchehab+huawei@kernel.org>
 <33d214091909b9a060637f56f81fb8f525cf433b@intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1772549594;
 bh=mPB+8jSnehbEHKBNReaI36+tVxnO/gz5hMo6CDtR1vU=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=IWFnVb+SAOFAW6k2lmD7xM2MmjXDlaKtuLQfi1BOXrrQ730APm7WOFiF67wuUnc++
 EGSzMenoInTEUWIO7CSSf/bFBl4ZeUXZjL85avoqiMtQK/oSff46KbycV28M9WkDvY
 XUnahFU9ulGTN30W+mMw/EMqmtkIduKav8WJUB/2TDsOz+bW+urOzRV9Fi1DNqM4ee
 y8ZD8ab8w73Luic7Ff60S0bNdLT8kqI7mAwcYvulxf5n9Crzb9z2+s2S3vi5j4rpkZ
 kPzV3aBM8fN2nX5iOYorO3X9cnpTBIe8tlimk92fP+EUrdxUrMwniVlPpd88G7WOWL
 5SvNPVQd6C1oA==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=IWFnVb+S
Subject: Re: [Intel-wired-lan] [PATCH 00/38] docs: several improvements to
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

On Mon, 23 Feb 2026 15:47:00 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Wed, 18 Feb 2026, Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> > As anyone that worked before with kernel-doc are aware, using regex to
> > handle C input is not great. Instead, we need something closer to how
> > C statements and declarations are handled.
> >
> > Yet, to avoid breaking  docs, I avoided touching the regex-based algorithms
> > inside it with one exception: struct_group logic was using very complex
> > regexes that are incompatible with Python internal "re" module.
> >
> > So, I came up with a different approach: NestedMatch. The logic inside
> > it is meant to properly handle brackets, square brackets and parenthesis,
> > which is closer to what C lexical parser does. On that time, I added
> > a TODO about the need to extend that.  
> 
> There's always the question, if you're putting a lot of effort into
> making kernel-doc closer to an actual C parser, why not put all that
> effort into using and adapting to, you know, an actual C parser?

Playing with this idea, it is not that hard to write an actual C
parser - or at least a tokenizer. There is already an example of it
at:

	https://docs.python.org/3/library/re.html

I did a quick implementation, and it seems to be able to do its job:

    $ ./tokenizer.py ./include/net/netlink.h
      1:  0  COMMENT       '/* SPDX-License-Identifier: GPL-2.0 */'
      2:  0  CPP           '#ifndef'
      2:  8  ID            '__NET_NETLINK_H'
      3:  0  CPP           '#define'
      3:  8  ID            '__NET_NETLINK_H'
      5:  0  CPP           '#include'
      5:  9  OP            '<'
      5: 10  ID            'linux'
      5: 15  OP            '/'
      5: 16  ID            'types'
      5: 21  PUNC          '.'
      5: 22  ID            'h'
      5: 23  OP            '>'
      6:  0  CPP           '#include'
      6:  9  OP            '<'
      6: 10  ID            'linux'
      6: 15  OP            '/'
      6: 16  ID            'netlink'
      6: 23  PUNC          '.'
      6: 24  ID            'h'
      6: 25  OP            '>'
      7:  0  CPP           '#include'
      7:  9  OP            '<'
      7: 10  ID            'linux'
      7: 15  OP            '/'
      7: 16  ID            'jiffies'
      7: 23  PUNC          '.'
      7: 24  ID            'h'
      7: 25  OP            '>'
      8:  0  CPP           '#include'
      8:  9  OP            '<'
      8: 10  ID            'linux'
      8: 15  OP            '/'
      8: 16  ID            'in6'
...
     12:  1  COMMENT       '/**\n  * Standard attribute types to specify validation policy\n  */'
     13:  0  ENUM          'enum'
     13:  5  PUNC          '{'
     14:  1  ID            'NLA_UNSPEC'
     14: 11  PUNC          ','
     15:  1  ID            'NLA_U8'
     15:  7  PUNC          ','
     16:  1  ID            'NLA_U16'
     16:  8  PUNC          ','
     17:  1  ID            'NLA_U32'
     17:  8  PUNC          ','
     18:  1  ID            'NLA_U64'
     18:  8  PUNC          ','
     19:  1  ID            'NLA_STRING'
     19: 11  PUNC          ','
     20:  1  ID            'NLA_FLAG'
...
     41:  0  STRUCT        'struct'
     41:  7  ID            'netlink_range_validation'
     41: 32  PUNC          '{'
     42:  1  ID            'u64'
     42:  5  ID            'min'
     42:  8  PUNC          ','
     42: 10  ID            'max'
     42: 13  PUNC          ';'
     43:  0  PUNC          '}'
     43:  1  PUNC          ';'
     45:  0  STRUCT        'struct'
     45:  7  ID            'netlink_range_validation_signed'
     45: 39  PUNC          '{'
     46:  1  ID            's64'
     46:  5  ID            'min'
     46:  8  PUNC          ','
     46: 10  ID            'max'
     46: 13  PUNC          ';'
     47:  0  PUNC          '}'
     47:  1  PUNC          ';'
     49:  0  ENUM          'enum'
     49:  5  ID            'nla_policy_validation'
     49: 27  PUNC          '{'
     50:  1  ID            'NLA_VALIDATE_NONE'
     50: 18  PUNC          ','
     51:  1  ID            'NLA_VALIDATE_RANGE'
     51: 19  PUNC          ','
     52:  1  ID            'NLA_VALIDATE_RANGE_WARN_TOO_LONG'
     52: 33  PUNC          ','
     53:  1  ID            'NLA_VALIDATE_MIN'
     53: 17  PUNC          ','
     54:  1  ID            'NLA_VALIDATE_MAX'
     54: 17  PUNC          ','
     55:  1  ID            'NLA_VALIDATE_MASK'
     55: 18  PUNC          ','
     56:  1  ID            'NLA_VALIDATE_RANGE_PTR'
     56: 23  PUNC          ','
     57:  1  ID            'NLA_VALIDATE_FUNCTION'
     57: 22  PUNC          ','
     58:  0  PUNC          '}'
     58:  1  PUNC          ';'

It sounds doable to use it, and, at least on this example, it
properly picked the IDs.

On the other hand, using it would require lots of changes at
kernel-doc. So, I guess I'll add a tokenizer to kernel-doc, but
we should likely start using it gradually.

Maybe starting with NestedSearch and with public/private
comment handling (which is currently half-broken).

As a reference, the above was generated with the code below,
which was based on the Python re documentation.

Comments?

---

One side note: right now, we're not using typing at kernel-doc,
nor really following a proper coding style.

I wanted to use it during the conversion, and place consts in
uppercase, as this is currently the best practices, but doing
it while converting from Perl were very annoying. So, I opted
to make things simpler. Now that we have it coded, perhaps it
is time to define a coding style and apply it to kernel-doc.

-- 
Thanks,
Mauro

#!/usr/bin/env python3

import sys
import re

class Token():
    def __init__(self, type, value, line, column):
        self.type = type
        self.value = value
        self.line = line
        self.column = column

class CTokenizer():
    C_KEYWORDS = {
        "struct", "union", "enum",
    }

    TOKEN_LIST = [
        ("COMMENT", r"//[^\n]*|/\*[\s\S]*?\*/"),

        ("STRING",  r'"(?:\\.|[^"\\])*"'),
        ("CHAR",    r"'(?:\\.|[^'\\])'"),

        ("NUMBER",  r"0[xX][0-9a-fA-F]+[uUlL]*|0[0-7]+[uUlL]*|"
                    r"[0-9]+(\.[0-9]*)?([eE][+-]?[0-9]+)?[fFlL]*"),

        ("ID",      r"[A-Za-z_][A-Za-z0-9_]*"),

        ("OP",      r"\+\+|\-\-|\->|==|\!=|<=|>=|&&|\|\||<<|>>|\+=|\-=|\*=|/=|%="
                    r"|&=|\|=|\^=|=|\+|\-|\*|/|%|<|>|&|\||\^|~|!|\?|\:"),

        ("PUNC",    r"[;,\.\[\]\(\)\{\}]"),

        ("CPP",     r"#\s*(define|include|ifdef|ifndef|if|else|elif|endif|undef|pragma)"),

        ("HASH",    r"#"),

        ("NEWLINE", r"\n"),

        ("SKIP",    r"[\s]+"),

        ("MISMATCH",r"."),
    ]

    def __init__(self):
        re_tokens = []

        for name, pattern in self.TOKEN_LIST:
            re_tokens.append(f"(?P<{name}>{pattern})")

        self.re_scanner = re.compile("|".join(re_tokens),
                                     re.MULTILINE | re.DOTALL)

    def tokenize(self, code):
        # Handle continuation lines
        code = re.sub(r"\\\n", "", code)

        line_num = 1
        line_start = 0

        for match in self.re_scanner.finditer(code):
            kind   = match.lastgroup
            value  = match.group()
            column = match.start() - line_start

            if kind == "NEWLINE":
                line_start = match.end()
                line_num += 1
                continue

            if kind in {"SKIP"}:
                continue

            if kind == "MISMATCH":
                raise RuntimeError(f"Unexpected character {value!r} on line {line_num}")

            if kind == "ID" and value in self.C_KEYWORDS:
                kind = value.upper()

            # For all other tokens we keep the raw string value
            yield Token(kind, value, line_num, column)

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: python {sys.argv[0]} <fname>")
        sys.exit(1)

    fname = sys.argv[1]

    try:
        with open(fname, 'r', encoding='utf-8') as file:
            sample = file.read()
    except FileNotFoundError:
        print(f"Error: The file '{fname}' was not found.")
        sys.exit(1)
    except Exception as e:
        print(f"An error occurred while reading the file: {str(e)}")
        sys.exit(1)

    print(f"Tokens from {fname}:")

    for tok in CTokenizer().tokenize(sample):
        print(f"{tok.line:3d}:{tok.column:3d}  {tok.type:12}  {tok.value!r}")

