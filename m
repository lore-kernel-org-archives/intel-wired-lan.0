From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 18 Feb 2016 22:38:50 -0800
Subject: [Intel-wired-lan] [next PATCH S29 04/14] i40e: Add a client
 definition of I40E_MAX_USER_PRIORITY
In-Reply-To: <1455754344-6372-5-git-send-email-avinash.dayanand@intel.com>
References: <1455754344-6372-1-git-send-email-avinash.dayanand@intel.com>
 <1455754344-6372-5-git-send-email-avinash.dayanand@intel.com>
Message-ID: <1455863930.3128.67.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-17 at 16:12 -0800, Avinash Dayanand wrote:
> From: Catherine Sullivan <catherine.sullivan@intel.com>
> 
> IWARP uses I40E_MAX_USER_PRIORITY in i40e_client.h but it is not
> defined
> there so add a I40E_CLIENT_MAX_USER_PRIORITY definition to
> i40e_client.h
> and a comment to i40e.h that we need to keep the two definitions
> synced.
> 
> 
> Signed-off-by: Catherine Sullivan <catherine.sullivan@intel.com>
> Change-ID: I0fc8868c2b090f54914ab738ec52b48ae4f523e2
> ---
> Testing Hints: Make sure it compiles.
> 
> ?drivers/net/ethernet/intel/i40e/i40e.h | 3 +++
> ?1 file changed, 3 insertions(+)

Not sure how this got through review, but this should not be pushed
upstream. ?First the patch description (and code comment) refer to
i40e_client.h which does not exist in the Linux kernel AND this patch
is clearly iWARP related, so I am dropping this patch from the series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160218/19f05950/attachment.asc>
