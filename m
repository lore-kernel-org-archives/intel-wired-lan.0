From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Wed, 23 Aug 2017 03:43:27 -0700
Subject: [Intel-wired-lan] [RFC PATCH v2 3/6] [net-next]net: i40e:
 Extend set switch config command to accept cloud filter mode
In-Reply-To: <150296562149.16910.5659916522674039966.stgit@anamdev.jf.intel.com>
References: <150296538797.16910.13738130623106637990.stgit@anamdev.jf.intel.com>
 <150296562149.16910.5659916522674039966.stgit@anamdev.jf.intel.com>
Message-ID: <1503485007.43048.31.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2017-08-17 at 03:27 -0700, Amritha Nambiar wrote:
> Add definitions for L4 filters and switch modes based on cloud
> filters
> modes and extend the set switch config command to include the
> additional cloud filter mode.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> Signed-off-by: Kiran Patil <kiran.patil@intel.com>
> ---
>  drivers/net/ethernet/intel/i40e/i40e_adminq_cmd.h |   31
> ++++++++++++++++++++-
>  drivers/net/ethernet/intel/i40e/i40e_common.c     |    4 ++-
>  drivers/net/ethernet/intel/i40e/i40e_ethtool.c    |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_main.c       |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_prototype.h  |    2 +
>  drivers/net/ethernet/intel/i40e/i40e_type.h       |    9 ++++++
>  6 files changed, 45 insertions(+), 5 deletions(-)

Unfortunately, this does not apply (not even close).  Since you are
needing to make changes to the first set of 6 patches, please rebase
your entire set of patches to my latest tree and that should fix the
issue.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170823/874926b8/attachment.asc>
