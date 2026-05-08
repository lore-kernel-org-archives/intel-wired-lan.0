Return-Path: <intel-wired-lan-bounces@osuosl.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D629ECD3445
	for <intel-wired-lan@archiver.kernel.org>; Fri,  8 May 2026 18:51:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8DA3F847ED;
	Fri,  8 May 2026 18:51:51 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id jvK1TsRQpxKP; Fri,  8 May 2026 18:51:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=intel-wired-lan-bounces@osuosl.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8765F847EB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=osuosl.org;
	s=default; t=1778266309;
	bh=FgCgVXyKFsKz2Q4i/AaoeOgRoIURZdweYmSmTtUvZ1Y=;
	h=To:Cc:Date:Subject:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:From:Reply-To:From;
	b=VDwN3nssistDWwWD7JRsZON7ZtW6g7KzXY9Gh8WgGle1U22Asrtjv9BmOkQXnYyl0
	 wOoBZ6/rOzUkFZYZLRyN0jTHdhAJBUDYSryhyY0dJdQxmmysm3v2CTO4UHaweIfpst
	 fIFug1+Hcdhp45sZp1teILZeHCmVIr7Lf5UYmBhCsLA/6QSazbUoIqHoq1klaNFAL3
	 nvXgFl/DECgC1agnmXUMJ8qSSib1c8dUxhajbax4c8fNKfXr3tY9PHjCfmHhi4aDVc
	 5NdB/blEwPYcWfY2zPGZwFbpQ9tdvo3RC1nDtM9waYuWBLvIfU9pqp1FcdJy4S8GZ3
	 w3mEEv4JrtemQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8765F847EB;
	Fri,  8 May 2026 18:51:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF37B272
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 18:51:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B51FB41ECD
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 18:51:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vSWHIhq8xNHU for <intel-wired-lan@lists.osuosl.org>;
 Fri,  8 May 2026 18:51:47 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=205.220.177.32;
 helo=mx0b-00069f02.pphosted.com; envelope-from=alok.a.tiwari@oracle.com;
 receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CDEEF41ECC
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CDEEF41ECC
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com
 [205.220.177.32])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CDEEF41ECC
 for <intel-wired-lan@lists.osuosl.org>; Fri,  8 May 2026 18:51:46 +0000 (UTC)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 648FcotB1859383; Fri, 8 May 2026 18:51:31 GMT
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9dh3awk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 18:51:31 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7)
 with ESMTP id 648IpMNf025260; Fri, 8 May 2026 18:51:30 GMT
Received: from pps.reinject (localhost [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4dx5825hdq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 08 May 2026 18:51:30 +0000 (GMT)
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 648IpTkV026972;
 Fri, 8 May 2026 18:51:29 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com
 [10.129.136.47])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id
 4dx5825hc3-1; Fri, 08 May 2026 18:51:29 +0000 (GMT)
To: aleksander.lobakin@intel.com, jacob.e.keller@intel.com,
 milena.olech@intel.com, willemb@google.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwari@oracle.com
Date: Fri,  8 May 2026 11:46:17 -0700
Message-ID: <20260508185123.2422760-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 malwarescore=0 adultscore=0 phishscore=0
 suspectscore=0 bulkscore=0
 spamscore=0 mlxscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605080188
X-Proofpoint-GUID: yQjVvz1kjyO628iO2juuJbSNTWxbUDno
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDE4OCBTYWx0ZWRfXwg14xMiHWRaV
 x+9ZRwO9twGE01Yqzp/oam5CoNm/dN1obE9jrYKAi0AHaOKdr3bFrd2pZs7U6bybiw+LVj6gVPh
 WAybDHWWW5zUI7Zi2EfK6IVW2r9KZYIO+aGe7KpYJELwnDjg0OJV2PYNhNfje7N2g+MjWUCgQGv
 rj9DQ4rZBd6NHn1KKhipnEmVENqkXl2R78MN+x1j6cUzq2b9sZ1E/rd+jHRXCqawkTZK12IUZrm
 ZJp6JNUE3BQOByFMaQxjN933GLF9PI23Q8SJo51kSzKacN5ckedEvZ62KcKiFSjrKZ+2Waj7UUm
 MIVdzzdR3m3qckv3YOk/p3oQ/I727c8hJW2m1knYBd5VPpzPYZYJJOv5mz6lqy+k2hGk/uWcdgD
 EegQBMD6Z2SlxUGeZueTzZP3iv1zqvbRv9ZpTBy6yGawdXJj4XaYjPfnLlzZQU4L4IQZ8HC9SEm
 f0kQBn6651mk6jH7CpRcdpjOVM+siPaDC3UfnSvA=
X-Proofpoint-ORIG-GUID: yQjVvz1kjyO628iO2juuJbSNTWxbUDno
X-Authority-Analysis: v=2.4 cv=HZckiCE8 c=1 sm=1 tr=0 ts=69fe30b3 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=x4eqshVgHu-cdnggieHk:22 a=yPCof4ZbAAAA:8 a=havJbWvXqL2eL2CLIZYA:9
 a=5yU3S35YU4bGjq-dph-N:22 cc=ntf awl=host:13839
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=corp-2025-04-25; bh=FgCgVXyKFsKz2Q4i/AaoeOgRoIURZ
 dweYmSmTtUvZ1Y=; b=UKY0sp2LN2rn0/S7mkMSELbAdk/eAktF+CQps+PWbx8Kj
 3vnFO9jN843Tq/z4DL18tKJkmzbbjP1EtoUAMUmux79IKkJkNb0PCixMZ9GVP+CV
 XzFN7QqK9JXLYx0OCZmvNDFaL+MLKLgjHif1IzL4dq4+6eNYLtaR5kmxmHj3kVxd
 xSyqEdaphxa1nmn2gDmPiqstagZ61H9NEhdLF0NNDEswsM2N/r4lbWYPF2em2Kqi
 bUdNF8P5Eulx+RIohfjGjL5Hrz3nANxOJwyRFl8sWLFu7/HqAoLxo3NV9JuFh0DP
 42aUWrlm9nln7w/D5f45OTPGKXxRLFA3lly1/o81A==
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=oracle.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key,
 unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256
 header.s=corp-2025-04-25 header.b=UKY0sp2L
Subject: [Intel-wired-lan] [PATCH net] idpf: fix mailbox capability for set
 device clock time
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
From: Alok Tiwari via Intel-wired-lan <intel-wired-lan@osuosl.org>
Reply-To: Alok Tiwari <alok.a.tiwari@oracle.com>
Errors-To: intel-wired-lan-bounces@osuosl.org
Sender: "Intel-wired-lan" <intel-wired-lan-bounces@osuosl.org>

The current code incorrectly uses VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME
for both direct and mailbox capabilities, causing mailbox-only support
to be ignored and potentially reporting IDPF_PTP_NONE.

Fixes: d5dba8f7206da ("idpf: add PTP clock configuration")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
I did not hit a runtime failure directly, but this logic is inconsistent
with the capability definitions.
---
 drivers/net/ethernet/intel/idpf/idpf_ptp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_ptp.c b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
index eec91c4f0a75..3295e2f1db9c 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_ptp.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_ptp.c
@@ -51,7 +51,7 @@ void idpf_ptp_get_features_access(const struct idpf_adapter *adapter)
 
 	/* Set the device clock time */
 	direct = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
-	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME;
+	mailbox = VIRTCHNL2_CAP_PTP_SET_DEVICE_CLK_TIME_MB;
 	ptp->set_dev_clk_time_access = idpf_ptp_get_access(adapter,
 							   direct,
 							   mailbox);
-- 
2.50.1

