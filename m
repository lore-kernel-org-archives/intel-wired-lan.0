From: Nguyen, Anthony L <anthony.l.nguyen@intel.com>
Date: Thu, 9 Sep 2021 20:44:11 +0000
Subject: [Intel-wired-lan] [PATCH net v2] iavf: Fix refreshing iavf
 adapter stats on ethtool request
In-Reply-To: <20210907125343.258489-1-jedrzej.jagielski@intel.com>
References: <20210907125343.258489-1-jedrzej.jagielski@intel.com>
Message-ID: <dc541e9e41734773c8f79200e180c6dd99eeebc8.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2021-09-07 at 12:53 +0000, Jedrzej Jagielski wrote:
> Currently iavf adapter statistics are refreshed only in a
> watchdog task, triggered approximately every two seconds,
> which causes some ethtool requests to return outdated values.
> 
> Add explicit statistics refresh when requested by ethtool -S.

I responded to the v1 on accident, please see the comments on that one.

> Fixes: b476b0030e61 ("iavf: Move commands processing to the separate
> function")
> Signed-off-by: Jan Sokolowski <jan.sokolowski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---

As was mentioned by Paul on a previous patch, please include a
changelog.

>  drivers/net/ethernet/intel/iavf/iavf.h         |  2 ++
>  drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  3 +++
>  drivers/net/ethernet/intel/iavf/iavf_main.c    | 18
> ++++++++++++++++++
>  3 files changed, 23 insertions(+)
> 
> 
