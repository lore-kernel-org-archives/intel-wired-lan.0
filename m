From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 15 Apr 2016 22:20:53 +0000
Subject: [Intel-wired-lan] [PATCH v1 1/4] fm10k: fix possible null
 pointer deref after kcalloc
In-Reply-To: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
References: <1460042483-16169-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1460758853.13811.8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2016-04-07 at 08:21 -0700, Jacob Keller wrote:
> When writing a new default redirection table, we needed to populate
> a new RSS table using ethtool_rxfh_indir_default. We populated this
> table into a region of memory allocated using kcalloc, but never
> checked
> this for NULL. Fix this by moving the default table generation into
> fm10k_write_reta. If this function is passed a table, use it.
> Otherwise,
> generate the default table using ethtool_rxfh_indir_default, 4 at at
> time.
> 
> Fixes: 0ea7fae44094 ("fm10k: use ethtool_rxfh_indir_default for
> default redirection table", 2016-02-16)
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> ---


Jeff,

This patch has an issue I will be sending a reworked version, so please
drop this from the queue and don't submit it to net-next yet.

Thanks Krishniel for finding the issue!

Thanks,
Jake
