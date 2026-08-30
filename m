Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 477CFC61DE2
	for <intel-wired-lan@archiver.kernel.org>; Sun, 30 Aug 2026 23:22:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DA02780C47;
	Sun, 30 Aug 2026 23:22:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IG9Inmly537D; Sun, 30 Aug 2026 23:22:15 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1788132135;
	bh=n4rOnTRkH1wkU5lCvSZzN1icwwcD6oE7qDsPfernsaU=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=8vpOJnXu5vOKkFrlhQqJ7TZfAiCaco8/nzYUMemmVeAvJ0yMR7Xvlyg/mQPpHLcsC
	 MMuJlWb/86ZnexHR5iDJDlDM+Rzznbfc01FKX17IYLJ4d9kkcxAsYcaVy2bB7NRDCS
	 d8oS5+ox07GJqqA0ppSpEEoh6EkswEl4yEJ7gqy0e0/Rky99WLsTq857Y+Du1+ynag
	 BBWd0/3JYGZ/A5QOJ+uCiCCVNaMAikD5uIPO9wQhhF9gTgAzNXK/9ytIZdywB/3lY0
	 0AmbXSv6YBkprgV9nDPTmMJ6JMnemHO3Q6bbkNhZlBiiHri1p7/edg7pBACnhCtMwg
	 ykD3wonCSf/Ig==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id CD05880C43;
	Sun, 30 Aug 2026 23:22:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 1BDF8334
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 047A640056
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lyIbz0Q2-EMl for <intel-wired-lan@lists.osuosl.org>;
 Sun, 30 Aug 2026 23:22:14 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1134; helo=mail-yw1-x1134.google.com;
 envelope-from=tactii@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=KYBRu2LA
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com
 [IPv6:2607:f8b0:4864:20::1134])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E831E40050
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 23:22:13 +0000 (UTC)
Received: by mail-yw1-x1134.google.com with SMTP id
 00721157ae682-81e6f0b4610so26056217b3.2
 for <intel-wired-lan@lists.osuosl.org>; Sun, 30 Aug 2026 16:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788132132; x=1788736932; darn=lists.osuosl.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n4rOnTRkH1wkU5lCvSZzN1icwwcD6oE7qDsPfernsaU=;
 b=KYBRu2LAj3BnZpJKpLAqPRMqXuaUK4boBXng/1XMXRTkqvoQAYOgKi7HLHn8rRb4nR
 x4tgUJeaJdwCHrhPuD8JujuUcB1qk54DxIDa7+gWYFqirlSlA/fAQM23Ji96i2lrcrvZ
 odQrxrODHVFqmsRsDcu8rdN8QJ3EwfKzRW3f0udV7czyDgiLrNSG8Y4MYiMTQHqxLDhf
 AVITo3yaBNAxCtvUYOna4u9OBaK4v6pXbyXk4Nml/xnZX7OUE19Oqy1xL4nDhTv78iu8
 cA+U8yxHdOg7F4cguuLtYwgKHvAYl8gvSyaMUOIuzztSBSbn8aKuE19cMfwTKQHnB/xq
 bULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788132132; x=1788736932;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n4rOnTRkH1wkU5lCvSZzN1icwwcD6oE7qDsPfernsaU=;
 b=ol5/NSP9wNQXVdPWCLiSqyUG5FyG+K4VrGboo7THyxdsd7LJ7XM31qNQ5fP2/9R3M8
 445nGaN0GWI/flxt98P3Sifyv35f1giAlOh6ZLqe1FOcgdPNtGi63bfpWcXdFtvMCpf8
 ryYp2MwAOIve0FQz7j13N+YD3F05U7UYmHkHjuqw4Ij7aQDAStlkP/EuW3D0MUSawLRe
 2I56ZEJCa+uOKEJ9NdAiGILrDVMX7LTrDCLqY+DV6DnDzS+neGoxaNU2JStkESHJuJVV
 Y9GIthwOWOqukl91YTUvApBY9oNvJhP8h2meOUawRbikkS8BgU+RSxJb3+l/82VNrN62
 uIeA==
X-Gm-Message-State: AFuF++nSFby/p/ciPlsQZYzQCc7wVpk8ItxSP9Ys3cUFe5sz6Ae5patv
 Q5VdYFmtbFV1L5RQMRGfotg4zDIGPZxLm+JEADiwgr7sYVu+PV7Ca2Eo8v7B/XbJ7LA=
X-Gm-Gg: AYBFou3HIkoM6Y0oDDEeXN/7xjMa2TcEgTTnr0lsVaMYD7N2fHKG6PqHe4vL21v5APU
 W4ppevQLFASXORbZQnqKDh/fOeTLBaFRoPquCUhukClKGdlcOS1GLvldlhRCo7clpnyxo7/9RRE
 7MV9X+uTo1XJXIJkc4AM5qM8jlCkrO/7bsMagur2wVC67E5+1LLKwKp/IJeTu+P8xFSAzTJaftS
 8e3rOgE3W3U8kmx6XNl7Gth0H02fP5FZ4WxCp7EY5RIxtHgGb3v62h2aRyP08kLyRvVXkNIxMzp
 TgAR9rMeZOvZ/tUsaRdCslwWb5l01/fcWGsfQ/nEEfWIlILiJQu/6xaTBuNURQQmupYd0/Yixj2
 Uu3K2U9bXVYjin0QmwOsTP8rx0v7grgjji4pEIwwb8iwVDAV9zKDd+gTQDTGrlvsbilakzECPRn
 0O2XyopUabtj7ZIADCte0qFzrIi0FH/Szhy2BznUfP
X-Received: by 2002:a05:690c:38a:b0:861:d742:8c1 with SMTP id
 00721157ae682-86722c33022mr677777b3.2.1788132132176; 
 Sun, 30 Aug 2026 16:22:12 -0700 (PDT)
Received: from devobuntu.lan ([2600:6c5c:6b00:316::23])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-85e677606aesm39025937b3.45.2026.08.30.16.22.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 30 Aug 2026 16:22:11 -0700 (PDT)
From: Matt Vollrath <tactii@gmail.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Matt Vollrath <tactii@gmail.com>
Subject: [PATCH iwl-next 0/8] e1000e: use page pool
Date: Sun, 30 Aug 2026 19:21:38 -0400
Message-ID: <20260830232146.36948-1-tactii@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series converges the three e1000e Rx paths into one and then makes
it use a page pool. The jumbo path is chosen as the golden path because
it is the only one that can handle every combination of MTU and page
size. Any performance regression caused by using that path for all
configurations is remedied by eliminating allocations and DMA mapping
from the hot path, as shown in benchmarks below.

There are some general modernizations in this conversion, intended to
make this driver match conventions found in other Intel drivers. The
copybreak parameter is removed. The NAPI skb cache is used. The netmem
API is used for chained frames. Prefetch is used optimistically in the
cleaner loop to pull in the next descriptor and the frame headers.

User-visible changes:
* The copybreak module parameter and its documentation are removed.
* The rx_header_split ethtool stat is removed.
* Small packets are charged at the buffer's full 2 KB truesize at
  standard MTU.
* Jumbo MTU frames are delivered as 2 KB chunks. At MTU > 2026 this
  increases userspace copy overhead by gathering more fragments and
  increases truesize accounting per frame. This is described in more
  detail below.

The series begins by fixing some existing bugs which would either be
more reachable or have worse consequences after the conversion.
Missing support for CrcStripping=0 is added. The page dump routine's
mis-read of jumbo buffers is remedied. A race between the reset task
and runtime PM is guarded.

Then the standard and packet-split paths are removed, making the jumbo
path the only way to Rx. At this point standard-MTU Rx allocates and
maps a page per packet, until the page pool conversion removes that
cost.

Next NAPI is disabled while the adapter is down, which is required to
pass assertions when the page pool is destroyed.

Next is the main event, the singular Rx path is converted to use a page
pool with support from libeth.

Finally, a small change to Tx to return skbs to the NAPI cache, which
the Rx side now pulls from when constructing frame heads.

Benchmarks were run on an I218-V and Xeon E3-1240v3 pinned at 3.8GHz.
NAPI was isolated on one core and iperf3 on another. ITR was fixed at
4000/s because the adaptive scaling can take a few minutes to settle (to
be fixed separately). C-states above C1 and EEE were disabled. Kernel
version was 7.1.12. Direct link from sender to receiver.

The sender was an 82574L in a Xeon E3-1270 pinned at 3.4GHz, NIC vectors
and iperf3 -s pinned to separate cores, ITR fixed.

For cycle measurements, each cell is perf stat cycles on the core
divided by packets received over 30s, averaged over three runs. IOMMU
"lazy" is the default DMA-FQ. Throughput was identical between stock
and series, with one exception noted below. The stock driver is
configured at the default copybreak=256. Note that the stock copybreak
features is flawed; it always remaps DMA when sending an already-mapped
buffer back to the h/w.

Bulk TCP, segments sized to the MTU (line rate at both MTUs):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off     81.4     2523    1784    -29%    2193    2193      0%
  1500  lazy    81.4     5170    1938    -63%    2369    2323     -2%
  9000  off     13.9    11590    7574    -35%   11764   12792     +9%
  9000  lazy    13.9    21781    8423    -61%   12129   13396    +10%

The increase in consumer cost at MTU 9000 is probably because the frame
arrives as five 2 KB chunks instead of three pieces from the legacy
packet-split path. The copy to userspace walks more fragments and GRO
merges fewer frames per skb.

TCP with an 88-byte MSS (iperf3 -M 88, ~142-byte frames):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off    754.3     1453     793    -45%     446     484     +8%
  1500  lazy   754.3     3819     809    -79%     387     496    +28%
  9000  off    754.4     2231     780    -65%     498     509     +2%
  9000  lazy 520/754     6920     798    -88%     430     523    +22%

At MTU 9000 with IOMMU on, the stock driver can't keep up with the
stream at line rate. It polls continuously at 95% of the core and can't
send descriptors back to h/w fast enough, so it sends pause frames and
flow control throttles the sender.

Differences in consumer cost are likely explained by two things:
* The stock copybreak=256 leaves the payload in the NAPI core's cache.
* The high IOMMU cost in the stock driver causes it to return more bytes
  per read.

UDP, one full-size datagram per frame (1472/8972 bytes, line rate):

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off     81.4     4991    4417    -11%    6409    6381      0%
  1500  lazy    81.4     7426    4397    -41%    6619    6395     -3%
  9000  off     13.9    12070    8286    -31%   12861   13624     +6%
  9000  lazy    13.9    21494    8289    -61%   12566   13772    +10%

Here we see a similar tax on the jumbo MTU consumer due to gathering
more fragments.

UDP, 64-byte datagrams paced at 150 kpps:

                      NAPI core cycles/pkt    consumer core cycles/pkt
  MTU   IOMMU   kpps    stock  series  change   stock  series  change
  1500  off    150.2     4202    3939     -6%    5541    5525      0%
  1500  lazy   150.3     6663    3919    -41%    6151    5465    -11%
  9000  off    150.2     4376    3956    -10%    5535    5428     -2%
  9000  lazy   150.2     6821    3953    -42%    6154    5453    -11%

At MTU 9000, this rate of datagrams runs up against the socket receive
buffer's limits in the series, causing a 0.003% drop rate. Because each
datagram sits in a full page buffer, the default 213 KB socket buffer
only holds 48 vs. stock's ~275. This can be remedied by increasing
SO_RCVBUF or rmem_default. This is another example of copybreak truesize
compression value in the stock driver.

Payload Density:

This table shows pieces per frame and density at every MTU breakpoint.
Stock is the standard path at 1500 and packet-split above it.

                stock (std / packet split)    series (2 KB chunks)
MTU            pieces truesize   density    pieces truesize   density
<= 1500           1     2688      0.56         1     2304      0.66
1501-2026         1     4864   0.31-0.42       1     4352   0.35-0.47
2027-4074         1     4864   0.42-0.84       2     8448   0.24-0.48
4075-4096         1     4864      0.84         3    12544      0.33
4097-6122         2     8960   0.46-0.68       3    12544   0.33-0.49
6123-8170         2     8960   0.68-0.91       4    16640   0.37-0.49
8171-8192         2     8960   0.91-0.92       5    20736   0.39-0.40
8193-9212         3    13056   0.63-0.71       5    20736   0.40-0.44

Series chunk counts assume the worst-case frame (MTU + 22: VLAN tag
and FCS present).

This series is hungrier for socket buffer size under two conditions:
* At higher-than-standard MTU, some page size is wasted because
  RCTL.BSIZE only accepts powers of two, unlike the more granular
  settings of later h/w.
* For small packets at any MTU, copybreak no longer moves the payload
  into an appropriately-sized buffer.

Matt Vollrath (8):
  e1000e: add jumbo Rx CRC stripping
  e1000e: dump pages for jumbo Rx buffers
  e1000e: prevent race between PM and reset task
  e1000e: remove packet-split Rx path
  e1000e: always use jumbo Rx path
  e1000e: disable NAPI while interface is down
  e1000e: use libeth page_pool for Rx
  e1000e: return skbs to NAPI cache

 .../device_drivers/ethernet/intel/e1000e.rst  |   15 -
 drivers/net/ethernet/intel/Kconfig            |    1 +
 drivers/net/ethernet/intel/e1000e/e1000.h     |   53 +-
 drivers/net/ethernet/intel/e1000e/ethtool.c   |    1 -
 drivers/net/ethernet/intel/e1000e/netdev.c    | 1374 +++++------------
 drivers/net/ethernet/intel/e1000e/param.c     |    6 -
 6 files changed, 382 insertions(+), 1068 deletions(-)


base-commit: 1b78070aaef63512688aebfbc82365ef9d6660f1
-- 
2.43.0

