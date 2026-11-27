Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5514606A31C
	for <intel-wired-lan@archiver.kernel.org>; Fri, 27 Nov 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=osuosl.org header.i=@osuosl.org header.a=rsa-sha256 header.s=default header.b=meat9BDW;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=M2JottpE
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C7E8460B58;
	Fri, 27 Nov 2026 14:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 7S7E_8nX33hB; Fri, 27 Nov 2026 14:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 246F660B0E
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795789331;
	b=qM1JtT9OD/12U8Vd24uWBj+MjMINU2itpxKqV23pTuOQkaq9hv4cKVnEQxjIMEw0eYCn
	 rtJPsj+1kgRJMsfNZ/C0/fZgv/FtTPw2gn+Pyy2cRJS9ZabECPUSzTPriOou6N/tG2+1I
	 6XNaswD6Ev0JEhRR/T0NguPXy6R4HxHMUEsdphxlOkYXx5hzLlQeabD3JoiMnMdN4lJ2V
	 Cd5M4wR+GjXGSgMYfgECK1NvmEAvpAoWV+hI2w5SyBU2AZdKEuSjis2f0f9vxdqWUsncp
	 2KdshKyEkXyh7gJxZKheviLc0CeKlsep+aXFoiyXB02J1FzBGiFo/eNX22ebfR9kcPg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795789331;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=X0bsYdJlyWcqATyTMwA5Fl8AFNsyQNRuziGQ0uyHJ4A=;
	b=r/JooJpIfpDFtFsHvghdhXd7xDZgg8c8Itnby2f13eZH9V2G9kgKGelrqQYjLN00fd2U
	 rS9Yaro3hbWcAWrmGoYrRhTpjVdSRB8hA3VViafmDarhYAIerq8cMknF7+TKkElJ6CNle
	 ORLRp7sNKINufErvo2uVes6a0Pc2Ov2DCy05DHHl+UqdAxzqowarxHapOTQVsANUFWUfA
	 96gZaFnbCOBqw3GFngrBxSOwQl3FmaJq6SIQThGSNcYNHT1RSsFqPPVV2E/NBi6F0JTk9
	 NfQQU6hbY+e2OlL0WmykZZK8ypqHbCESvDdaPgJ6c+KJeczrmaCueGo+17KMjKDB3rA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1795789331;
	bh=X0bsYdJlyWcqATyTMwA5Fl8AFNsyQNRuziGQ0uyHJ4A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=meat9BDWxY65pixLDqe/zBKMQO8P6PhZUW2DrvwFLQCQWBZor/UYUNwXJURFGlWz9
	 kGm+P+n1RxFPVAaJ1gJcZs5XnT62YvlWKobLJgL+NLrDkSMrpZADq8G7SicLdGMmxi
	 +4rX3D+aEIr0mwsF2dsFEHAvldWJkxtwp6MjtXeRAw/TR8bwUHxSPj5STgTjUNtT7p
	 fKC+DsdNXNbvHB4cekQjwiLbcUrQeQjnDFiTVJLiMGXFEjCEU0N4Kjs4QPL0Y/XTNA
	 cFT22nQuNTWkSi489bbXV9iaOMrsMaxaomj2k9JabOEd/YPYkaeNVZxy854VPUL668
	 PSOKgHpme7q5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 246F660B0E;
	Fri, 27 Nov 2026 14:22:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 11588D1
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0F683811F4
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:22:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 0rVWf4geu91P for <intel-wired-lan@lists.osuosl.org>;
 Fri, 27 Nov 2026 14:22:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0FBB28122D
Authentication-Results: smtp1.osuosl.org; arc=none
 smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org;
 envelope-from=bjorn@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org
 header.a=rsa-sha256 header.s=k20260515 header.b=M2JottpE
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0FBB28122D
 for <intel-wired-lan@lists.osuosl.org>; Fri, 27 Nov 2026 14:22:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 23003601FB;
 Fri, 27 Nov 2026 14:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E5AF1F00899;
 Fri, 27 Nov 2026 14:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795789325;
 bh=X0bsYdJlyWcqATyTMwA5Fl8AFNsyQNRuziGQ0uyHJ4A=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=M2JottpEEnPynSiMrQGu7DZNB0F30ieDghiFnzBpdzvM4lU7maUw8sIkRqW/IH2Hg
 CvJreKZvkrDspGjHRzX6icIt9I5w/8TQHUyqRDgvOGj5zkim68btvetb0bnzyR3JN6
 v9WcTVa9fLS0CzFDP16Mwi4y0SeCq1xCIRKULXZV/BVxYKUaF9XIuCPYkp8WRLp8EO
 XTJXN3jcvI47csE+IRywpDfj2HcTRxCxVApbOIPakzQ9hoShhLYHLtAKD/NDbatgvD
 RpH6tIxkT42ZTRHjc4pOSZboEQgnpYUfBodbQHPZQq7Bm68Meqf38hCo8KJ4KIdkt1
 YPF1E0ivi7yRA==
From: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>
To: Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, Shuah Khan <shuah@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn@kernel.org>,
 Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Ihor Solodrai <ihor.solodrai@linux.dev>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Larysa Zaremba <larysa.zaremba@intel.com>,
 Tushar Vyavahare <tushar.vyavahare@intel.com>,
 Jason Xing <kerneljasonxing@gmail.com>,
 Bastien Curutchet <bastien.curutchet@bootlin.com>,
 Colin Ian King <colin.i.king@gmail.com>, intel-wired-lan@lists.osuosl.org,
 linux-kselftest@vger.kernel.org
Subject: [PATCH net 3/3] selftests/bpf: Drop the zero-copy tailroom from the
 xsk tests
Date: Fri, 27 Nov 2026 15:21:29 +0100
Message-ID: <20261127142131.3527737-4-bjorn@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261127142131.3527737-1-bjorn@kernel.org>
References: <20261127142131.3527737-1-bjorn@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: intel-wired-lan@osuosl.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: Intel Wired Ethernet Linux Kernel Driver Development
 <intel-wired-lan.osuosl.org>
List-Archive: <http://lists.osuosl.org/pipermail/intel-wired-lan/>
List-Post: <mailto:intel-wired-lan@osuosl.org>
List-Help: <mailto:intel-wired-lan-request@osuosl.org?subject=help>
List-Subscribe: <https://lists.osuosl.org/mailman/listinfo/intel-wired-lan>,
 <mailto:intel-wired-lan-request@osuosl.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The xsk tests take the size of the shared info off the UMEM headroom
of RX_DROPPED and off the growth of XDP_ADJUST_TAIL_GROW_MULTI_BUFF,
as zero-copy multi-buffer pools kept it at the end of each chunk.

The previous patch moves the shared info into the buffer pool, so the
UMEM headroom limit and the frame size no longer leave room for it.
Drop it from both tests.

Signed-off-by: Björn Töpel <bjorn@kernel.org>
---
 tools/testing/selftests/bpf/prog_tests/test_xsk.c | 10 ++++------
 tools/testing/selftests/bpf/prog_tests/test_xsk.h |  2 --
 tools/testing/selftests/bpf/prog_tests/xsk.c      | 13 +------------
 tools/testing/selftests/bpf/xskxceiver.c          | 15 +--------------
 4 files changed, 6 insertions(+), 34 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.c b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
index 4549358cc8c2..7145a36e6ea2 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.c
@@ -1984,17 +1984,16 @@ int testapp_headroom(struct test_spec *test)
 int testapp_stats_rx_dropped(struct test_spec *test)
 {
 	struct xsk_umem_info *umem = test->ifobj_rx->xsk->umem;
-	u32 umem_tr = test->ifobj_tx->umem_tailroom;
 
 	if (test->mode == TEST_MODE_ZC) {
 		ksft_print_msg("Can not run RX_DROPPED test for ZC mode\n");
 		return TEST_SKIP;
 	}
 
-	if (pkt_stream_replace_half(test, (MIN_PKT_SIZE * 3) + umem_tr, 0))
+	if (pkt_stream_replace_half(test, MIN_PKT_SIZE * 4, 0))
 		return TEST_FAILURE;
 	umem->frame_headroom = umem->frame_size -
-		XDP_PACKET_HEADROOM - (MIN_PKT_SIZE * 2) - umem_tr;
+		XDP_PACKET_HEADROOM - MIN_PKT_SIZE * 3;
 	if (pkt_stream_receive_half(test))
 		return TEST_FAILURE;
 	test->ifobj_rx->validation_func = validate_rx_dropped;
@@ -2592,12 +2591,11 @@ int testapp_adjust_tail_grow_mb(struct test_spec *test)
 	 * pkt_len, expect that it will be broken down to 2 descs each
 	 * with 3k payload;
 	 *
-	 * 4k is truesize, 3k payload, 256 HR, 320 TR;
+	 * 4k is truesize, 3k payload, 256 HR;
 	 */
 	grow_size = XSK_UMEM__MAX_FRAME_SIZE -
 		    XSK_UMEM__LARGE_FRAME_SIZE -
-		    XDP_PACKET_HEADROOM -
-		    test->ifobj_tx->umem_tailroom;
+		    XDP_PACKET_HEADROOM;
 	test->mtu = MAX_ETH_JUMBO_SIZE;
 
 	return testapp_adjust_tail(test, grow_size, XSK_UMEM__LARGE_FRAME_SIZE * 2);
diff --git a/tools/testing/selftests/bpf/prog_tests/test_xsk.h b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
index 03753ddc5dcd..1b816226597b 100644
--- a/tools/testing/selftests/bpf/prog_tests/test_xsk.h
+++ b/tools/testing/selftests/bpf/prog_tests/test_xsk.h
@@ -32,7 +32,6 @@
 #define USLEEP_MAX			10000
 
 #define MAX_SKB_FRAGS_PATH "/proc/sys/net/core/max_skb_frags"
-#define SMP_CACHE_BYTES_PATH "/sys/devices/system/cpu/cpu0/cache/index0/coherency_line_size"
 
 extern bool opt_verbose;
 #define print_verbose(x...) do { if (opt_verbose) ksft_print_msg(x); } while (0)
@@ -137,7 +136,6 @@ struct ifobject {
 	int mtu;
 	u32 bind_flags;
 	u32 xdp_zc_max_segs;
-	u32 umem_tailroom;
 	u32 max_skb_frags;
 	bool tx_on;
 	bool rx_on;
diff --git a/tools/testing/selftests/bpf/prog_tests/xsk.c b/tools/testing/selftests/bpf/prog_tests/xsk.c
index 772f3dd7ce64..b3758b9bf2ec 100644
--- a/tools/testing/selftests/bpf/prog_tests/xsk.c
+++ b/tools/testing/selftests/bpf/prog_tests/xsk.c
@@ -62,7 +62,7 @@ int configure_ifobj(struct ifobject *tx, struct ifobject *rx)
 
 static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 {
-	u32 max_frags, umem_tailroom, cache_line_size;
+	u32 max_frags;
 	struct ifobject *ifobj_tx, *ifobj_rx;
 	struct test_spec test;
 	int ret;
@@ -85,10 +85,6 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 		ifobj_tx->set_ring.default_rx = ifobj_tx->ring.rx_pending;
 	}
 
-	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
-	if (!cache_line_size)
-		cache_line_size = 64;
-
 	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
 	if (!max_frags)
 		max_frags = 17;
@@ -96,13 +92,6 @@ static void test_xsk(const struct test_spec *test_to_run, enum test_mode mode)
 	ifobj_tx->max_skb_frags = max_frags;
 	ifobj_rx->max_skb_frags = max_frags;
 
-	/* 48 bytes is a part of skb_shared_info w/o frags array;
-	 * 16 bytes is sizeof(skb_frag_t)
-	 */
-	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
-	ifobj_tx->umem_tailroom = umem_tailroom;
-	ifobj_rx->umem_tailroom = umem_tailroom;
-
 	if (!ASSERT_OK(init_iface(ifobj_rx, worker_testapp_validate_rx), "init RX"))
 		goto delete_rx;
 	if (!ASSERT_OK(init_iface(ifobj_tx, worker_testapp_validate_tx), "init TX"))
diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 7dad8556a722..a385464cfaf8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -334,7 +334,7 @@ static void print_tests(void)
 int main(int argc, char **argv)
 {
 	const size_t total_tests = ARRAY_SIZE(tests) + ARRAY_SIZE(ci_skip_tests);
-	u32 cache_line_size, max_frags, umem_tailroom;
+	u32 max_frags;
 	struct pkt_stream *rx_pkt_stream_default;
 	struct pkt_stream *tx_pkt_stream_default;
 	struct ifobject *ifobj_tx, *ifobj_rx;
@@ -356,12 +356,6 @@ int main(int argc, char **argv)
 
 	setlocale(LC_ALL, "");
 
-	cache_line_size = read_procfs_val(SMP_CACHE_BYTES_PATH);
-	if (!cache_line_size) {
-		ksft_print_msg("Can't get SMP_CACHE_BYTES from system, using default (64)\n");
-		cache_line_size = 64;
-	}
-
 	max_frags = read_procfs_val(MAX_SKB_FRAGS_PATH);
 	if (!max_frags) {
 		ksft_print_msg("Can't get MAX_SKB_FRAGS from system, using default (17)\n");
@@ -370,13 +364,6 @@ int main(int argc, char **argv)
 	ifobj_tx->max_skb_frags = max_frags;
 	ifobj_rx->max_skb_frags = max_frags;
 
-	/* 48 bytes is a part of skb_shared_info w/o frags array;
-	 * 16 bytes is sizeof(skb_frag_t)
-	 */
-	umem_tailroom = ALIGN(48 + (max_frags * 16), cache_line_size);
-	ifobj_tx->umem_tailroom = umem_tailroom;
-	ifobj_rx->umem_tailroom = umem_tailroom;
-
 	parse_command_line(ifobj_tx, ifobj_rx, argc, argv);
 
 	if (opt_print_tests) {
-- 
2.56.1

