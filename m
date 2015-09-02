From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:10:53 +0000
Subject: [Intel-wired-lan] [PATCH rc3] fm10k: use
 dma_set_mask_and_coherent	in fm10k_probe
In-Reply-To: <1434487303-4833-1-git-send-email-jacob.e.keller@intel.com>
References: <1434487303-4833-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B54CF@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Tuesday, June 16, 2015 1:42 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH rc3] fm10k: use dma_set_mask_and_coherent in fm10k_probe

This patch cleans up the use of dma_get_required_mask and uses the simpler dma_set_mask_and_coherent function instead of doing these as separate steps.

I removed the dma_get_required_mask call because based on some minimal testing it appears that either (a) we're not doing the right thing with the call or (b) we don't need it anyways. If the value returned is <48bits, we'll end up trying with 48 bits anyways. If it's over 48bits, fm10k can't support that anyways, and we should try 48bits. If 48bits fails, we'll fallback to 32bits. This cleans up some very funky code.

- rc2
* add back goto err_dma

- rc3
* use %d for error code printf

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
