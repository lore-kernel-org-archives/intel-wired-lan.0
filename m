From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Fri, 17 Apr 2015 11:53:00 -0700
Subject: [Intel-wired-lan] [PATCH net v2] i40e: Implement
 ndo_features_check()
In-Reply-To: <1429056554-120070-1-git-send-email-jesse@nicira.com>
References: <1429056554-120070-1-git-send-email-jesse@nicira.com>
Message-ID: <1429296780.2638.113.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-14 at 17:09 -0700, Jesse Gross wrote:
> From: Joe Stringer <joestringer@nicira.com>
> 
> i40e supports UDP tunnel headers up to 80 bytes in length, so
> this adds a check to ensure that it doesn't try to offload
> packets that exceed that.
> 
> Signed-off-by: Joe Stringer <joestringer@nicira.com>
> Signed-off-by: Jesse Gross <jesse@nicira.com>
> ---
> v2: Move #define above function comment.
> ---
>  drivers/net/ethernet/intel/i40e/i40e_main.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)

Thanks Jesse and Joe, I have applied your patch to my queue.
--
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150417/fcb5ae89/attachment.asc>
