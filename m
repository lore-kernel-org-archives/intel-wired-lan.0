From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:17:48 +0000
Subject: [Intel-wired-lan] [PATCH v3] fm10k: drop transmitted messages
 in Tx	FIFO as part of reset_work
In-Reply-To: <1435268623-17648-1-git-send-email-jacob.e.keller@intel.com>
References: <1435268623-17648-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B55DE@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, June 25, 2015 2:44 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH v3] fm10k: drop transmitted messages in Tx FIFO as part of reset_work

This patch fixes a corner case issue with the PF/VF mailbox code.
Currently, fm10k_mbx_reset_work clears various state about the mailbox.
However, it does not clear the Tx FIFO head/tail pointers. We can't simply clear these pointers as we unintentionally drop untransmitted messages without error.

Doing nothing results in a possible phantom re-transmission of messages, since we leave tx.head and tx.tail intact, but clear the tx_pulled and tail_len values. This means that the PF could continuously re-send a message which triggers a reset in the VF. Upon reset, the VF will re-receive the same message after a reconnect.

If we reset the tx.head and tx.tail pointers completely, we end up dropping some messages that were pending before connect. This results in missing LPORT_MSG_READY bits, and VFs will end up reporting no link.

However, we can resolve both issues by simply incrementing head to account for the already transmitted messages, before we reset tx_pulled.
We do this via the same logic as fm10k_mbx_head_pull.

We account for the tail_len which includes all data not yet transmitted, once we account for the acked data which means re-reading the HEAD variable from the message header. Then, we drop messages until we've dropped more than the new tx_pulled value. At this point, resetting tail_len and tx_pulled, but not tx.head and tx.tail will result in prevention of the phantom message. It also prevents us from dropping untransmitted messages upon attempting to Tx into a connect or disconnect header.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
