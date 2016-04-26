From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Tue, 26 Apr 2016 16:08:16 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: Disable DCB and FCoE for
 X550EM_x and x550em_a
In-Reply-To: <20160426120026.8106.64120.stgit@ukketine.jf.intel.com>
References: <20160426120026.8106.64120.stgit@ukketine.jf.intel.com>
Message-ID: <1461712096.2986.17.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2016-04-26 at 05:00 -0700, Usha Ketineni wrote:
> This patch adds IXGBE_FLAG_DCB_CAPABLE flag that is set
> for all MACs other than X550EM_x and x550em_a. DCB and
> FCoE is disabled for these MACS. DCB initialization
> code is moved to a seperate function.
> 
> Signed-off-by: Usha Ketineni <usha.k.ketineni@intel.com>

Tested-by: Ronald Bynoe <ronald.j.bynoe@intel.com>

Our validation found nothing wrong with this patch, works as expected,
thanks Usha!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160426/387ee483/attachment-0001.asc>
