From: Bowers, AndrewX <andrewx.bowers@intel.com>
Date: Tue, 19 Sep 2017 19:19:01 +0000
Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: fix use of
	uninitialized	padding
In-Reply-To: <20170911212131.27262.52988.stgit@localhost6.localdomain6>
References: <20170911212131.27262.52988.stgit@localhost6.localdomain6>
Message-ID: <26D9FDECA4FBDD4AADA65D8E2FC68A4A10EAA8EF@ORSMSX104.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> -----Original Message-----
> From: Intel-wired-lan [mailto:intel-wired-lan-bounces at osuosl.org] On
> Behalf Of Emil Tantilov
> Sent: Monday, September 11, 2017 2:22 PM
> To: intel-wired-lan at lists.osuosl.org
> Subject: [Intel-wired-lan] [PATCH 1/2] ixgbe: fix use of uninitialized padding
> 
> This patch is resolving Coverity hits where padding in a structure could be
> used uninitialized.
> 
> - Initialize fwd_cmd.pad/2 before ixgbe_calculate_checksum()
> 
> - Initialize buffer.pad2/3 before ixgbe_hic_unlocked()
> 
> Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_common.c |    4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_x550.c   |    2 ++
>  2 files changed, 4 insertions(+), 2 deletions(-)

Tested-by: Andrew Bowers <andrewx.bowers@intel.com>


