From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 06 Jun 2017 13:14:03 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: prevent driver configuration
 changes while XDP is loaded
In-Reply-To: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
References: <20170502050634.7459.50968.stgit@john-Precision-Tower-5810>
Message-ID: <1496780043.5522.5.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-05-01 at 22:06 -0700, John Fastabend wrote:
> XDP checks to ensure the MTU is valid and LRO is disabled when it is
> loaded. But user configuration after XDP is loaded could change these
> and cause a misconfiguration.
> 
> This patch adds checks to ensure config changes are valid.
> 
> Signed-off-by: John Fastabend <john.r.fastabend@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |   17
> +++++++++++++++++
>  1 file changed, 17 insertions(+)

I know you have moved onto a new job, which is probably taking up most
of your time.  I just need to know if you will be re-spinning this
patch based on the feedback from Alex.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170606/8dd16407/attachment.asc>
