From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 20 Sep 2018 15:51:26 -0700
Subject: [Intel-wired-lan] [PATCH] ixgbe: reset next_to_clean and
 next_to_use when we reset the head and tail
In-Reply-To: <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EDA5B@ORSMSX104.amr.corp.intel.com>
References: <20180920104247.69280-1-sebastianx.basierski@intel.com>
 <26D9FDECA4FBDD4AADA65D8E2FC68A4A1D2EDA5B@ORSMSX104.amr.corp.intel.com>
Message-ID: <bf200806dcc78007c147128bc88c1574790f48e6.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, 2018-09-20 at 15:46 -0700, Bowers, AndrewX wrote:
> This is causing a stack trace on shutdown. Reverting the patch fixes it.

I have dropped the patch from my tree.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20180920/8aed27db/attachment.asc>
