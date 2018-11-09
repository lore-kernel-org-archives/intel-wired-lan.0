From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 08 Nov 2018 17:49:32 -0800
Subject: [Intel-wired-lan] [PATCH] e1000e: Change watchdog task to be
 delayed work
In-Reply-To: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
References: <1541290645-25033-1-git-send-email-bobbyeshleman@gmail.com>
Message-ID: <362e4f52443572ea1ff7cfa691a56a848bcdae67.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2018-11-03 at 17:17 -0700, Robert Eshleman wrote:
> This completes a pending TODO to use queue_delayed_work() instead of
> schedule_work().
> 
> Signed-off-by: Robert Eshleman <bobbyeshleman@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)

Dropping this patch due to the problems seen with it applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20181108/cfcd8479/attachment.asc>
