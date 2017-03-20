From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Mon, 20 Mar 2017 23:33:06 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: fix memcpy with swapped
 arguments
In-Reply-To: <20170320144627.11524-1-colin.king@canonical.com>
References: <20170320144627.11524-1-colin.king@canonical.com>
Message-ID: <02874ECE860811409154E81DA85FBB5857DAF748@ORSMSX115.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at lists.osuosl.org] On
> Behalf Of Colin King
> Sent: Monday, March 20, 2017 7:46 AM
> To: Kirsher, Jeffrey T <jeffrey.t.kirsher@intel.com>; intel-wired-
> lan at lists.osuosl.org; netdev at vger.kernel.org
> Cc: kernel-janitors at vger.kernel.org; linux-kernel at vger.kernel.org
> Subject: [Intel-wired-lan] [PATCH] i40e: fix memcpy with swapped arguments
> 
> From: Colin Ian King <colin.king@canonical.com>

Hi there,

> 
> The current code copies an uninitialized params into
> cdev->lan_info.params and then passes the uninitialized params
> to the call cdev->client->ops->l2_param_change.  I believe the
> order of the source and destination in the memcpy is the wrong
> way around and should be swapped.
> 

So you are correct that params is uninitialized. However, the fix here is not correct. Somehow we dropped the code for initializing the parameters.

See commit d7ce6422d6e6 ("i40e: don't check params until after checking for client instance", 2017-02-09) It looks like the commit itself was malformed when applied upstream, and a later commit which should have preserved the changes 3140aa9a78c9 ("i40e: KISS the client interface", 2017-03-14) accidentally dropped them.

I'll provide a patch to get this back into the correct state.

Thanks for catching this.

Regards,
Jake
