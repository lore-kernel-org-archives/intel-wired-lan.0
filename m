From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 07 Apr 2015 15:59:05 -0700
Subject: [Intel-wired-lan] [net-next] e100: don't initialize int object
 to zero
In-Reply-To: <1428273124-14321-1-git-send-email-sakiwit@gmail.com>
References: <1428273124-14321-1-git-send-email-sakiwit@gmail.com>
Message-ID: <1428447545.28000.4.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sun, 2015-04-05 at 16:32 -0600, J?an Sacren wrote:
> From: Jean Sacren <sakiwit@gmail.com>
> 
> 'err' will be overwritten so no need to initialize it to zero.
> 
> Signed-off-by: Jean Sacren <sakiwit@gmail.com>
> ---
>  drivers/net/ethernet/intel/e100.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks Jean, I have applied your patch to my queue.
-- 
git://git.kernel.org/pub/scm/linux/kernel/git/jkirsher/next-queue.git
dev-queue
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150407/04dd4c8d/attachment-0001.asc>
