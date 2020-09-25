From: David Miller <davem@davemloft.net>
Date: Fri, 25 Sep 2020 16:31:15 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v3 0/9] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
References: <20200925222445.74531-1-jesse.brandeburg@gmail.com>
Message-ID: <20200925.163115.1983585891277676668.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Date: Fri, 25 Sep 2020 15:24:36 -0700

> From: Jesse Brandeburg <jesse.brandeburg@intel.com>
> 
> The Goal: move to W=1 being default for drivers/net/ethernet, and
> then use automation to catch more code issues (warnings) being
> introduced.
> The status: Getting much closer but not quite done for all
> architectures.
> 
> After applying the patches below, the drivers/net/ethernet
> directory can be built as modules with W=1 with no warnings (so
> far on x64_64 arch only!). As Jakub pointed out, there is much
> more work to do to clean up C=1, but that will be another series
> of changes.
> 
> This series removes 1,247 warnings and hopefully allows the
> ethernet directory to move forward from here without more
> warnings being added. There is only one objtool warning now.
> 
> This version drops one of the Intel patches, as I couldn't
> reproduce the original issue to document the warning.
> 
> Some of these patches are already sent and tested on Intel Wired
> Lan, but the rest of the series titled drivers/net/ethernet
> affects other drivers. The changes are all pretty
> straightforward.
> 
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Reviewed-by: Saeed Mahameed <saeed@kernel.org>

Series applied, but that sh_eth.c thing gives me major cancer.

There has to be a better way to describe that table and I recently
pushed back on someone trying to stick a CFLAGS modification into
that subdirectory's Makefile to fix it.

That strategy of initializing a table might be convenient, but with it
you can't look at each table and see which registers DO NOT exist for
each chip which is just as interesting as which ones do exist.

But the main point is that the warning should be avoided in a cleaner
way somehow.  And by doing so we'll likely make the tables more
expressive.

