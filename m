From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Wed, 2 Sep 2015 02:03:56 +0000
Subject: [Intel-wired-lan] [PATCH rc2 1/2] fm10k: create "correct"
 header	for the remote end on connect
In-Reply-To: <1435334047-6404-1-git-send-email-jacob.e.keller@intel.com>
References: <1435334047-6404-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E271B53E8@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Friday, June 26, 2015 8:54 AM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH rc2 1/2] fm10k: create "correct" header for the remote end on connect

When we connect to the mailbox, we insert a fake disconnect header so that the code does not see an invalid header and thus instantly error every time we bring up the mailbox. However, we incorrectly record the tail and head from the local perspective. Since the remote end shouldn't have anything for us, add a "create_fake_disconnect_hdr" function which inverts the TAIL and HEAD fields. This enables us to connect without any errors of either TAIL or HEAD incorrectness, and prevents creating extraneous error messages. This is necessary now since mbx_reset_work does not actually reset the Tx FIFO head and tail pointers, thus head and tail might not be equivalent on a reconnect.

-rc2
* Remove duplicate reference

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Tested-By: Krishneil Singh <krishneil.k.singh@intel.com>

_______________________________________________
Intel-wired-lan mailing list
Intel-wired-lan at lists.osuosl.org
http://lists.osuosl.org/mailman/listinfo/intel-wired-lan
