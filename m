From: John Fastabend <john.fastabend@gmail.com>
Date: Fri, 21 Apr 2017 15:25:38 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Fix build issues seen w/ XDP
In-Reply-To: <20170421222233.13851.98515.stgit@localhost.localdomain>
References: <20170421222233.13851.98515.stgit@localhost.localdomain>
Message-ID: <58FA86E2.5000707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 17-04-21 03:22 PM, Alexander Duyck wrote:
> From: Alexander Duyck <alexander.h.duyck@intel.com>
> 
> This patch is meant to fix the build issues seen w/ XDP when page sizes are
> larger than 4K.
> 
> Signed-off-by: Alexander Duyck <alexander.h.duyck@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>

Thanks! I just noticed this and you already have the patch.

Acked-by: John Fastabend <john.r.fastabend@intel.com>

