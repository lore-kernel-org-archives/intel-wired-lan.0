From: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Date: Thu, 30 Apr 2015 06:01:46 -0700
Subject: [Intel-wired-lan] [PATCH net 2/3] bridge/nl: remove wrong use
	of NLM_F_MULTI
In-Reply-To: <1430238831-29966-3-git-send-email-nicolas.dichtel@6wind.com>
References: <1430238831-29966-1-git-send-email-nicolas.dichtel@6wind.com>
 <1430238831-29966-3-git-send-email-nicolas.dichtel@6wind.com>
Message-ID: <1430398906.2669.111.camel@jtkirshe-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Tue, 2015-04-28 at 18:33 +0200, Nicolas Dichtel wrote:
> NLM_F_MULTI must be used only when a NLMSG_DONE message is sent. In
> fact,
> it is sent only at the end of a dump.
> 
> Libraries like libnl will wait forever for NLMSG_DONE.
> 
> Fixes: e5a55a898720 ("net: create generic bridge ops")
> Fixes: 815cccbf10b2 ("ixgbe: add setlink, getlink support to ixgbe and
> ixgbevf")
> CC: John Fastabend <john.r.fastabend@intel.com>
> CC: Sathya Perla <sathya.perla@emulex.com>
> CC: Subbu Seetharaman <subbu.seetharaman@emulex.com>
> CC: Ajit Khaparde <ajit.khaparde@emulex.com>
> CC: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
> CC: intel-wired-lan at lists.osuosl.org
> CC: Jiri Pirko <jiri@resnulli.us>
> CC: Scott Feldman <sfeldma@gmail.com>
> CC: Stephen Hemminger <stephen@networkplumber.org>
> CC: bridge at lists.linux-foundation.org
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

Acked-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

For the i40e and ixgbe driver changes

> ---
>  drivers/net/ethernet/emulex/benet/be_main.c   |  5 +++--
>  drivers/net/ethernet/intel/i40e/i40e_main.c   |  7 ++++---
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c |  4 ++--
>  drivers/net/ethernet/rocker/rocker.c          |  5 +++--
>  include/linux/netdevice.h                     |  6 ++++--
>  include/linux/rtnetlink.h                     |  2 +-
>  net/bridge/br_netlink.c                       |  4 ++--
>  net/bridge/br_private.h                       |  2 +-
>  net/core/rtnetlink.c                          | 12 +++++++-----
>  9 files changed, 27 insertions(+), 20 deletions(-)


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: This is a digitally signed message part
URL: <http://lists.osuosl.org/pipermail/intel-wired-lan/attachments/20150430/10f92f5c/attachment.asc>
