From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 15:58:15 -0700
Subject: [Intel-wired-lan] [PATCH v2 net-next] i40e: stop VF rings
In-Reply-To: <1428431575-168522-1-git-send-email-mitch.a.williams@intel.com>
References: <1428431575-168522-1-git-send-email-mitch.a.williams@intel.com>
Message-ID: <1428447495.28000.3.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-07 at 11:32 -0700, Mitch Williams wrote:
> Explicitly stop the rings belonging to each VF when disabling SR-IOV.
> Even though the VFs were gone, and the associated VSIs were removed,
> the rings were not stopped, and in some circumstances the hardware
> would
> continue to access the memory formerly used by the rings, causing
> memory corruption or DMAR errors, both of which would lead to general
> malaise of the kernel.
> 
> To relieve this condition, explicitly stop all the rings associated
> with
> each VF before releasing its resources.
> 
> Signed-off-by: Mitch Williams <mitch.a.williams@intel.com>
> v2: use correct variable name (changed in a different patch)
> ---
>  drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks Mitch, I have updated my queue with your patch.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/8826a4f0/attachment.asc>
