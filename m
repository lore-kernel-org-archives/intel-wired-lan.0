Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4221CD79775
	for <intel-wired-lan@archiver.kernel.org>; Sat, 31 Jan 2026 14:25:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18CD060B56;
	Sat, 31 Jan 2026 14:25:34 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8C6ub3EfBhFt; Sat, 31 Jan 2026 14:25:33 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6C0A660B5D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1769869533;
	bh=ZhnMdpvdD7eQXxsKozueTcDL2WcNNZQ9NJGZVbIYRwI=;
	h=From:To:Cc:Date:In-Reply-To:References:Subject:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=wBaOGU+hYTQComYeiCaqrJvbmNm+aO/zxcLW+Y9fZnV2PnW6/hx5QPlKY+iLC45LI
	 VShyEa3ik0ratIe9sai5JXt/WCldJB6Xt2otYXXEOntaut/F4PZcyHInW+fXAghw/b
	 o8dszE1l+R28fc8nwjgUaNATk3YyXOw+S73T5NgOq/LXiSaRAW5cJyiwf+l1QhtvIX
	 YFDm2JGonFSZsXKfTSSqaGXlSvSDyYYfxTxTlzJtxhwi5pnW9REvDhWMaQfUFlAfO3
	 QxWlBDDIUD2vTps4iHQDOWm3KBg9bfK1VM8aU71pXkH2Z9ZiuAQiMpAYICB+DYEg9v
	 rKEzxZ4HoEQrw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C0A660B5D;
	Sat, 31 Jan 2026 14:25:33 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 26A582D3
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDC0483BC7
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sKeYZCLVMDJ5 for <intel-wired-lan@lists.osuosl.org>;
 Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=mchehab+huawei@kernel.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 4B6B983BE4
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4B6B983BE4
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4B6B983BE4
 for <intel-wired-lan@lists.osuosl.org>; Sat, 31 Jan 2026 14:25:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 93A0244505;
 Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C08FC2BD05;
 Sat, 31 Jan 2026 14:25:22 +0000 (UTC)
Received: from mchehab by mail.kernel.org with local (Exim 4.99.1)
 (envelope-from <mchehab+huawei@kernel.org>)
 id 1vmBua-0000000AVmJ-1akZ; Sat, 31 Jan 2026 15:25:20 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 intel-wired-lan@lists.osuosl.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 Randy Dunlap <rdunlap@infradead.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Date: Sat, 31 Jan 2026 15:25:13 +0100
Message-ID: <9bf76cd7412f49f0cf8628ceb3ebb2e1535d9d4c.1769867954.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1769867953.git.mchehab+huawei@kernel.org>
References: <cover.1769867953.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=kernel.org; s=k20201202; t=1769869522;
 bh=fvMjJpvYeiR5dsEmac23+IArGmOBOLOmIiyyzQVBvqE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=XxgdspMdj4pmCSN5G242JuUUWCeu7qsVmXwqQ5luBBhXV+IIqMD587xXrGfXFUfsF
 tDxNWQvnSDcIDoDNZmohLcgq8na8es/trtxx7rzvrc4gf5w0wcMkWAeVPtBlqOIVow
 sm3xNSkA0iixlMEw1YTEyBG1s5E3GDuLnlDk7IR0JJGZD0072klw04EJwtuMPpNxxe
 AdtOEugT5Kc1o2iC1rNMPJytYLxuourKKTPkt7qzrVYN6F/ubvDXPCYYzOoYk9UzLc
 Okky32I8fXWyqpNWBYOHGiSdz5FnT2C8MoF9UCMB07DpV4TVit3vafoCnvA5tKm8jK
 lPZW8/sxNw9Bg==
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
X-Mailman-Original-Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20201202 header.b=XxgdspMd
Subject: [Intel-wired-lan] [PATCH v4 39/41] docs: kdoc_output: pick a better
 default for modulename
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

Instead of placing the same data for modulename for all generated
man pages, use the directory from the filename used to produce
kernel docs as basis.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tools/docs/kernel-doc                |  1 -
 tools/lib/python/kdoc/kdoc_output.py | 41 +++++++++++++++++-----------
 2 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/tools/docs/kernel-doc b/tools/docs/kernel-doc
index aed09f9a54dd..3a932f95bdf5 100755
--- a/tools/docs/kernel-doc
+++ b/tools/docs/kernel-doc
@@ -210,7 +210,6 @@ def main():
                         help="Enable debug messages")
 
     parser.add_argument("-M", "-modulename", "--modulename",
-                        default="Kernel API",
                         help="Allow setting a module name at the output.")
 
     parser.add_argument("-l", "-enable-lineno", "--enable_lineno",
diff --git a/tools/lib/python/kdoc/kdoc_output.py b/tools/lib/python/kdoc/kdoc_output.py
index 1e3dc47bc696..44e40a6e8ca6 100644
--- a/tools/lib/python/kdoc/kdoc_output.py
+++ b/tools/lib/python/kdoc/kdoc_output.py
@@ -589,7 +589,8 @@ class ManFormat(OutputFormat):
     ``modulename``
         Defines the module name to be used at the troff ``.TH`` output.
 
-        This argument is mandatory.
+        This argument is optional. If not specified, it will be filled
+        with the directory which contains the documented file.
 
     ``section``
         Usually a numeric value from 0 to 9, but man pages also accept
@@ -634,14 +635,21 @@ class ManFormat(OutputFormat):
         "%m %d %Y",
     ]
 
-    def emit_th(self, name):
+    def emit_th(self, name, args):
         """Emit a title header line."""
-        name = name.strip()
+        title = name.strip()
+        module = self.modulename(args)
 
-        self.data += f'.TH "{name}" {self.section} "{self.date}" '
-        self.data += f' "{self.modulename}" "{self.manual}"\n'
+        self.data += f'.TH "{title}" {self.section} "{self.date}" '
+        self.data += f' "{module}" "{self.manual}"\n'
 
-    def __init__(self, modulename, section="9", manual="Kernel API Manual"):
+    def modulename(self, args):
+        if self._modulename:
+            return self._modulename
+
+        return os.path.dirname(args.fname)
+
+    def __init__(self, modulename=None, section="9", manual="Kernel API Manual"):
         """
         Creates class variables.
 
@@ -651,7 +659,7 @@ class ManFormat(OutputFormat):
 
         super().__init__()
 
-        self.modulename = modulename
+        self._modulename = modulename
         self.section = section
         self.manual = manual
 
@@ -685,7 +693,8 @@ class ManFormat(OutputFormat):
         dtype = args.type
 
         if dtype == "doc":
-            return self.modulename
+            return name
+#            return os.path.basename(self.modulename(args))
 
         if dtype in ["function", "typedef"]:
             return name
@@ -762,7 +771,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         for section, text in args.sections.items():
             self.data += f'.SH "{section}"' + "\n"
@@ -772,7 +781,7 @@ class ManFormat(OutputFormat):
 
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -818,7 +827,7 @@ class ManFormat(OutputFormat):
     def out_enum(self, fname, name, args):
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"enum {name} \\- {args['purpose']}\n"
@@ -851,7 +860,7 @@ class ManFormat(OutputFormat):
         out_name = self.arg_name(args, name)
         full_proto = args.other_stuff["full_proto"]
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{name} \\- {args['purpose']}\n"
@@ -868,11 +877,11 @@ class ManFormat(OutputFormat):
             self.output_highlight(text)
 
     def out_typedef(self, fname, name, args):
-        module = self.modulename
+        module = self.modulename(args)
         purpose = args.get('purpose')
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"typedef {name} \\- {purpose}\n"
@@ -882,12 +891,12 @@ class ManFormat(OutputFormat):
             self.output_highlight(text)
 
     def out_struct(self, fname, name, args):
-        module = self.modulename
+        module = self.modulename(args)
         purpose = args.get('purpose')
         definition = args.get('definition')
         out_name = self.arg_name(args, name)
 
-        self.emit_th(out_name)
+        self.emit_th(out_name, args)
 
         self.data += ".SH NAME\n"
         self.data += f"{args.type} {name} \\- {purpose}\n"
-- 
2.52.0

