From: Keller, Jacob E <jacob.e.keller@intel.com>
Date: Fri, 4 Mar 2016 23:38:47 +0000
Subject: [Intel-wired-lan] [PATCH v6 0/2] fix ethtool statistics patches
In-Reply-To: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
References: <1457134668-19142-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1457134727.7791.4.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-03-04 at 15:37 -0800, Jacob Keller wrote:
> This series fixes the ethtool patches on Jeff's next-queue. First, I
> fixed a bug in the fm10k ethtool stat helpers which had assumed the
> allocated memory was already zeroed. The new code assumes it is not,
> and
> always rights 0s. In addition, I fixed Bruce's comment about the
> newline. Since I had to change the first patch, I rebased them both
> against the top of Jeff's queue and merged some of the code. The
> first
> patch in this series now handles the per-queue stats, while the
> second
> patch does the work to remove the incorrect support for
> debug-statistics.
> 
> The first patch is a direct replacement for 1256b40cb7b4 ("fm10k: add
> helper functions to set strings and data for ethtool stats", 2016-03-
> 04)
> 
> The second patch is a direct replacement for 2d6c14d75442 ("fm10k:
> cleanup fm10k stats and remove debug-statistics", 2016-03-04)

This series fixes Krishniel's issue, and resolves the extra blank line.
It also is a bit easier to follow each patch, since they are more
clearly separated. Both patches listed above need to be dropped and
then this series applied in order.

Thanks,
Jake
