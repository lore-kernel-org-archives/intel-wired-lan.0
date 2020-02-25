From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 25 Feb 2020 13:15:46 -0800
Subject: [Intel-wired-lan] [patch net-next] iavf: use
 tc_cls_can_offload_basic() instead of chain check
In-Reply-To: <20200225121023.6011-1-jiri@resnulli.us>
References: <20200225121023.6011-1-jiri@resnulli.us>
Message-ID: <469b51add666cf3df7381b6409a3972c70024c12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2020-02-25 at 13:10 +0100, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@mellanox.com>
> 
> Looks like the iavf code actually experienced a race condition, when
> a
> developer took code before the check for chain 0 was put to helper.
> So use tc_cls_can_offload_basic() helper instead of direct check and
> move the check to _cb() so this is similar to i40e code.
> 
> Signed-off-by: Jiri Pirko <jiri@mellanox.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

Go ahead and pick this up Dave, thanks!

> ---
> This was originally part of "net: allow user specify TC filter HW
> stats type"
> patchset, but it is no longer related after the requested changes.
> Sending separatelly.
> ---
>  drivers/net/ethernet/intel/iavf/iavf_main.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20200225/50d89acb/attachment.asc>
