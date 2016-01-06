From: Brandeburg, Jesse <jesse.brandeburg@intel.com>
Date: Wed, 6 Jan 2016 02:25:06 +0000
Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not
	sleep in netdev_ops
In-Reply-To: <D2CB76B6BECC8945A41B7D7368481CE60109E914@ORSMSX111.amr.corp.intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
 <20160104120205.00000b51@intel.com>
 <D2CB76B6BECC8945A41B7D7368481CE60109E914@ORSMSX111.amr.corp.intel.com>
Message-ID: <253CF818969A9240AB2054BF91F2C2BC376DA301@ORSMSX114.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> There was another commit on 3-Dec that reverted/modified the i40e_set_mac(). 
> 3-Dec: https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/?h=dev-queue&id=ea02e90b4b49782462d06a425e05c776909fbae4

That patch you reference is introducing a (likely) merge resolution error, and re-introducing the bug that the original patch fixed, this is just an artifact of the order of things applied to the kernel, that we need to fix with the right code upstream.



