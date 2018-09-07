From: David Miller <davem@davemloft.net>
Date: Fri, 07 Sep 2018 15:02:02 -0700 (PDT)
Subject: [Intel-wired-lan] [net-next] i40e(vf): remove
 i40e_ethtool_stats.h header file
In-Reply-To: <20180907215544.5957-1-jacob.e.keller@intel.com>
References: <20180907215544.5957-1-jacob.e.keller@intel.com>
Message-ID: <20180907.150202.635126554624052715.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Jacob Keller <jacob.e.keller@intel.com>
Date: Fri,  7 Sep 2018 14:55:44 -0700

> Essentially reverts commit 8fd75c58a09a ("i40e: move ethtool
> stats boiler plate code to i40e_ethtool_stats.h", 2018-08-30), and
> additionally moves the similar code in i40evf into i40evf_ethtool.c.
> 
> The code was intially moved from i40e_ethtool.c into i40e_ethtool_stats.h
> as a way of better logically organizing the code. This has two problems.
> First, we can't have an inline function with variadic arguments on all
> platforms. Second, it gave the appearance that we had plans to share
> code between the i40e and i40evf drivers, due to having a near copy of
> the contents in the i40evf/i40e_ethtool_stats.h file.
> 
> Patches which actually attempt to combine or share code between the i40e
> and i40evf drivers have not materialized, and are likely a ways off.
> 
> Rather than fixing the one function which causes build issues, just move
> this code back into the i40e_ethtool.c and i40evf_ethtool.c files. Note
> that we also change these functions back from static inlines to just
> statics, since they're no longer in a header file.
> 
> We can revisit this if/when work is done to actually attempt to share
> code between drivers. Alternatively, this stats code could be made more
> generic so that it can be shared across drivers as part of ethtool
> kernel work.
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Applied and after the build checks out will be pushed to net-next.

Thanks.
