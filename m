From: Schmitt, Phillip J <phillip.j.schmitt@intel.com>
Date: Mon, 21 Dec 2015 21:29:05 +0000
Subject: [Intel-wired-lan] [PATCH] ixgbevf: Fix handling of napi budget
 when	multiple queues are enabled per vector
In-Reply-To: <1446225390-19140-1-git-send-email-william@gandi.net>
References: <1446225390-19140-1-git-send-email-william@gandi.net>
Message-ID: <305E19FFAC908240AB6DEBD1E2D8C1E180CFA411@ORSMSX108.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>



> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of William Dauchy
> Sent: Friday, October 30, 2015 10:16 AM
> To: davem at davemloft.net
> Cc: William Dauchy; netdev at vger.kernel.org; aduyck at mirantis.com; intel-
> wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH] ixgbevf: Fix handling of napi budget when
> multiple queues are enabled per vector
> 
> This is the same patch as for ixgbe but applied differently according to busy
> polling.
> see commit "ixgbe: Fix handling of napi budget when multiple queues are
> enabled per vector"
> 
> Signed-off-by: William Dauchy <william@gandi.net>

Tested-by: Phil Schmitt <phillip.j.schmitt@intel.com>
