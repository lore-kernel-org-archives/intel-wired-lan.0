From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 14 Apr 2016 19:30:52 -0700
Subject: [Intel-wired-lan] [PATCH v2 2/2] e1000e: Fix ptp time reset on
 network interruption
In-Reply-To: <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
References: <1455662685-7231-1-git-send-email-brian@walsh.ws>
 <e943a9f336c2dd089fdc6c1dafbf768bc0983075.1460517387.git.brian@walsh.ws>
Message-ID: <1460687452.2960.77.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-04-12 at 23:22 -0400, Brian Walsh wrote:
> Time is resetting on any interruption of network connectivity. This
> causes the clock to jump around by the leapsecond offset. It should
> only reset when the device is initialized.
> 
> Signed-off-by: Brian Walsh <brian@walsh.ws>
> ---
> ?drivers/net/ethernet/intel/e1000e/netdev.c | 22 +++++++++++---------
> --
> ?1 file changed, 11 insertions(+), 11 deletions(-)

Dropping this patch due to feedback and validation results.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160414/ce096622/attachment.asc>
