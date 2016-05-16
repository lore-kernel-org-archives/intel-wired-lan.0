From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 16 May 2016 13:58:42 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: take online CPU number as MQ
 max limit when alloc_etherdev_mq()
In-Reply-To: <1463118995-31763-1-git-send-email-ethan.zhao@oracle.com>
References: <1463118995-31763-1-git-send-email-ethan.zhao@oracle.com>
Message-ID: <1463432322.2609.12.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 2016-05-13 at 14:56 +0900, Ethan Zhao wrote:
> Allocating 64 Tx/Rx as default doesn't benefit perfomrnace when less
> CPUs were assigned. especially when DCB is enabled, so we should take
> num_online_cpus() as top limit, and aslo to make sure every TC has
> at least one queue, take the MAX_TRAFFIC_CLASS as bottom limit of queues
> number.
> 
> Signed-off-by: Ethan Zhao <ethan.zhao@oracle.com>
> ---
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++++
> ?1 file changed, 4 insertions(+)

Dropping this patch based on Alex's and John's feedback.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160516/5382db22/attachment.asc>
