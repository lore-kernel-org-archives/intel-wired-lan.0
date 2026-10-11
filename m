Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCEF6CA9EBD
	for <intel-wired-lan@archiver.kernel.org>; Sun, 11 Oct 2026 11:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7124B4051C;
	Sun, 11 Oct 2026 11:37:10 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id NOzcEhvtNnm8; Sun, 11 Oct 2026 11:37:10 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org C717C405B6
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791718629;
	b=JARfg7MZ9xtPJMxHADa6IajzrDO+n6VGLPNnXrq2SFBU1gVRxRD8lEt3QVaM2O30e5Ze
	 q00I0MU8g4gtdQmQCkU8b3+5MAylYCMpHHj1mcKR3iOpGX583TSMYoc5WEQVH2CtXHCsa
	 ojhK+rDvwWh5GD2z6bolfTkiSAX4ia9ONqgqmgEbxCJeWByeBFKhXdtWF3jDQ4Eq+BVJR
	 zxLqoC+NGqPkEPE5Kg4/ftPyNqwB/nrHyPTS3kwMjrFIORW8bLEH51R9ZrMYwiI/mExeh
	 S+bPZfQMz+1b677r2aovhLw81IxHV2S918Xk7vFBbYaqjlpiv/zYlJjcSHGrgdA+AKA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791718629;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:Received:Received:Received:Received:From:To:
	 Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=g6N78M5WVxE9MlZLLXJgM6SbU5sYANtzHa2a12DeunY=;
	b=rMMVeWUwX/p9OIseniAp/eHG8cDPkEYj7hdAwaUtbPF3cjrTOEUeC8t+iq50ccBgrh4u
	 XgytNq4VF3Rwxnwvm9GuVdN4tsU8eldePmawkRS7Vt3J85vEsiGhTGmSW0iDWG/XCgD+f
	 G1tx98vZJT8RCX/4FTGxt302pIGxlVSkxvVX2jHMyeWrJQXNlglohT5CSonSlbsqPTngM
	 Ka1bGmgUYkPBoUHfMsLwHThMFVhWux6/O1RUOpeDgwyZPvFMiaRn5S59+kiPtDV+5CwkO
	 6bm9GpuVUFypQZ8R0vTEVV16rg/6IJjh+JLdVl4IU4brqIkeYRTJEd+5QCuQdUiypYw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1791718629;
	bh=g6N78M5WVxE9MlZLLXJgM6SbU5sYANtzHa2a12DeunY=;
	h=From:To:Cc:Subject:Date:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From;
	b=Fc1tqzO6bPbRia4J1KMlgt8AkX/0TyfEgBd9pvEZg0Y08ycn8PqnoHZ9M+JgSHlxe
	 xySbY/BSIcTIvUvp2jWNG+EMDRhpsjrMA6WgmhNQfXVXGFRStDs7PO5/9r3+69ut9Q
	 tucjdmawcnI4DNOyUfjpqTQjzP/0UlW9dd66hEj478PcN6VKht3LSjWeTuPa9MZHFJ
	 sc2YYikXGNSFv8iyiA05SputaxPSIG2STCb4j1gLtGUMb6Qp1biZAZcmUslig0vd0O
	 U/FN2N/pBda3hl4Rro5CMQFT3n/3p5cFqJdzwu21QoZ+D6KZ6z9dFsEnnGyW624QEv
	 7hJD4j/C3vm7Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C717C405B6;
	Sun, 11 Oct 2026 11:37:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id EAB9E1DE
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 11:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E86C140042
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 11:37:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RQ0hYftJoDAH for <intel-wired-lan@lists.osuosl.org>;
 Sun, 11 Oct 2026 11:37:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 7ECA64002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip=205.220.177.32
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791718628;
 b=tO/62EuenCZrvjMYzG1Rf+1rjgzO+4IUDqk6nUUEZF7n+Qi4NIpVIo8XRXSgUBcc3mq8
 iJqhKL9pgqdO788a1X1t0ayZ/Jr1f0tWGN8i3ou7alM+s9j80gmnhHb7Dl4HgdrZ3wTBS
 X/VIceg9KrysNa332bPjD0e7jzPSdqCZUcsrasHKOfhwSnCyw2RIHb8xpFIm1BIbvw/wr
 +oV/TtqxlOKgtUpENythliSWWMrb7VBJssS4NZBuXl4ow9ZFeoQeq0V8PM05PzqZQ9xYh
 Xvejk9CL4qSYGUzpNWFyKgur37FjqjOy5cpDg4EvoP/OzL3XZkfHjvqVXJpeBa+B0Yw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791718628;
 h=Received-SPF:Received:DKIM-Signature:Received:Received:Received:
 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
 MIME-Version:Content-Transfer-Encoding:X-Proofpoint-Virus-Version:
 X-Proofpoint-Spam-Details:X-Authority-Analysis:X-Proofpoint-GUID:
 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
 X-Proofpoint-Spam-Details-Enc;
 bh=g6N78M5WVxE9MlZLLXJgM6SbU5sYANtzHa2a12DeunY=;
 b=cHK008pXgY0TVHEhLC3WuA7QbZcvaRYZJQgkPwivppiVRvyOGMw4lhtnJ1gv9MA8Pebi
 IAZi5wc3orEje8ohP5I/BEGnHZXpAfp3HCy1XaD1IQAiYSQ46McRr0VG/Yv4xUAO9aCW3
 VHAe8d5txD6O2eiWu8+rY/QQr+QwFVlj/+cU1IYm9eA/FbGevtfQxlpaGrl4epTKX1Mne
 iWHs9le8oNEM71V2fJGOKHxN2XZ6H/ehbS/PadB/UuOv01zDh5JB51oRe7n+Yw4tDyMJS
 JxuvC6YoB7J1g+WER3125LURfexximvbR++gRYtNwyJ4MYs9XKmsLTI7wAOo8nngUfQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=oracle.com;
 dkim=pass header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2025-04-25 header.b=nRnoT+7O; 
 arc=none smtp.remote-ip=205.220.177.32
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=alok.a.tiwari@oracle.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2025-04-25 header.b=nRnoT+7O
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 7ECA64002B
 for <intel-wired-lan@lists.osuosl.org>; Sun, 11 Oct 2026 11:37:06 +0000 (UTC)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69BBQBTV3526241; Sun, 11 Oct 2026 11:36:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=g6N78M5WVxE9MlZLLXJgM6SbU5sYA
 NtzHa2a12DeunY=; b=nRnoT+7OwFHNlANTKcQb7JBFigItymSeJG1u0CmUTPw4z
 eoamBoKSF1YivMti6zhrv8CBv5YrE4OJPUCfNdut/rK+8wFc7FulLSb5iBr7yNZL
 5TQZVhsUWZX07VhKrEuYaz3M2cYhtqjF7xh9sbtgoL/EUvnDkH4kRLnOUzGoWKYl
 hvs/Iyi9o0/LknICShmwjlxy18JP68UisxHCl0tr1S/VaHYe2lBv73inlv1dSK0B
 RLtbjzK+RK+nFbzovYISw/GDy6LPjD/xxN+D5yyhCKgGpm6vJ8V9F7HZvh3PyFg7
 wnz+FZMJaHWOIjJmf84Ja3xgdZ8ham5QZQyj9awKg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4h7demgye9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Oct 2026 11:36:52 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 69BBamEq039610; Sun, 11 Oct 2026 11:36:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4h7btkyxbv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 11 Oct 2026 11:36:52 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 69BBapvO040050;
 Sun, 11 Oct 2026 11:36:51 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4h7btkyx0f-1; Sun, 11 Oct 2026 11:36:51 +0000 (GMT)
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: richardcochran@gmail.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ice: correct PTP register access debug messages
Date: Sun, 11 Oct 2026 04:35:36 -0700
Message-ID: <20261011113545.16718-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-11_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 lowpriorityscore=0 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0
 phishscore=0 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2610020000 definitions=main-2610110046
X-Authority-Analysis: v=2.4 cv=CoEq4X4D c=1 sm=1 tr=0 ts=6acb74d4 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=3I1J8UUJPc9JN9BFgKH3:22 a=yPCof4ZbAAAA:8 a=KXD2W1d5SiN8HkZNh0UA:9
 a=5yU3S35YU4bGjq-dph-N:22 a=Bho9c0fBagfJEIQBS7DQ:22 cc=ntf awl=host:13537
X-Proofpoint-GUID: AR-OUwSS8V5ZlzLCFDsxowOX2DUKEP24
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDExMDA0NSBTYWx0ZWRfXwZFd+dbUJ3GD
 zMUk64YOHBKuY+rCasJ7J4zPMsbXfUfsN949EoXtb5sIzcBfpSB7A/ZKU1dluKPyHue1443yi84
 Rx7oTXHY1TDK/Sh8rdUiqaK15IYlRoVmtkJG13NXEdDjpqy6Q4sc
X-Proofpoint-ORIG-GUID: AR-OUwSS8V5ZlzLCFDsxowOX2DUKEP24
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDExMDA0NSBTYWx0ZWRfX8JVZZd76zAqf
 tFyW0VBtse1tjaG0Ql0M5CzYAasal8cUSHJXc4MQjfHOM55THzyubQWXZ6/QLbW7kvaMksCTsF+
 uFTgJhtUAfx8dpV97GlsJoJFPP/TP3u7w0h3E8s64jwqhA+CFnHELXYNAALtfzMZBFH3UxYsgiW
 SjWdGHTlgWXb1CFw/EHdZxUHzLy63M4tV8klZEq7R4q9yerQfiYw8l4ZXfOOnVYtcPUjZkRCupI
 J/KcJbXXdNQvAR1MIxVMkFiGxZOBZC6D5sQwHAOlxyps8VNrzQ6iGDpgzVVhUhBCpvrJVcIJ693
 Fc0TYqeMD3jzXXJu99rtFrf7kyvTcV3Z1Bdr6u0Alv6+eToySqHQbIs3mmH5zlN1+sb579Jfy0v
 zD4IDR8kIU22i2Ws5DwocMewEKmf8r5YERsj9FBYTToSiq35ZsCdWkVeW4CmP6xk9gdIbZB29Gs
 XV5ZtYRbOQ5tfSMiTPxoscU+fNM4+vEhm8qkK+S8=
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

Report a write failure rather than a read failure when updating
PHY_VENDOR_TXLANE_THRESH.

Fix newline placement in PHY register read and threshold write failure
messages. No functional changes.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
index 3a41c711e751..289e0b3ef6ae 100644
--- a/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
+++ b/drivers/net/ethernet/intel/ice/ice_ptp_hw.c
@@ -1529,7 +1529,7 @@ static int ice_phy_cfg_parpcs_eth56g(struct ice_hw *hw, u8 port)
 	err = ice_write_xpcs_reg_eth56g(hw, port, PHY_VENDOR_TXLANE_THRESH,
 					ICE_ETH56G_NOMINAL_THRESH4);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read VENDOR_TXLANE_THRESH, status: %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to write VENDOR_TXLANE_THRESH, status: %d",
 			  err);
 		return err;
 	}
@@ -2589,14 +2589,14 @@ ice_read_64b_phy_reg_e82x(struct ice_hw *hw, u8 port, u16 low_addr, u64 *val)
 
 	err = ice_read_phy_reg_e82x(hw, port, low_addr, &low);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low register 0x%08x\n, err %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read from low register 0x%08x, err %d\n",
 			  low_addr, err);
 		return err;
 	}
 
 	err = ice_read_phy_reg_e82x(hw, port, high_addr, &high);
 	if (err) {
-		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high register 0x%08x\n, err %d",
+		ice_debug(hw, ICE_DBG_PTP, "Failed to read from high register 0x%08x, err %d\n",
 			  high_addr, err);
 		return err;
 	}
-- 
2.52.0

