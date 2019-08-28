From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Wed, 28 Aug 2019 16:22:26 +0000
Subject: [Intel-wired-lan] [PATCH] net: ixgbe: fix memory leaks
In-Reply-To: <1565554067-4994-1-git-send-email-wenwen@cs.uga.edu>
References: <1565554067-4994-1-git-send-email-wenwen@cs.uga.edu>
Message-ID: <2fb9767372fa4d5aaaab74c7e60561fe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Wenwen Wang
> Sent: Sunday, August 11, 2019 1:08 PM
> To: Wenwen Wang <wenwen@cs.uga.edu>
> Cc: open list:NETWORKING DRIVERS <netdev@vger.kernel.org>; moderated
> list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org>; open list
> <linux-kernel@vger.kernel.org>; David S. Miller <davem@davemloft.net>
> Subject: [Intel-wired-lan] [PATCH] net: ixgbe: fix memory leaks
> 
> In ixgbe_configure_clsu32(), 'jump', 'input', and 'mask' are allocated through
> kzalloc() respectively in a for loop body. Then,
> ixgbe_clsu32_build_input() is invoked to build the input. If this process fails,
> next iteration of the for loop will be executed. However, the allocated
> 'jump', 'input', and 'mask' are not deallocated on this execution path, leading
> to memory leaks.
> 
> Signed-off-by: Wenwen Wang <wenwen@cs.uga.edu>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
>  1 file changed, 4 insertions(+)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


