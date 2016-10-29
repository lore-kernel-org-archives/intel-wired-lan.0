From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Sat, 29 Oct 2016 00:42:21 -0700
Subject: [Intel-wired-lan] [PATCH] add one parameter wro_enable to
 enable relaxed ordering for IXGBE
In-Reply-To: <1477724932-5440-1-git-send-email-maowenan@huawei.com>
References: <1477724932-5440-1-git-send-email-maowenan@huawei.com>
Message-ID: <1477726941.2309.9.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Sat, 2016-10-29 at 15:08 +0800, Mao Wenan wrote:
> This patch provides a way to enable relaxed ordering, where it helps with
> performance in some architecture.
> The default value of wro_enable is 0, if you want to enable relaxed
> ordering, please set wro_enable=1.
> 
> Mao Wenan (1):
> ? add one parameter wro_enable for IXGBE
> 
> ?drivers/net/ethernet/intel/ixgbe/ixgbe.h??????? |? 1 +
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_82598.c? | 29 ++++++++++++++-----
> ------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_common.c | 28 +++++++++++++----
> -------
> ?drivers/net/ethernet/intel/ixgbe/ixgbe_main.c?? |? 9 ++++++++
> ?4 files changed, 41 insertions(+), 26 deletions(-)

Why have a title patch for only one patch? ?Better yet, the one patch does
not have a patch description. ?Get rid of the title patch and add the above
information into the patches description.

In addition, module parameters are not kindly looked upon, one reason is
that it cannot be standardized and enforced.

I am also confused because you are stating that on some architectures, yet
this code is only compiled in when SPARC is defined and that there are
times when you want relaxed ordering enabled and other times disabled?
?Your gonna have to provide more data on why, because the code as is was
resolving serious performance issues on SPARC when relaxed ordering was
enabled.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20161029/8b4f7b65/attachment.asc>
