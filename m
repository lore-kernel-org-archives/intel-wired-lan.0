From: Kavalur, Deepthi <deepthi.kavalur@intel.com>
Date: Wed, 6 Jan 2016 01:39:58 +0000
Subject: [Intel-wired-lan] [next PATCH S26 06/12] i40e: fix: do not
	sleep in netdev_ops
In-Reply-To: <20160104120205.00000b51@intel.com>
References: <1451932392-15538-1-git-send-email-deepthi.kavalur@intel.com>
 <1451932392-15538-7-git-send-email-deepthi.kavalur@intel.com>
 <20160104120205.00000b51@intel.com>
Message-ID: <D2CB76B6BECC8945A41B7D7368481CE60109E914@ORSMSX111.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

There was another commit on 3-Dec that reverted/modified the i40e_set_mac(). 
3-Dec: https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/?h=dev-queue&id=ea02e90b4b49782462d06a425e05c776909fbae4

Only the missing part of the below commit is getting added in this patch.
2-Dec: https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git/commit/drivers/net/ethernet/intel/i40e?id=0e4425ed641f3eef67c892bc541949cd745a9ba9.

