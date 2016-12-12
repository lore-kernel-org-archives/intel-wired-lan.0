From: Singh, Krishneil K <krishneil.k.singh@intel.com>
Date: Mon, 12 Dec 2016 17:22:22 +0000
Subject: [Intel-wired-lan] [PATCH] fm10k: Limit dma sync of RX buffers
 to	actual packet size
In-Reply-To: <20161103230941.27152-1-jacob.e.keller@intel.com>
References: <20161103230941.27152-1-jacob.e.keller@intel.com>
Message-ID: <EF50CC0C76A53A44BAD798C58E0A157E490F52A9@ORSMSX103.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


-----Original Message-----
From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On Behalf Of Jacob Keller
Sent: Thursday, November 3, 2016 4:10 PM
To: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>
Subject: [Intel-wired-lan] [PATCH] fm10k: Limit dma sync of RX buffers to actual packet size

From: "Peterson, Scott D" <scott.d.peterson@intel.com>

On packet RX, we perform a dma sync for cpu before passing the packet up.  Here we limit that sync to the actual length of the incoming packet, rather than always syncing the entire buffer.

Testing Hints:
Verify traffic is still passed correctly with the same or better performance as before this patch

Signed-off-by: Scott Peterson <scott.d.peterson@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---

Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>

