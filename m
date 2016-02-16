From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Mon, 15 Feb 2016 19:57:42 -0800
Subject: [Intel-wired-lan] [PATCH 1/6] fm10k: Avoid crashing the kernel
In-Reply-To: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
References: <1455144351-14758-1-git-send-email-jacob.e.keller@intel.com>
Message-ID: <1455595062.7797.1.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Wed, 2016-02-10 at 14:45 -0800, Jacob Keller wrote:
> From: Bruce Allan <bruce.w.allan@intel.com>
> 
> Use BUILD_BUG_ON() instead of BUG_ON() where appropriate to get a
> compile
> error rather than crash the kernel.
> 
> Signed-off-by: Bruce Allan <bruce.w.allan@intel.com>
> ---
> This is a direct copy of a patch from our out-of-tree driver written
> by Bruce, hence the authorship and signed-off-by line.
> 
> ?drivers/net/ethernet/intel/fm10k/fm10k_ethtool.c | 4 ++--
> ?1 file changed, 2 insertions(+), 2 deletions(-)

Guess you did not bother to compile test this, because it still causes
the same compile errors it did the first time Bruce submitted it.
?Dropping this patch, like I did the first time it was submitted.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20160215/755d8d67/attachment.asc>
