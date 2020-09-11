From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Thu, 10 Sep 2020 17:49:26 -0700
Subject: [Intel-wired-lan] [PATCH net-next 0/3] Fix some kernel-doc
 warnings for i40e
In-Reply-To: <20200910150934.34605-1-wanghai38@huawei.com>
References: <20200910150934.34605-1-wanghai38@huawei.com>
Message-ID: <20200910174926.00004f0e@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Wang Hai wrote:

> Wang Hai (3):
>   i40e: Fix some kernel-doc warnings in i40e_client.c
>   i40e: Fix some kernel-doc warnings in i40e_common.c
>   i40e: Fix a kernel-doc warning in i40e_ptp.c
> 
>  drivers/net/ethernet/intel/i40e/i40e_client.c | 2 --
>  drivers/net/ethernet/intel/i40e/i40e_common.c | 2 --
>  drivers/net/ethernet/intel/i40e/i40e_ptp.c    | 1 -
>  3 files changed, 5 deletions(-)
> 


Please see my patchset [1]: I've already fixed all of these and many
others.

In fact, before you continue, I have a whole set done making the entire
drivers/net/ethernet directory compile cleanly with W=1, that I'm about
to send, but they depend on [1]

[1]
https://patchwork.ozlabs.org/project/intel-wired-lan/list/?series=&submitter=189&state=&q=&archive=&delegate=

