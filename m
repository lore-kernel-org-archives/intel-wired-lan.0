From: John Fastabend <john.fastabend@gmail.com>
Date: Wed, 17 Feb 2016 16:09:22 -0800
Subject: [Intel-wired-lan] [PATCH] ixgbe: make __ixgbe_setup_tc static
In-Reply-To: <20160217235506.31327.63137.stgit@localhost6.localdomain6>
References: <20160217235506.31327.63137.stgit@localhost6.localdomain6>
Message-ID: <56C50BB2.1070003@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 16-02-17 03:55 PM, Emil Tantilov wrote:
> This function is only used in ixgbe_main.c
> Resolves a "missing prototype" warning when building the driver with W=1
> 
> Reported-by: Phil Schmitt <phillip.j.schmitt@intel.com>
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---

Acked-by: John Fastabend <john.r.fastabend@intel.com>

Yep missed this thanks.
