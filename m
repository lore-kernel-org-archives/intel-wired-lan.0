From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 16 May 2017 16:07:17 -0700
Subject: [Intel-wired-lan] [PATCH] i40evf: Use le32_to_cpu before
 evaluating HW desc fields.
In-Reply-To: <1493680559-6728-1-git-send-email-tushar.n.dave@oracle.com>
References: <1493680559-6728-1-git-send-email-tushar.n.dave@oracle.com>
Message-ID: <1494976037.40313.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Mon, 2017-05-01 at 16:15 -0700, Tushar Dave wrote:
> i40e hardware descriptor fields are in little-endian format. Driver
> must use le32_to_cpu while evaluating these fields otherwise on
> big-endian arch we end up evaluating incorrect values, cause errors
> like:
> 
> i40evf 0001:04:02.0: Expected response 0 from PF, received 285212672
> i40evf 0001:04:02.1: Expected response 0 from PF, received 285212672
> 
> Signed-off-by: Tushar Dave <tushar.n.dave@oracle.com>
> ---
> ?drivers/net/ethernet/intel/i40evf/i40evf_main.c | 6 ++++--
> ?1 file changed, 4 insertions(+), 2 deletions(-)

Due to recent patches already applied to my tree, this patch does not
apply cleanly.  Feel free to send an updated patch, if the change is
still needed.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20170516/a2b82788/attachment.asc>
