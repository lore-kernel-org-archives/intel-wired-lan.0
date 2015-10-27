From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Tue, 27 Oct 2015 17:20:09 +0000
Subject: [Intel-wired-lan] [next-queue v5 15/17] fm10k: change default
 Tx	ITR to 25usec
In-Reply-To: <1445018231-3196-15-git-send-email-jacob.e.keller@intel.com>
References: <1445018231-3196-1-git-send-email-jacob.e.keller@intel.com>
 <1445018231-3196-15-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E2722142C@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, October 16, 2015 10:57 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [next-queue v5 15/17] fm10k: change default Tx ITR to 25usec

The current default ITR for Tx is overly restrictive. Using a simple netperf TCP_STREAM test, we top out at about 10Gb/s for a single thread when running using 1500 byte frames. By reducing the ITR value to 25usec (up to 40K interrupts a second from 10K), we are able to achieve 36Gb/s for a single thread TCP stream test.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-by: Krishneil Singh <Krishneil.k.singh@intel.com>



