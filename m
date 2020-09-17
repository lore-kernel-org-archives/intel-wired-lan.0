From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 17 Sep 2020 21:11:32 +0000
Subject: [Intel-wired-lan] [PATCH] i40e: Fix use of uninitialized
 variable
In-Reply-To: <20200916204943.41017-1-alex.dewar90@gmail.com>
References: <20200916204943.41017-1-alex.dewar90@gmail.com>
Message-ID: <6aaa242f49ccd3824fe4cbb38bada7ccf9add979.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2020-09-16 at 21:49 +0100, Alex Dewar wrote:
> In i40e_clean_rx_irq_zc(), the variable failure is only set when a
> condition is met, but then its value is used unconditionally. Fix
> this.
> 
> Addresses-Coverity: 1496986 ("Uninitialized value")
> Fixes: 8cbf74149903 ("i40e, xsk: move buffer allocation out of the Rx
> processing loop")
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>

Thanks for the patch Alex, however, Dan Carpenter has already submitted
a patch for the same reported issue: 
https://patchwork.ozlabs.org/project/intel-wired-lan/patch/20200916143228.GA764370 at mwanda/

Thanks,
Tony
